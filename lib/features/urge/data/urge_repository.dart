import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';

part 'urge_repository.g.dart';

/// Persists complete, partial, and abandoned urge-support sessions.
final class UrgeRepository {
  /// Database used to persist urge sessions and strategy usage.
  final AppDatabase _database;

  /// Creates a repository backed by [database].
  const UrgeRepository(this._database);

  /// Validates and inserts the initial urge markers.
  Future<void> createSession({
    required String id,
    required DateTime startedAt,
    required int initialIntensity,
    TriggerType? triggerType,
    EmotionType? emotionType,
  }) async {
    _validateIntensity(initialIntensity);
    await _database
        .into(_database.urgeSessions)
        .insert(
          UrgeSessionsCompanion.insert(
            id: id,
            startedAt: startedAt.toUtc(),
            initialIntensity: initialIntensity,
            triggerType: Value<String?>(triggerType?.name),
            emotionType: Value<String?>(emotionType?.name),
          ),
        );
  }

  /// Links a strategy to a session and records its use atomically.
  Future<String> selectStrategy({
    required String sessionId,
    required String strategyId,
    required String strategyUseId,
    required DateTime usedAt,
  }) async {
    await _database.transaction(() async {
      int updated =
          await (_database.update(
            _database.urgeSessions,
          )..where((session) => session.id.equals(sessionId))).write(
            UrgeSessionsCompanion(copingStrategyId: Value<String?>(strategyId)),
          );
      if (updated != 1) {
        throw StateError('Urge session was not found.');
      }
      await _database
          .into(_database.copingStrategyUses)
          .insert(
            CopingStrategyUsesCompanion.insert(
              id: strategyUseId,
              strategyId: strategyId,
              usedAt: usedAt.toUtc(),
              urgeSessionId: Value<String?>(sessionId),
            ),
          );
    });
    return strategyUseId;
  }

  /// Persists final markers and an optional strategy evaluation.
  Future<void> completeSession({
    required String sessionId,
    required DateTime completedAt,
    required int finalIntensity,
    required UrgeOutcome outcome,
    int? pauseDurationSeconds,
    String? notes,
    String? strategyUseId,
    int? strategyEffect,
  }) async {
    _validateIntensity(finalIntensity);
    if (outcome == .abandoned) {
      throw const FormatException(
        'An abandoned session must be recorded through abandonSession.',
      );
    }
    if (strategyEffect != null && (strategyEffect < -5 || strategyEffect > 5)) {
      throw const FormatException(
        'Perceived effect must be between -5 and 5.',
      );
    }

    await _database.transaction(() async {
      int updated =
          await (_database.update(
            _database.urgeSessions,
          )..where((session) => session.id.equals(sessionId))).write(
            UrgeSessionsCompanion(
              completedAt: Value<DateTime?>(completedAt.toUtc()),
              finalIntensity: Value<int?>(finalIntensity),
              outcome: Value<String?>(outcome.name),
              notes: Value<String?>(
                notes == null || notes.trim().isEmpty ? null : notes.trim(),
              ),
              // A session that took another support path has no pause, which
              // a stored zero would misreport as an instantly skipped one.
              pauseDurationSeconds: Value<int?>(
                pauseDurationSeconds?.clamp(
                  0,
                  AppConstants.guidedPauseSeconds,
                ),
              ),
            ),
          );
      if (updated != 1) {
        throw StateError('Urge session was not found.');
      }

      if (strategyUseId != null && strategyEffect != null) {
        await (_database.update(
          _database.copingStrategyUses,
        )..where((use) => use.id.equals(strategyUseId))).write(
          CopingStrategyUsesCompanion(
            perceivedEffect: Value<int?>(strategyEffect),
          ),
        );
      }
    });
  }

  /// Marks an unfinished session as abandoned.
  Future<void> abandonSession({
    required String sessionId,
    required DateTime completedAt,
  }) async {
    await (_database.update(
      _database.urgeSessions,
    )..where((session) => session.id.equals(sessionId))).write(
      UrgeSessionsCompanion(
        completedAt: Value<DateTime?>(completedAt.toUtc()),
        outcome: Value<String?>(UrgeOutcome.abandoned.name),
      ),
    );
  }

  /// Permanently removes the session [id] and the strategy uses it owns.
  ///
  /// A session records how one urge went, so a wrong intensity or outcome
  /// would otherwise stay in every statistic with no way back. The strategy
  /// uses started inside the session go with it, while a consumption event
  /// recorded from it is left alone: the event happened, and only its link to
  /// this session is cleared by the foreign key.
  Future<void> remove(String id) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.copingStrategyUses,
      )..where((use) => use.urgeSessionId.equals(id))).go();
      int deleted = await (_database.delete(
        _database.urgeSessions,
      )..where((session) => session.id.equals(id))).go();
      if (deleted != 1) {
        throw StateError('Urge session was not found.');
      }
    });
  }

  /// Loads one urge session by [id].
  Future<UrgeSession?> getById(String id) => (_database.select(
    _database.urgeSessions,
  )..where((session) => session.id.equals(id))).getSingleOrNull();

  /// Loads finished sessions from newest to oldest.
  ///
  /// Abandoned sessions are left out: they carry no reassessment and reading
  /// them back as journal entries would frame a interruption as a failure.
  Future<List<UrgeSession>> getCompleted() {
    SimpleSelectStatement<$UrgeSessionsTable, UrgeSession> query = _database.select(_database.urgeSessions)
      ..where(
        (session) => session.completedAt.isNotNull() & session.outcome.isNotNull() & session.outcome.equals(UrgeOutcome.abandoned.name).not(),
      )
      ..orderBy(<OrderingTerm Function($UrgeSessionsTable)>[
        ($UrgeSessionsTable session) => OrderingTerm.desc(session.startedAt),
      ]);
    return query.get();
  }

  /// Ensures that [value] is a valid urge intensity.
  void _validateIntensity(int value) {
    if (value < 0 || value > 10) {
      throw const FormatException('Intensity must be between 0 and 10.');
    }
  }
}

/// Provides the database-backed urge repository.
@Riverpod(keepAlive: true)
UrgeRepository urgeRepository(Ref ref) => UrgeRepository(ref.watch(appDatabaseProvider));
