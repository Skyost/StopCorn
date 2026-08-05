import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/utils/local_date.dart';
import 'package:stopcorn/features/harvest/data/harvest_repository.dart';
import 'package:stopcorn/features/harvest/domain/harvest_summary.dart';

import '../../helpers/daylight_saving.dart';
import '../../helpers/test_database.dart';

/// Runs locally derived harvest repository tests.
void main() {
  setUpAll(configureTestSqlite);

  test('awards at most one Corn point per constructive day', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    HarvestRepository repository = HarvestRepository(database);

    await database
        .into(database.goals)
        .insert(
          GoalsCompanion.insert(
            id: 'goal',
            createdAt: DateTime.utc(2026, 7, 20, 12),
            updatedAt: DateTime.utc(2026, 7, 20, 12),
            type: GoalType.observation.name,
            startedAt: DateTime.utc(2026, 7, 20, 12),
          ),
        );
    await database
        .into(database.urgeSessions)
        .insert(
          UrgeSessionsCompanion.insert(
            id: 'urge',
            startedAt: DateTime.utc(2026, 7, 21, 11),
            completedAt: Value<DateTime?>(
              DateTime.utc(2026, 7, 21, 11, 5),
            ),
            initialIntensity: 7,
            outcome: Value<String?>(UrgeOutcome.reduced.name),
          ),
        );
    await database
        .into(database.urgeSessions)
        .insert(
          UrgeSessionsCompanion.insert(
            id: 'abandoned-urge',
            startedAt: DateTime.utc(2026, 7, 22, 11),
            completedAt: Value<DateTime?>(
              DateTime.utc(2026, 7, 22, 11, 1),
            ),
            initialIntensity: 7,
            outcome: Value<String?>(UrgeOutcome.abandoned.name),
          ),
        );
    await database
        .into(database.consumptionEvents)
        .insert(
          ConsumptionEventsCompanion.insert(
            id: 'honest-observation',
            occurredAt: DateTime.utc(2026, 7, 19, 20),
            createdAt: DateTime.utc(2026, 7, 21, 18),
          ),
        );
    await database
        .into(database.dailyCheckIns)
        .insert(
          DailyCheckInsCompanion.insert(
            localDate: '2026-07-23',
            createdAt: DateTime.utc(2026, 7, 23, 9),
            updatedAt: DateTime.utc(2026, 7, 23, 9),
            moodScore: 6,
            controlScore: 7,
          ),
        );
    await database
        .into(database.moduleProgress)
        .insert(
          ModuleProgressCompanion.insert(
            moduleId: 'module',
            completedAt: Value<DateTime?>(
              DateTime.utc(2026, 7, 24, 10),
            ),
            updatedAt: DateTime.utc(2026, 7, 24, 10),
          ),
        );

    HarvestSummary summary = await repository.loadSummary(
      DateTime.utc(2026, 7, 24, 12),
    );

    expect(summary.grainCount, 4);
    expect(summary.currentMomentum, 2);
    expect(summary.bestMomentum, 2);
    expect(
      summary.recentDays.map((day) => day.cultivated),
      [false, false, true, true, false, true, true],
    );
    expect(summary.cultivatedToday, isTrue);
  });

  test('the current day acts as a grace period for momentum', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    HarvestRepository repository = HarvestRepository(database);

    await database
        .into(database.goals)
        .insert(
          GoalsCompanion.insert(
            id: 'goal',
            createdAt: DateTime.utc(2026, 7, 25, 12),
            updatedAt: DateTime.utc(2026, 7, 25, 12),
            type: GoalType.observation.name,
            startedAt: DateTime.utc(2026, 7, 25, 12),
          ),
        );
    await database
        .into(database.urgeSessions)
        .insert(
          UrgeSessionsCompanion.insert(
            id: 'urge',
            startedAt: DateTime.utc(2026, 7, 26, 12),
            completedAt: Value<DateTime?>(
              DateTime.utc(2026, 7, 26, 12, 5),
            ),
            initialIntensity: 5,
            outcome: Value<String?>(UrgeOutcome.reduced.name),
          ),
        );

    HarvestSummary grace = await repository.loadSummary(
      DateTime.utc(2026, 7, 27, 12),
    );
    HarvestSummary expired = await repository.loadSummary(
      DateTime.utc(2026, 7, 28, 12),
    );

    expect(grace.currentMomentum, 2);
    expect(grace.cultivatedToday, isFalse);
    expect(expired.currentMomentum, 0);
    expect(expired.bestMomentum, 2);
  });

  test('preserves momentum across a daylight-saving transition', () async {
    List<DateTime> transitions = daylightSavingDays(2026);
    if (transitions.isEmpty) {
      // The suite runs in a zone without daylight saving, such as UTC.
      return;
    }

    for (DateTime transition in transitions) {
      AppDatabase database = AppDatabase(NativeDatabase.memory());
      HarvestRepository repository = HarvestRepository(database);

      // One check-in on the transition day and on each of the two days
      // surrounding it, so a skipped day breaks the streak visibly.
      for (int offset = -1; offset <= 1; offset++) {
        DateTime day = addLocalDays(transition, offset);
        DateTime middayUtc = DateTime(
          day.year,
          day.month,
          day.day,
          12,
        ).toUtc();
        await database
            .into(database.dailyCheckIns)
            .insert(
              DailyCheckInsCompanion.insert(
                localDate: localDateKey(day),
                createdAt: middayUtc,
                updatedAt: middayUtc,
                moodScore: 6,
                controlScore: 6,
              ),
            );
      }

      HarvestSummary summary = await repository.loadSummary(
        DateTime(
          transition.year,
          transition.month,
          transition.day + 1,
          18,
        ),
      );
      await database.close();

      expect(
        summary.grainCount,
        3,
        reason: 'Three distinct days should surround $transition.',
      );
      expect(
        summary.currentMomentum,
        3,
        reason: 'Momentum must not skip $transition.',
      );
      expect(
        summary.bestMomentum,
        3,
        reason: 'Best momentum must not be interrupted at $transition.',
      );
      expect(
        summary.recentDays.map((day) => localDateKey(day.date)).toSet(),
        hasLength(7),
        reason: 'The displayed week must remain contiguous at $transition.',
      );
    }
  });
}
