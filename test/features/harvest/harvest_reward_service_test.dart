import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/harvest/application/harvest_reward_service.dart';
import 'package:stopcorn/features/harvest/data/harvest_repository.dart';
import 'package:stopcorn/features/harvest/domain/harvest_reward.dart';

import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';

/// Runs reward detection tests around locally persisted constructive actions.
void main() {
  setUpAll(configureTestSqlite);

  test(
    'rewards only the first constructive action of the day',
    () async {
      DateTime now = DateTime.utc(2026, 7, 28, 12);
      AppDatabase database = AppDatabase(NativeDatabase.memory());
      AppPreferences preferences = AppPreferences(createTestPreferences());
      addTearDown(() async {
        await preferences.dispose();
        await database.close();
      });
      HarvestRewardService service = HarvestRewardService(
        preferences,
        HarvestRepository(database),
        FixedAppClock(now),
      );
      await _insertGoal(
        database,
        id: 'yesterday',
        timestamp: now.subtract(const Duration(days: 1)),
      );

      HarvestActionResult first = await service.run(() async {
        await _insertGoal(database, id: 'today-first', timestamp: now);
        return true;
      });

      expect(first.succeeded, isTrue);
      expect(first.reward?.pointsBefore, 1);
      expect(first.reward?.pointsAfter, 2);
      expect(first.reward?.pointDelta, 1);
      expect(first.reward?.momentumBefore, 1);
      expect(first.reward?.momentumAfter, 2);
      expect(first.reward?.momentumDelta, 1);

      HarvestActionResult second = await service.run(() async {
        await _insertGoal(database, id: 'today-second', timestamp: now);
        return true;
      });

      expect(second.succeeded, isTrue);
      expect(second.reward, isNull);
    },
  );

  test('does not show a reward when harvest is hidden', () async {
    DateTime now = DateTime.utc(2026, 7, 28, 12);
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(
      createTestPreferences(
        initialValues: {'show_harvest': false},
      ),
    );
    addTearDown(() async {
      await preferences.dispose();
      await database.close();
    });
    HarvestRewardService service = HarvestRewardService(
      preferences,
      HarvestRepository(database),
      FixedAppClock(now),
    );
    bool actionRan = false;

    HarvestActionResult result = await service.run(() async {
      actionRan = true;
      await _insertGoal(database, id: 'hidden', timestamp: now);
      return true;
    });

    expect(actionRan, isTrue);
    expect(result.succeeded, isTrue);
    expect(result.reward, isNull);
  });

  test(
    'allows a bonus point after the daily point has already been harvested',
    () async {
      DateTime now = DateTime.utc(2026, 7, 28, 12);
      AppDatabase database = AppDatabase(NativeDatabase.memory());
      AppPreferences preferences = AppPreferences(
        createTestPreferences(
          initialValues: {'show_harvest': false},
        ),
      );
      addTearDown(() async {
        await preferences.dispose();
        await database.close();
      });
      HarvestRewardService service = HarvestRewardService(
        preferences,
        HarvestRepository(database, preferences),
        FixedAppClock(now),
      );
      await _insertGoal(database, id: 'today', timestamp: now);

      HarvestActionResult result = await service.run(
        () async {
          await preferences.setDebugHarvestBonusPoints(1);
          return true;
        },
        policy: .debugBonus,
      );

      expect(result.succeeded, isTrue);
      expect(result.reward?.pointsBefore, 1);
      expect(result.reward?.pointsAfter, 2);
      expect(result.reward?.momentumBefore, 1);
      expect(result.reward?.momentumAfter, 1);
      expect(result.reward?.momentumDelta, 0);
    },
  );
}

/// Inserts one constructive goal at [timestamp].
Future<void> _insertGoal(
  AppDatabase database, {
  required String id,
  required DateTime timestamp,
}) => database
    .into(database.goals)
    .insert(
      GoalsCompanion.insert(
        id: id,
        createdAt: timestamp,
        updatedAt: timestamp,
        type: GoalType.observation.name,
        startedAt: timestamp,
      ),
    );
