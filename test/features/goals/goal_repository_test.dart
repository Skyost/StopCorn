import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/goals/data/goal_repository.dart';
import 'package:stopcorn/features/goals/domain/goal_history_entry.dart';
import 'package:stopcorn/features/goals/domain/goal_input.dart';

import '../../helpers/test_database.dart';

/// Runs goal repository tests.
void main() {
  setUpAll(configureTestSqlite);

  test('history keeps completed goals from newest to oldest', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    GoalRepository repository = GoalRepository(database);
    DateTime firstDate = DateTime.utc(2026, 7, 1);
    DateTime secondDate = DateTime.utc(2026, 7, 28);

    await repository.activate(
      GoalInput(
        id: 'first',
        type: GoalType.observation,
        motivation: 'Understand my habits.',
        startedAt: firstDate,
      ),
      firstDate,
    );
    await repository.activate(
      GoalInput(
        id: 'second',
        type: GoalType.reduction,
        weeklyLimit: 2,
        startedAt: secondDate,
      ),
      secondDate,
    );

    List<GoalHistoryEntry> history = await repository.watchHistory().first;

    expect(history.map((goal) => goal.id), ['second', 'first']);
    expect(history.first.isActive, isTrue);
    expect(history.first.type, GoalType.reduction);
    expect(history.first.weeklyLimit, 2);
    expect(history.first.endedAt, isNull);
    // An ended goal keeps its own motivation and its end date.
    expect(history.last.isActive, isFalse);
    expect(history.last.motivation, 'Understand my habits.');
    expect(history.last.endedAt, isNotNull);
  });

  test('activating a new goal deactivates the previous one', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    GoalRepository repository = GoalRepository(database);
    DateTime firstDate = DateTime.utc(2026, 7, 1);
    DateTime secondDate = DateTime.utc(2026, 7, 28);

    await repository.activate(
      GoalInput(id: 'first', type: GoalType.observation, startedAt: firstDate),
      firstDate,
    );
    await repository.activate(
      GoalInput(
        id: 'second',
        type: GoalType.reduction,
        weeklyLimit: 2,
        startedAt: secondDate,
      ),
      secondDate,
    );

    List<Goal> goals = await database.select(database.goals).get();
    Goal first = goals.singleWhere((goal) => goal.id == 'first');
    Goal second = goals.singleWhere((goal) => goal.id == 'second');
    expect(first.isActive, isFalse);
    expect(first.endedAt?.toUtc(), secondDate);
    expect(second.isActive, isTrue);
  });
}
