import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/current_app_day_provider.dart';
import 'package:stopcorn/core/utils/local_date.dart';
import 'package:stopcorn/features/home/domain/home_summary.dart';

part 'home_repository.g.dart';

/// Aggregates local records into the privacy-safe home summary.
final class HomeRepository {
  /// Local relational store used to aggregate the home summary.
  final AppDatabase _database;

  /// Creates a repository backed by [database].
  const HomeRepository(this._database);

  /// Watches a summary anchored to the supplied [now].
  Stream<HomeSummary> watchSummary(DateTime now) {
    Stream<List<QueryRow>> changes = _database
        .customSelect(
          'SELECT 1 AS revision',
          readsFrom: <ResultSetImplementation<dynamic, dynamic>>{
            _database.goals,
            _database.urgeSessions,
            _database.consumptionEvents,
            _database.dailyCheckIns,
            _database.copingStrategyUses,
            _database.copingStrategies,
          },
        )
        .watch();
    return changes.asyncMap((_) => _loadSummary(now));
  }

  /// Computes one home summary anchored to [now].
  Future<HomeSummary> _loadSummary(DateTime now) async {
    DateTime localNow = now.toLocal();
    DateTime today = startOfLocalDay(localNow);
    DateTime thirtyDayStart = addLocalDays(today, -29);

    SimpleSelectStatement<$GoalsTable, Goal> activeGoalQuery = _database.select(_database.goals)
      ..where((goal) => goal.isActive.equals(true))
      ..orderBy(<OrderingTerm Function($GoalsTable)>[
        ($GoalsTable goal) => OrderingTerm.desc(goal.startedAt),
      ])
      ..limit(1);
    Goal? activeGoal = await activeGoalQuery.getSingleOrNull();

    SimpleSelectStatement<$GoalsTable, Goal> allGoalsQuery = _database.select(_database.goals)
      ..orderBy(<OrderingTerm Function($GoalsTable)>[
        ($GoalsTable goal) => OrderingTerm.asc(goal.createdAt),
      ])
      ..limit(1);
    Goal? firstGoal = await allGoalsQuery.getSingleOrNull();

    List<UrgeSession> urges =
        await (_database.select(_database.urgeSessions)..where(
              (session) => session.startedAt.isBiggerOrEqualValue(
                thirtyDayStart.toUtc(),
              ),
            ))
            .get();
    List<ConsumptionEvent> events =
        await (_database.select(_database.consumptionEvents)..where(
              (event) => event.occurredAt.isBiggerOrEqualValue(thirtyDayStart.toUtc()),
            ))
            .get();
    List<DailyCheckIn> checkIns = await _database.select(_database.dailyCheckIns).get();

    String todayKey = localDateKey(localNow);
    int urgesToday = urges.where((session) => localDateKey(session.startedAt) == todayKey).length;
    int traversed = urges
        .where(
          (session) => {
            UrgeOutcome.passed.name,
            UrgeOutcome.reduced.name,
            UrgeOutcome.delayed.name,
          }.contains(session.outcome),
        )
        .length;

    DateTime appStart = firstGoal == null ? today : startOfLocalDay(firstGoal.createdAt);
    DateTime observedStart = appStart.isAfter(thirtyDayStart) ? appStart : thirtyDayStart;
    int observedDays = localDaysBetween(observedStart, today) + 1;
    Set<String> eventDays = events.map((event) => localDateKey(event.occurredAt)).toSet();
    int daysWithoutEvents = (observedDays - eventDays.length).clamp(0, 30);

    List<DailyCheckIn> recentCheckIns = checkIns
        .where(
          (checkIn) => checkIn.localDate.compareTo(localDateKey(thirtyDayStart)) >= 0,
        )
        .toList();
    double? averageControl = recentCheckIns.isEmpty ? null : recentCheckIns.map((checkIn) => checkIn.controlScore).reduce((first, second) => first + second) / recentCheckIns.length;

    JoinedSelectStatement<HasResultSet, dynamic> helpfulQuery =
        _database.select(_database.copingStrategyUses).join([
            innerJoin(
              _database.copingStrategies,
              _database.copingStrategies.id.equalsExp(
                _database.copingStrategyUses.strategyId,
              ),
            ),
          ])
          ..where(
            _database.copingStrategyUses.perceivedEffect.isBiggerThanValue(0),
          )
          ..orderBy([
            OrderingTerm.desc(_database.copingStrategyUses.usedAt),
          ])
          ..limit(1);
    TypedResult? helpfulRow = await helpfulQuery.getSingleOrNull();
    CopingStrategy? helpfulStrategy = helpfulRow?.readTable(_database.copingStrategies);

    return HomeSummary(
      goalType: enumFromStoredValueOrNull(GoalType.values, activeGoal?.type),
      motivation: activeGoal?.motivation,
      weeklyLimit: activeGoal?.weeklyLimit,
      contextKeys: _decodeStringList(activeGoal?.contextKeysJson),
      checkInCompletedToday: checkIns.any(
        (checkIn) => checkIn.localDate == todayKey,
      ),
      urgesToday: urgesToday,
      daysWithoutRecordedConsumption: daysWithoutEvents,
      traversedUrges: traversed,
      averageControl: averageControl,
      lastHelpfulStrategyId: helpfulStrategy?.id,
      hasObservations: urges.isNotEmpty || events.isNotEmpty || checkIns.isNotEmpty,
    );
  }

  /// Decodes contextual-goal keys without breaking the home dashboard.
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
}

/// Provides the database-backed home repository.
@Riverpod(keepAlive: true)
HomeRepository homeRepository(Ref ref) => HomeRepository(ref.watch(appDatabaseProvider));

/// Watches the current home summary.
@riverpod
Stream<HomeSummary> homeSummary(Ref ref) {
  ref.watch(currentAppDayProvider);
  return ref.watch(homeRepositoryProvider).watchSummary(ref.watch(appClockProvider).now());
}
