import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/features/goals/domain/goal_history_entry.dart';
import 'package:stopcorn/features/goals/domain/goal_input.dart';
import 'package:stopcorn/i18n/strings.g.dart';

part 'goal_repository.g.dart';

/// Manages the single active goal while retaining historical goals.
final class GoalRepository {
  /// Local relational store used for goal history.
  final AppDatabase _database;

  /// Creates a repository backed by [database].
  const GoalRepository(this._database);

  /// Watches the most recently started active goal.
  Stream<Goal?> watchActive() {
    SimpleSelectStatement<$GoalsTable, Goal> query = _database.select(_database.goals)
      ..where((goal) => goal.isActive.equals(true))
      ..orderBy(<OrderingTerm Function($GoalsTable)>[
        ($GoalsTable goal) => OrderingTerm.desc(goal.startedAt),
      ])
      ..limit(1);
    return query.watchSingleOrNull();
  }

  /// Loads the most recently started active goal once.
  Future<Goal?> getActive() {
    SimpleSelectStatement<$GoalsTable, Goal> query = _database.select(_database.goals)
      ..where((goal) => goal.isActive.equals(true))
      ..orderBy(<OrderingTerm Function($GoalsTable)>[
        ($GoalsTable goal) => OrderingTerm.desc(goal.startedAt),
      ])
      ..limit(1);
    return query.getSingleOrNull();
  }

  /// Watches every goal, newest first, including the ones already ended.
  Stream<List<GoalHistoryEntry>> watchHistory() {
    SimpleSelectStatement<$GoalsTable, Goal> query = _database.select(_database.goals)
      ..orderBy(<OrderingTerm Function($GoalsTable)>[
        ($GoalsTable goal) => OrderingTerm.desc(goal.startedAt),
      ]);
    return query.watch().map(
      (goals) => List<GoalHistoryEntry>.unmodifiable(goals.map(_historyEntry)),
    );
  }

  /// Converts one Drift [goal] into its presentation-facing entry.
  GoalHistoryEntry _historyEntry(Goal goal) => GoalHistoryEntry(
    id: goal.id,
    type: enumFromStoredValueOrNull(GoalType.values, goal.type),
    isActive: goal.isActive,
    startedAt: goal.startedAt.toLocal(),
    endedAt: goal.endedAt?.toLocal(),
    weeklyLimit: goal.weeklyLimit,
    contextKeys: _decodeStringList(goal.contextKeysJson),
    motivation: goal.motivation,
  );

  /// Decodes contextual-goal keys without making history unavailable.
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

  /// Ends the previous active goal and activates [input] atomically.
  Future<void> activate(GoalInput input, DateTime now) async {
    _validate(input);
    DateTime utcNow = now.toUtc();
    await _database.transaction(() async {
      await (_database.update(
        _database.goals,
      )..where((goal) => goal.isActive.equals(true))).write(
        GoalsCompanion(
          isActive: const Value<bool>(false),
          endedAt: Value<DateTime?>(utcNow),
          updatedAt: Value<DateTime>(utcNow),
        ),
      );
      await _database
          .into(_database.goals)
          .insertOnConflictUpdate(
            GoalsCompanion.insert(
              id: input.id,
              createdAt: utcNow,
              updatedAt: utcNow,
              type: input.type.name,
              isActive: const Value<bool>(true),
              weeklyLimit: Value<int?>(input.weeklyLimit),
              contextKeysJson: Value<String?>(
                input.contextKeys.isEmpty ? null : jsonEncode(input.contextKeys),
              ),
              motivation: Value<String?>(input.motivation),
              startedAt: input.startedAt.toUtc(),
            ),
          );
    });
  }

  /// Enforces the fields required by each goal direction.
  void _validate(GoalInput input) {
    if (input.type == .reduction && (input.weeklyLimit == null || input.weeklyLimit! <= 0)) {
      throw FormatException(t.settings.goalEditor.validation.weeklyLimit);
    }
    if (input.type == .contextual && input.contextKeys.isEmpty) {
      throw FormatException(t.settings.goalEditor.validation.context);
    }
  }
}

/// Provides the database-backed goal repository.
@Riverpod(keepAlive: true)
GoalRepository goalRepository(Ref ref) => GoalRepository(ref.watch(appDatabaseProvider));

/// Watches every goal the person has set, newest first.
@riverpod
Stream<List<GoalHistoryEntry>> goalHistory(Ref ref) => ref.watch(goalRepositoryProvider).watchHistory();
