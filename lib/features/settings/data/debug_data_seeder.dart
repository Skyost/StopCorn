import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/utils/local_date.dart';

part 'debug_data_seeder.g.dart';

/// Populates the real local database with coherent debug-only sample history.
final class DebugDataSeeder {
  /// Prefix reserved for synthetic records with text identifiers.
  static const String _idPrefix = 'debug-sample';

  /// Marker used to identify synthetic check-ins whose primary key is a date.
  static const String _checkInMarker = '[StopCorn debug sample] A short, non-explicit daily note.';

  /// General contexts rotated through synthetic consumption history.
  static const List<String> _eventContexts = [
    'Evening routine',
    'Quiet time at home',
    'After a demanding day',
  ];

  /// Non-explicit notes rotated through synthetic consumption history.
  static const List<String> _eventNotes = [
    'A short sample marker for the journal.',
    'Noticed the context after the event.',
    'A general note without browsing details.',
  ];

  /// Days before the anchor date on which sample events are recorded.
  static const List<int> _eventOffsets = [
    58,
    54,
    50,
    47,
    44,
    41,
    38,
    34,
    31,
    27,
    22,
    17,
    11,
    6,
    2,
  ];

  /// Days before the anchor date on which sample urge flows are completed.
  static const List<int> _urgeOffsets = [
    28,
    24,
    21,
    18,
    15,
    12,
    9,
    6,
    4,
    2,
    1,
    0,
  ];

  /// Days before the anchor date on which sample check-ins are recorded.
  static const List<int> _checkInOffsets = [
    29,
    25,
    21,
    17,
    13,
    9,
    5,
    4,
    3,
    2,
    1,
    0,
  ];

  /// Trigger values rotated through the synthetic history.
  static const List<TriggerType> _triggers = [
    .stress,
    .boredom,
    .bedtimePhone,
    .fatigue,
    .habit,
    .socialMedia,
  ];

  /// Emotion values rotated through the synthetic history.
  static const List<EmotionType> _emotions = [
    .anxious,
    .bored,
    .tired,
    .stressed,
    .calm,
  ];

  /// Strategy identifiers rotated through synthetic urge flows.
  static const List<String> _strategyIds = [
    'put-phone-away',
    'walk-five-minutes',
    'slow-breathing',
    'message-someone',
  ];

  /// Local relational store receiving the sample history.
  final AppDatabase _database;

  /// Creates a sample-data seeder backed by [database].
  const DebugDataSeeder(
    this._database,
  );

  /// Replaces prior synthetic records with samples anchored to [now].
  Future<void> seed(DateTime now) async {
    if (!kDebugMode) {
      throw UnsupportedError(
        'Sample data is available only in debug builds.',
      );
    }
    DateTime localNow = now.toLocal();
    DateTime today = DateTime(
      localNow.year,
      localNow.month,
      localNow.day,
    );
    await _database.seedBuiltInStrategies(now);
    await _database.transaction(() async {
      await _deletePreviousSamples();
      await _insertHistoricalGoal(today);
      await _insertConsumptionEvents(today);
      await _insertUrgeSessions(today);
      await _insertCheckIns(today);
      await _insertAssessments(today);
      await _insertModuleProgress(today);
    });
  }

  /// Deletes only records created by a previous sample-data load.
  Future<void> _deletePreviousSamples() async {
    await (_database.delete(
      _database.copingStrategyUses,
    )..where((row) => row.id.like('$_idPrefix-%'))).go();
    await (_database.delete(
      _database.urgeSessions,
    )..where((row) => row.id.like('$_idPrefix-%'))).go();
    await (_database.delete(
      _database.consumptionEvents,
    )..where((row) => row.id.like('$_idPrefix-%'))).go();
    await (_database.delete(
      _database.selfAssessments,
    )..where((row) => row.id.like('$_idPrefix-%'))).go();
    await (_database.delete(
      _database.goals,
    )..where((row) => row.id.like('$_idPrefix-%'))).go();
    await (_database.delete(
      _database.dailyCheckIns,
    )..where((row) => row.note.equals(_checkInMarker))).go();
  }

  /// Inserts one inactive historical goal without replacing the active goal.
  Future<void> _insertHistoricalGoal(DateTime today) async {
    DateTime startedAt = _at(today, daysAgo: 60, hour: 9);
    DateTime endedAt = _at(today, daysAgo: 40, hour: 18);
    await _database
        .into(_database.goals)
        .insert(
          GoalsCompanion.insert(
            id: '$_idPrefix-goal',
            createdAt: startedAt,
            updatedAt: endedAt,
            type: GoalType.reduction.name,
            isActive: const Value(false),
            weeklyLimit: const Value(5),
            startedAt: startedAt,
            endedAt: Value(endedAt),
          ),
        );
  }

  /// Inserts voluntary events distributed across the previous two months.
  Future<void> _insertConsumptionEvents(DateTime today) async {
    for (int index = 0; index < _eventOffsets.length; index++) {
      DateTime occurredAt = _at(
        today,
        daysAgo: _eventOffsets[index],
        hour: 20 + index % 3,
      );
      await _database
          .into(_database.consumptionEvents)
          .insert(
            ConsumptionEventsCompanion.insert(
              id: '$_idPrefix-event-$index',
              occurredAt: occurredAt,
              triggerType: Value(
                _triggers[index % _triggers.length].name,
              ),
              emotionType: Value(
                _emotions[index % _emotions.length].name,
              ),
              contextLabel: Value(
                _eventContexts[index % _eventContexts.length],
              ),
              perceivedControl: Value(3 + index % 5),
              notes: Value(
                _eventNotes[index % _eventNotes.length],
              ),
              createdAt: occurredAt.add(
                const Duration(minutes: 2),
              ),
            ),
          );
    }
  }

  /// Inserts completed urge flows and their evaluated strategy uses.
  Future<void> _insertUrgeSessions(DateTime today) async {
    for (int index = 0; index < _urgeOffsets.length; index++) {
      String sessionId = '$_idPrefix-urge-$index';
      String strategyId = _strategyIds[index % _strategyIds.length];
      DateTime startedAt = _at(
        today,
        daysAgo: _urgeOffsets[index],
        hour: 18 + index % 5,
      );
      DateTime completedAt = startedAt.add(
        const Duration(minutes: 3),
      );
      int initialIntensity = 6 + index % 3;
      int finalIntensity = initialIntensity - 2 - index % 2;
      UrgeOutcome outcome = switch (index % 3) {
        0 => .passed,
        1 => .reduced,
        _ => .delayed,
      };
      await _database
          .into(_database.urgeSessions)
          .insert(
            UrgeSessionsCompanion.insert(
              id: sessionId,
              startedAt: startedAt,
              completedAt: Value(completedAt),
              initialIntensity: initialIntensity,
              finalIntensity: Value(finalIntensity),
              triggerType: Value(
                _triggers[index % _triggers.length].name,
              ),
              emotionType: Value(
                _emotions[index % _emotions.length].name,
              ),
              copingStrategyId: Value(strategyId),
              outcome: Value(outcome.name),
              pauseDurationSeconds: const Value(120),
            ),
          );
      await _database
          .into(_database.copingStrategyUses)
          .insert(
            CopingStrategyUsesCompanion.insert(
              id: '$_idPrefix-strategy-use-$index',
              strategyId: strategyId,
              usedAt: completedAt,
              urgeSessionId: Value(sessionId),
              perceivedEffect: Value(1 + index % 5),
            ),
          );
    }
  }

  /// Inserts recent check-ins, including a six-day constructive sequence.
  Future<void> _insertCheckIns(DateTime today) async {
    for (int index = 0; index < _checkInOffsets.length; index++) {
      int daysAgo = _checkInOffsets[index];
      DateTime createdAt = _at(
        today,
        daysAgo: daysAgo,
        hour: 8,
      );
      await _database
          .into(_database.dailyCheckIns)
          .insert(
            DailyCheckInsCompanion.insert(
              localDate: localDateKey(createdAt.toLocal()),
              createdAt: createdAt,
              updatedAt: createdAt,
              moodScore: 4 + index % 5,
              controlScore: 3 + index % 6,
              urgeCountEstimate: Value(index % 4),
              sleepQuality: Value(5 + index % 4),
              note: const Value(_checkInMarker),
            ),
            mode: InsertMode.insertOrIgnore,
          );
    }
  }

  /// Inserts the baseline self-assessment behind the starting-point views.
  Future<void> _insertAssessments(DateTime today) async {
    await _database
        .into(_database.selfAssessments)
        .insert(
          SelfAssessmentsCompanion.insert(
            id: '$_idPrefix-assessment-baseline',
            recordedAt: _at(today, daysAgo: 60, hour: 9),
            kind: AssessmentKind.baseline.name,
            weeklyFrequency: const Value(7),
            perceivedControl: 3,
            negativeImpact: 7,
            confidenceToChange: 4,
          ),
        );
  }

  /// Adds non-destructive sample progress for three bundled modules.
  Future<void> _insertModuleProgress(DateTime today) async {
    DateTime firstStartedAt = _at(today, daysAgo: 46, hour: 19);
    DateTime firstCompletedAt = _at(today, daysAgo: 45, hour: 19);
    await _database
        .into(_database.moduleProgress)
        .insert(
          ModuleProgressCompanion.insert(
            moduleId: 'why-change',
            startedAt: Value(firstStartedAt),
            completedAt: Value(firstCompletedAt),
            lastSectionIndex: const Value(2),
            updatedAt: firstCompletedAt,
          ),
          mode: InsertMode.insertOrIgnore,
        );
    DateTime secondStartedAt = _at(today, daysAgo: 21, hour: 19);
    DateTime secondCompletedAt = _at(today, daysAgo: 20, hour: 19);
    await _database
        .into(_database.moduleProgress)
        .insert(
          ModuleProgressCompanion.insert(
            moduleId: 'understand-loop',
            startedAt: Value(secondStartedAt),
            completedAt: Value(secondCompletedAt),
            lastSectionIndex: const Value(2),
            updatedAt: secondCompletedAt,
          ),
          mode: InsertMode.insertOrIgnore,
        );
    DateTime currentStartedAt = _at(today, daysAgo: 5, hour: 19);
    await _database
        .into(_database.moduleProgress)
        .insert(
          ModuleProgressCompanion.insert(
            moduleId: 'map-terrain',
            startedAt: Value(currentStartedAt),
            lastSectionIndex: const Value(1),
            updatedAt: currentStartedAt,
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  /// Returns a UTC timestamp on the local day [daysAgo] before [today].
  DateTime _at(
    DateTime today, {
    required int daysAgo,
    required int hour,
  }) => DateTime(
    today.year,
    today.month,
    today.day - daysAgo,
    hour,
  ).toUtc();
}

/// Provides the debug-only local sample-data seeder.
@riverpod
DebugDataSeeder debugDataSeeder(Ref ref) => DebugDataSeeder(
  ref.watch(appDatabaseProvider),
);
