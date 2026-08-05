import 'dart:convert';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/progress/data/progress_repository.dart';
import 'package:stopcorn/features/progress/domain/progress_dashboard.dart';
import 'package:stopcorn/features/progress/domain/progress_period.dart';

import '../../helpers/test_database.dart';

/// Runs progress repository tests.
void main() {
  setUpAll(configureTestSqlite);

  test('computes metrics over 7 and 30 days', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    ProgressRepository repository = ProgressRepository(database);
    DateTime now = DateTime.utc(2026, 7, 28, 12);

    await database
        .into(database.goals)
        .insert(
          GoalsCompanion.insert(
            id: 'goal',
            createdAt: DateTime.utc(2026, 6, 1),
            updatedAt: DateTime.utc(2026, 6, 1),
            type: GoalType.observation.name,
            startedAt: DateTime.utc(2026, 6, 1),
          ),
        );
    for (var (String id, DateTime occurredAt, TriggerType trigger) in <(String, DateTime, TriggerType)>[
      ('recent-1', DateTime.utc(2026, 7, 28, 10), TriggerType.stress),
      ('recent-2', DateTime.utc(2026, 7, 25, 20), TriggerType.boredom),
      ('month-1', DateTime.utc(2026, 7, 15, 18), TriggerType.stress),
      ('previous', DateTime.utc(2026, 6, 20, 12), TriggerType.fatigue),
    ]) {
      await database
          .into(database.consumptionEvents)
          .insert(
            ConsumptionEventsCompanion.insert(
              id: id,
              occurredAt: occurredAt,
              triggerType: Value<String?>(trigger.name),
              createdAt: occurredAt,
            ),
          );
    }
    await database
        .into(database.urgeSessions)
        .insert(
          UrgeSessionsCompanion.insert(
            id: 'urge',
            startedAt: DateTime.utc(2026, 7, 27, 22),
            completedAt: Value<DateTime?>(DateTime.utc(2026, 7, 27, 22, 5)),
            initialIntensity: 8,
            finalIntensity: const Value<int?>(3),
            triggerType: Value<String?>(TriggerType.stress.name),
            emotionType: Value<String?>(EmotionType.anxious.name),
            outcome: Value<String?>(UrgeOutcome.reduced.name),
          ),
        );

    ProgressDashboard sevenDays = await repository.loadDashboard(
      period: ProgressPeriod.sevenDays,
      now: now,
    );
    ProgressDashboard thirtyDays = await repository.loadDashboard(
      period: ProgressPeriod.thirtyDays,
      now: now,
    );

    expect(sevenDays.eventCount, 2);
    expect(sevenDays.daysWithoutRecordedEvent, 5);
    expect(sevenDays.completedUrgeSessions, 1);
    expect(sevenDays.averageIntensityDecrease, 5);
    expect(thirtyDays.eventCount, 3);
    expect(thirtyDays.daysWithoutRecordedEvent, 27);
    expect(thirtyDays.eventChangePercent, isNotNull);
    expect(thirtyDays.triggerRanking.first.key, TriggerType.stress.name);
    expect(thirtyDays.triggerRanking.first.count, 3);
  });

  test(
    'handles an empty period without misleading statistics',
    () async {
      AppDatabase database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      ProgressDashboard dashboard = await ProgressRepository(database).loadDashboard(
        period: ProgressPeriod.thirtyDays,
        now: DateTime.utc(2026, 7, 28),
      );

      expect(dashboard.eventCount, 0);
      expect(dashboard.daysWithoutRecordedEvent, 0);
      expect(dashboard.eventChangePercent, isNull);
      expect(dashboard.averageIntensityDecrease, isNull);
      expect(dashboard.triggerRanking, isEmpty);
      expect(dashboard.averageWeeklyRecordedEvents, isNull);
    },
  );

  test('loads the baseline and normalizes events over one week', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    ProgressRepository repository = ProgressRepository(database);
    DateTime now = DateTime.utc(2026, 7, 28, 12);

    await database
        .into(database.goals)
        .insert(
          GoalsCompanion.insert(
            id: 'initial-goal',
            createdAt: DateTime.utc(2026, 6, 1),
            updatedAt: DateTime.utc(2026, 6, 1),
            type: GoalType.reduction.name,
            weeklyLimit: const Value<int?>(3),
            motivation: const Value<String?>('Regain time'),
            startedAt: DateTime.utc(2026, 6, 1),
          ),
        );
    await database
        .into(database.selfAssessments)
        .insert(
          SelfAssessmentsCompanion.insert(
            id: 'baseline',
            recordedAt: DateTime.utc(2026, 6, 1),
            kind: AssessmentKind.baseline.name,
            weeklyFrequency: const Value<int?>(8),
            perceivedControl: 4,
            negativeImpact: 7,
            confidenceToChange: 6,
          ),
        );
    for (int index = 0; index < 6; index++) {
      DateTime occurredAt = now.subtract(Duration(days: index * 3));
      await database
          .into(database.consumptionEvents)
          .insert(
            ConsumptionEventsCompanion.insert(
              id: 'event-$index',
              occurredAt: occurredAt,
              createdAt: occurredAt,
            ),
          );
    }

    ProgressDashboard dashboard = await repository.loadDashboard(
      period: ProgressPeriod.thirtyDays,
      now: now,
    );

    expect(dashboard.initialProfile, isNotNull);
    expect(dashboard.initialProfile!.weeklyFrequency, 8);
    expect(dashboard.initialProfile!.perceivedControl, 4);
    expect(dashboard.initialProfile!.weeklyLimit, 3);
    expect(dashboard.initialProfile!.motivation, 'Regain time');
    expect(dashboard.observedDayCount, 30);
    expect(dashboard.averageWeeklyRecordedEvents, closeTo(1.4, 0.001));
    expect((await repository.loadInitialProfile())?.confidenceToChange, 6);
  });

  test('ranks strategies and computes their average effect', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    DateTime now = DateTime.utc(2026, 7, 28, 12);
    await database.seedBuiltInStrategies(now);

    for (var (String id, int effect) in <(String, int)>[
      ('use-1', 3),
      ('use-2', 5),
      ('use-3', 1),
    ]) {
      await database
          .into(database.copingStrategyUses)
          .insert(
            CopingStrategyUsesCompanion.insert(
              id: id,
              strategyId: 'walk-five-minutes',
              usedAt: now.subtract(const Duration(days: 1)),
              perceivedEffect: Value<int?>(effect),
            ),
          );
    }
    await database
        .into(database.copingStrategyUses)
        .insert(
          CopingStrategyUsesCompanion.insert(
            id: 'other',
            strategyId: 'slow-breathing',
            usedAt: now,
            perceivedEffect: const Value<int?>(-2),
          ),
        );

    ProgressDashboard dashboard = await ProgressRepository(database).loadDashboard(
      period: ProgressPeriod.sevenDays,
      now: now,
    );

    expect(dashboard.strategyMetrics.first.strategyId, 'walk-five-minutes');
    expect(dashboard.strategyMetrics.first.useCount, 3);
    expect(dashboard.strategyMetrics.first.averageEffect, 3);
    expect(dashboard.strategyMetrics.last.averageEffect, -2);
  });

  test('measures events matching the active contextual goal', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    DateTime now = DateTime.utc(2026, 7, 28, 12);
    await database
        .into(database.goals)
        .insert(
          GoalsCompanion.insert(
            id: 'contextual-goal',
            createdAt: DateTime.utc(2026, 7, 1),
            updatedAt: DateTime.utc(2026, 7, 1),
            type: GoalType.contextual.name,
            contextKeysJson: Value<String?>(
              jsonEncode(['home-alone', 'late-evening']),
            ),
            startedAt: DateTime.utc(2026, 7, 1),
          ),
        );
    for (var (String id, List<String> contexts) in <(String, List<String>)>[
      ('matching', ['home-alone']),
      ('other', ['during-stress']),
      ('unclassified', []),
    ]) {
      await database
          .into(database.consumptionEvents)
          .insert(
            ConsumptionEventsCompanion.insert(
              id: id,
              occurredAt: now.subtract(const Duration(days: 1)),
              contextKeysJson: Value<String?>(
                contexts.isEmpty ? null : jsonEncode(contexts),
              ),
              createdAt: now,
            ),
          );
    }

    ProgressDashboard dashboard = await ProgressRepository(
      database,
    ).loadDashboard(period: ProgressPeriod.sevenDays, now: now);

    expect(dashboard.activeGoalType, GoalType.contextual);
    expect(dashboard.activeGoalContextKeys, [
      'home-alone',
      'late-evening',
    ]);
    expect(dashboard.contextualGoalEventCount, 1);
  });
}
