import 'dart:convert';
import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/utils/local_date.dart';
import 'package:stopcorn/features/progress/domain/initial_profile.dart';
import 'package:stopcorn/features/progress/domain/progress_dashboard.dart';
import 'package:stopcorn/features/progress/domain/progress_period.dart';

part 'progress_repository.g.dart';

/// Longest history the weekly chart displays, in local calendar days.
const int _chartDayCount = 90;

/// Aggregates local records into descriptive progress markers.
final class ProgressRepository {
  /// Local relational store used for progress aggregation.
  final AppDatabase _database;

  /// Creates a repository backed by [database].
  const ProgressRepository(this._database);

  /// Watches dashboard aggregates for [period] anchored to [now].
  Stream<ProgressDashboard> watchDashboard({
    required ProgressPeriod period,
    required DateTime now,
  }) => _database
      .customSelect(
        'SELECT 1 AS revision',
        readsFrom: {
          _database.goals,
          _database.urgeSessions,
          _database.consumptionEvents,
          _database.dailyCheckIns,
          _database.copingStrategyUses,
          _database.selfAssessments,
        },
      )
      .watch()
      .asyncMap(
        (_) => loadDashboard(period: period, now: now),
      );

  /// Watches the earliest baseline assessment and its initial goal context.
  Stream<InitialProfile?> watchInitialProfile() => _database
      .customSelect(
        'SELECT 1 AS revision',
        readsFrom: {
          _database.goals,
          _database.selfAssessments,
        },
      )
      .watch()
      .asyncMap((_) => loadInitialProfile());

  /// Loads the earliest baseline assessment and its initial goal context.
  Future<InitialProfile?> loadInitialProfile() async => _buildInitialProfile(
    initialGoal: await _initialGoal(),
    baseline: await _initialBaseline(),
  );

  /// Computes one immutable dashboard from current local records.
  ///
  /// Every query is bounded by the window the dashboard actually reads, so the
  /// work stays proportional to the selected period rather than to the whole
  /// local history.
  Future<ProgressDashboard> loadDashboard({
    required ProgressPeriod period,
    required DateTime now,
  }) async {
    DateTime localNow = now.toLocal();
    DateTime today = startOfLocalDay(localNow);
    DateTime tomorrow = addLocalDays(today, 1);
    DateTime? appStart = await _appStart();
    DateTime periodStart = startOfLocalDay(
      period.dayCount == null ? (appStart ?? today) : addLocalDays(today, -(period.dayCount! - 1)),
    );

    // The preceding comparable period, the current calendar week, and the first
    // week of the chart can each begin before the period itself.
    int? comparableDays = period.dayCount;
    DateTime? previousStart = comparableDays == null ? null : addLocalDays(periodStart, -comparableDays);
    DateTime chartFloor = addLocalDays(today, -_chartDayCount);
    DateTime chartStart = periodStart.isBefore(chartFloor) ? chartFloor : periodStart;
    DateTime firstWeek = _startOfWeek(chartStart);
    DateTime currentWeekStart = _startOfWeek(today);
    DateTime windowStart = [
      periodStart,
      ?previousStart,
      firstWeek,
      currentWeekStart,
    ].reduce((first, second) => first.isBefore(second) ? first : second);

    List<ConsumptionEvent> windowEvents = await _eventsBetween(windowStart, tomorrow);
    List<UrgeSession> urges = await _urgesBetween(periodStart, tomorrow);
    List<CopingStrategyUse> uses = await _strategyUsesBetween(periodStart, tomorrow);
    List<DailyCheckIn> checkIns = await _checkInsBetween(periodStart, today);
    Goal? activeGoal = await _activeGoal();

    bool isInPeriod(DateTime value) {
      DateTime local = value.toLocal();
      return !local.isBefore(periodStart) && local.isBefore(tomorrow);
    }

    List<ConsumptionEvent> events = windowEvents.where((event) => isInPeriod(event.occurredAt)).toList();

    double? changePercent;
    if (previousStart != null) {
      int previousCount = windowEvents.where((event) {
        DateTime local = event.occurredAt.toLocal();
        return !local.isBefore(previousStart) && local.isBefore(periodStart);
      }).length;
      if (previousCount > 0) {
        changePercent = ((events.length - previousCount) / previousCount) * 100;
      }
    }

    DateTime? observedStart = switch (appStart) {
      null => null,
      DateTime value when value.isAfter(periodStart) => value,
      _ => periodStart,
    };
    int observedDayCount = observedStart == null ? 0 : localDaysBetween(observedStart, today) + 1;
    Set<String> eventDays = events.map((event) => localDateKey(event.occurredAt)).toSet();
    int daysWithoutEvents = math.max(0, observedDayCount - eventDays.length);

    Iterable<UrgeSession> completedUrges = urges.where(
      (urge) => urge.completedAt != null && urge.outcome != null && urge.outcome != UrgeOutcome.abandoned.name,
    );
    List<UrgeSession> urgesWithFinal = completedUrges.where((urge) => urge.finalIntensity != null).toList();
    double? averageInitial = completedUrges.isEmpty
        ? null
        : _average(
            completedUrges.map((urge) => urge.initialIntensity.toDouble()),
          );
    double? averageFinal = urgesWithFinal.isEmpty
        ? null
        : _average(
            urgesWithFinal.map((urge) => urge.finalIntensity!.toDouble()),
          );
    double? averageDecrease = urgesWithFinal.isEmpty
        ? null
        : _average(
            urgesWithFinal.map(
              (urge) => (urge.initialIntensity - urge.finalIntensity!).toDouble(),
            ),
          );

    Map<String, int> triggerCounts = {};
    Map<String, int> emotionCounts = {};
    for (UrgeSession urge in urges) {
      _increment(triggerCounts, urge.triggerType);
      _increment(emotionCounts, urge.emotionType);
    }
    for (ConsumptionEvent event in events) {
      _increment(triggerCounts, event.triggerType);
      _increment(emotionCounts, event.emotionType);
    }

    Map<String, List<CopingStrategyUse>> strategyUses = {};
    for (CopingStrategyUse use in uses) {
      strategyUses.putIfAbsent(use.strategyId, () => []).add(use);
    }
    List<StrategyMetric> strategyMetrics =
        strategyUses.entries.map((entry) {
          List<double> effects = entry.value.map((use) => use.perceivedEffect).whereType<int>().map((effect) => effect.toDouble()).toList();
          return StrategyMetric(
            strategyId: entry.key,
            useCount: entry.value.length,
            evaluatedUseCount: effects.length,
            averageEffect: effects.isEmpty ? null : _average(effects),
          );
        }).toList()..sort((first, second) {
          int effectComparison = (second.averageEffect ?? double.negativeInfinity).compareTo(
            first.averageEffect ?? double.negativeInfinity,
          );
          return effectComparison != 0 ? effectComparison : second.useCount.compareTo(first.useCount);
        });

    List<int> bucketCounts = List<int>.filled(6, 0);
    for (int hour in [
      ...urges.map((urge) => urge.startedAt.toLocal().hour),
      ...events.map((event) => event.occurredAt.toLocal().hour),
    ]) {
      bucketCounts[(hour ~/ 4).clamp(0, 5)]++;
    }
    List<TimeBucketMetric> timeBuckets = [
      for (int index = 0; index < bucketCounts.length; index++)
        TimeBucketMetric(
          startHour: index * 4,
          endHourExclusive: (index + 1) * 4,
          count: bucketCounts[index],
        ),
    ];

    // Each bar counts its complete calendar week, including the days of the
    // first week that precede the period. Counting only the days inside the
    // period would draw an opening bar that reads as a drop rather than as the
    // partial week it actually is.
    List<WeeklyEventPoint> weeklyEvents = [];
    for (DateTime week = firstWeek; !week.isAfter(today); week = addLocalDays(week, 7)) {
      DateTime nextWeek = addLocalDays(week, 7);
      int count = windowEvents.where((event) {
        DateTime local = event.occurredAt.toLocal();
        return !local.isBefore(week) && local.isBefore(nextWeek);
      }).length;
      weeklyEvents.add(WeeklyEventPoint(weekStart: week, eventCount: count));
    }

    GoalType? activeGoalType = enumFromStoredValueOrNull(GoalType.values, activeGoal?.type);
    int? weeklyLimit = activeGoalType == .reduction ? activeGoal?.weeklyLimit : null;
    List<String> activeGoalContextKeys = activeGoalType == .contextual ? _decodeStringList(activeGoal?.contextKeysJson) : const [];
    Set<String> activeGoalContextSet = activeGoalContextKeys.toSet();
    int? contextualGoalEventCount = activeGoalType == .contextual ? events.where((event) => _decodeStringList(event.contextKeysJson).any(activeGoalContextSet.contains)).length : null;
    int? currentWeekEvents = weeklyLimit == null
        ? null
        : windowEvents.where((event) {
            DateTime local = event.occurredAt.toLocal();
            return !local.isBefore(currentWeekStart) && local.isBefore(tomorrow);
          }).length;

    return ProgressDashboard(
      period: period,
      periodStart: periodStart,
      eventCount: events.length,
      eventChangePercent: changePercent,
      daysWithoutRecordedEvent: daysWithoutEvents,
      observedDayCount: observedDayCount,
      completedUrgeSessions: completedUrges.length,
      averageInitialIntensity: averageInitial,
      averageFinalIntensity: averageFinal,
      averageIntensityDecrease: averageDecrease,
      checkInCount: checkIns.length,
      averageMood: checkIns.isEmpty ? null : _average(checkIns.map((checkIn) => checkIn.moodScore.toDouble())),
      averageControl: checkIns.isEmpty
          ? null
          : _average(
              checkIns.map((checkIn) => checkIn.controlScore.toDouble()),
            ),
      triggerRanking: _ranking(triggerCounts),
      emotionRanking: _ranking(emotionCounts),
      strategyMetrics: List<StrategyMetric>.unmodifiable(strategyMetrics),
      timeBuckets: List<TimeBucketMetric>.unmodifiable(timeBuckets),
      weeklyEvents: List<WeeklyEventPoint>.unmodifiable(weeklyEvents),
      weeklyGoalLimit: weeklyLimit,
      currentWeekEventCount: currentWeekEvents,
      activeGoalType: activeGoalType,
      activeGoalContextKeys: List<String>.unmodifiable(activeGoalContextKeys),
      contextualGoalEventCount: contextualGoalEventCount,
      initialProfile: _buildInitialProfile(
        initialGoal: await _initialGoal(),
        baseline: await _initialBaseline(),
      ),
    );
  }

  /// Loads voluntarily recorded events from [start] until [endExclusive].
  Future<List<ConsumptionEvent>> _eventsBetween(
    DateTime start,
    DateTime endExclusive,
  ) =>
      (_database.select(_database.consumptionEvents)..where(
            (event) => event.occurredAt.isBiggerOrEqualValue(start.toUtc()) & event.occurredAt.isSmallerThanValue(endExclusive.toUtc()),
          ))
          .get();

  /// Loads urge sessions started from [start] until [endExclusive].
  Future<List<UrgeSession>> _urgesBetween(
    DateTime start,
    DateTime endExclusive,
  ) =>
      (_database.select(_database.urgeSessions)..where(
            (urge) => urge.startedAt.isBiggerOrEqualValue(start.toUtc()) & urge.startedAt.isSmallerThanValue(endExclusive.toUtc()),
          ))
          .get();

  /// Loads strategy uses recorded from [start] until [endExclusive].
  Future<List<CopingStrategyUse>> _strategyUsesBetween(
    DateTime start,
    DateTime endExclusive,
  ) =>
      (_database.select(_database.copingStrategyUses)..where(
            (use) => use.usedAt.isBiggerOrEqualValue(start.toUtc()) & use.usedAt.isSmallerThanValue(endExclusive.toUtc()),
          ))
          .get();

  /// Loads the check-ins whose local date falls between [start] and [end].
  Future<List<DailyCheckIn>> _checkInsBetween(DateTime start, DateTime end) =>
      (_database.select(_database.dailyCheckIns)..where(
            (checkIn) => checkIn.localDate.isBiggerOrEqualValue(localDateKey(start)) & checkIn.localDate.isSmallerOrEqualValue(localDateKey(end)),
          ))
          .get();

  /// Loads the most recently started active goal.
  Future<Goal?> _activeGoal() {
    SimpleSelectStatement<$GoalsTable, Goal> query = _database.select(_database.goals)
      ..where((goal) => goal.isActive.equals(true))
      ..orderBy(<OrderingTerm Function($GoalsTable)>[
        ($GoalsTable goal) => OrderingTerm.desc(goal.startedAt),
      ])
      ..limit(1);
    return query.getSingleOrNull();
  }

  /// Loads the very first goal the person set.
  Future<Goal?> _initialGoal() {
    SimpleSelectStatement<$GoalsTable, Goal> query = _database.select(_database.goals)
      ..orderBy(<OrderingTerm Function($GoalsTable)>[
        ($GoalsTable goal) => OrderingTerm.asc(goal.createdAt),
      ])
      ..limit(1);
    return query.getSingleOrNull();
  }

  /// Loads the earliest baseline self-assessment.
  Future<SelfAssessment?> _initialBaseline() {
    SimpleSelectStatement<$SelfAssessmentsTable, SelfAssessment> query = _database.select(_database.selfAssessments)
      ..where(
        (assessment) => assessment.kind.equals(AssessmentKind.baseline.name),
      )
      ..orderBy(<OrderingTerm Function($SelfAssessmentsTable)>[
        ($SelfAssessmentsTable assessment) => OrderingTerm.asc(assessment.recordedAt),
      ])
      ..limit(1);
    return query.getSingleOrNull();
  }

  /// Combines the first [baseline] and [initialGoal] into the original profile.
  InitialProfile? _buildInitialProfile({
    required Goal? initialGoal,
    required SelfAssessment? baseline,
  }) {
    if (baseline == null) {
      return null;
    }
    return InitialProfile(
      recordedAt: baseline.recordedAt,
      goalType: enumFromStoredValueOrNull(GoalType.values, initialGoal?.type),
      weeklyLimit: initialGoal?.weeklyLimit,
      contextKeys: List<String>.unmodifiable(
        _decodeStringList(initialGoal?.contextKeysJson),
      ),
      motivation: initialGoal?.motivation,
      weeklyFrequency: baseline.weeklyFrequency,
      perceivedControl: baseline.perceivedControl,
      negativeImpact: baseline.negativeImpact,
      confidenceToChange: baseline.confidenceToChange,
    );
  }

  /// Returns local midnight on the Monday opening [dateTime]'s week.
  DateTime _startOfWeek(DateTime dateTime) => addLocalDays(
    dateTime,
    -(dateTime.weekday - DateTime.monday),
  );

  /// Decodes a JSON string array while tolerating legacy invalid content.
  List<String> _decodeStringList(String? encoded) {
    if (encoded == null || encoded.isEmpty) {
      return const [];
    }
    try {
      Object? decoded = jsonDecode(encoded);
      return decoded is List ? decoded.whereType<String>().toList() : const [];
    } on FormatException {
      return const [];
    }
  }

  /// Finds the earliest local day represented by any user-owned record.
  ///
  /// Each source is reduced by the database instead of being read into memory:
  /// only the oldest timestamp of every table matters here.
  Future<DateTime?> _appStart() async {
    List<DateTime?> candidates = await Future.wait([
      _earliestDateTime(_database.goals, _database.goals.createdAt),
      _earliestDateTime(
        _database.consumptionEvents,
        _database.consumptionEvents.occurredAt,
      ),
      _earliestDateTime(
        _database.urgeSessions,
        _database.urgeSessions.startedAt,
      ),
      _earliestCheckInDate(),
    ]);
    List<DateTime> known = candidates.whereType<DateTime>().toList()..sort();
    return known.isEmpty ? null : startOfLocalDay(known.first);
  }

  /// Reads the oldest value of [column] in [table], or `null` when it is empty.
  Future<DateTime?> _earliestDateTime(
    ResultSetImplementation<HasResultSet, dynamic> table,
    GeneratedColumn<DateTime> column,
  ) async {
    Expression<DateTime> earliest = column.min();
    TypedResult row = await (_database.selectOnly(table)..addColumns([earliest])).getSingle();
    return row.read(earliest)?.toLocal();
  }

  /// Reads the oldest local check-in date, or `null` when none exists.
  Future<DateTime?> _earliestCheckInDate() async {
    Expression<String> earliest = _database.dailyCheckIns.localDate.min();
    TypedResult row = await (_database.selectOnly(
      _database.dailyCheckIns,
    )..addColumns([earliest])).getSingle();
    String? value = row.read(earliest);
    return value == null ? null : DateTime.tryParse(value);
  }

  /// Sorts keyed counts by descending frequency and stable key.
  List<CountMetric> _ranking(Map<String, int> values) {
    List<MapEntry<String, int>> entries = values.entries.toList()
      ..sort((first, second) {
        int count = second.value.compareTo(first.value);
        return count != 0 ? count : first.key.compareTo(second.key);
      });
    return List<CountMetric>.unmodifiable(
      entries.map((entry) => CountMetric(key: entry.key, count: entry.value)),
    );
  }

  /// Increments a non-empty optional [key] inside [target].
  void _increment(Map<String, int> target, String? key) {
    if (key != null && key.isNotEmpty) {
      target.update(key, (count) => count + 1, ifAbsent: () => 1);
    }
  }

  /// Computes the arithmetic mean of a known non-empty iterable.
  double _average(Iterable<double> values) {
    List<double> list = values.toList();
    return list.reduce((first, second) => first + second) / list.length;
  }
}

/// Provides the database-backed progress repository.
@Riverpod(keepAlive: true)
ProgressRepository progressRepository(Ref ref) => ProgressRepository(ref.watch(appDatabaseProvider));
