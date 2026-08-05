import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';

import '../../helpers/test_database.dart';

/// Runs application database tests.
void main() {
  setUpAll(configureTestSqlite);

  group('current schema', () {
    late AppDatabase database;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
    });

    tearDown(() => database.close());

    test('built-in strategies are inserted idempotently', () async {
      DateTime now = DateTime.utc(2026, 7, 28, 12);

      await database.seedBuiltInStrategies(now);
      await database.seedBuiltInStrategies(now);

      List<CopingStrategy> strategies = await database.select(database.copingStrategies).get();
      expect(strategies, hasLength(builtInStrategies.length));
      expect(strategies.map((strategy) => strategy.id).toSet(), {
        for (final BuiltInStrategyDefinition strategy in builtInStrategies) strategy.id,
      });
    });

    test('deletion reinserts only built-in strategies', () async {
      DateTime now = DateTime.utc(2026, 7, 28, 12);
      await database.seedBuiltInStrategies(now);
      await database
          .into(database.goals)
          .insert(
            GoalsCompanion.insert(
              id: 'goal-1',
              createdAt: now,
              updatedAt: now,
              type: 'observation',
              startedAt: now,
            ),
          );

      await database.deleteAllUserDataAndReseed(now);

      expect(await database.select(database.goals).get(), isEmpty);
      expect(
        await database.select(database.copingStrategies).get(),
        hasLength(builtInStrategies.length),
      );
    });

    test('the initial schema includes the review state', () async {
      DateTime updatedAt = DateTime.utc(2026, 7, 28, 12);
      await database
          .into(database.moduleProgress)
          .insert(
            ModuleProgressCompanion.insert(
              moduleId: 'why-change',
              updatedAt: updatedAt,
            ),
          );

      ModuleProgressData progress = await database.select(database.moduleProgress).getSingle();

      expect(database.schemaVersion, 1);
      expect(progress.isReviewing, isFalse);
    });

    test('the initial schema disables reminders in a new draft', () async {
      DateTime updatedAt = DateTime.utc(2026, 7, 28, 12);
      await database
          .into(database.onboardingDrafts)
          .insert(
            OnboardingDraftsCompanion.insert(
              id: 'current',
              goalId: 'goal',
              assessmentId: 'assessment',
              updatedAt: updatedAt,
            ),
          );

      OnboardingDraftRecord draft = await database.select(database.onboardingDrafts).getSingle();

      expect(database.schemaVersion, 1);
      expect(draft.dailyCheckInReminderEnabled, isFalse);
    });
  });
}
