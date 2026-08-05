import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/features/check_in/domain/daily_check_in_input.dart';

part 'check_in_repository.g.dart';

/// Reads and writes one daily check-in per local calendar date.
final class CheckInRepository {
  /// Local relational store used for check-in queries.
  final AppDatabase _database;

  /// Creates a repository backed by [database].
  const CheckInRepository(this._database);

  /// Finds the check-in identified by a `yyyy-MM-dd` [localDate].
  Future<DailyCheckIn?> getByLocalDate(String localDate) => (_database.select(_database.dailyCheckIns)..where((checkIn) => checkIn.localDate.equals(localDate))).getSingleOrNull();

  /// Loads every check-in from newest local date to oldest.
  Future<List<DailyCheckIn>> getAll() {
    SimpleSelectStatement<$DailyCheckInsTable, DailyCheckIn> query = _database.select(_database.dailyCheckIns)
      ..orderBy([
        (checkIn) => OrderingTerm.desc(checkIn.localDate),
      ]);
    return query.get();
  }

  /// Validates and upserts [input] by its local date.
  Future<void> save(DailyCheckInInput input) async {
    _validateScore(input.moodScore, 'Mood');
    _validateScore(input.controlScore, 'Perceived control');
    int? sleep = input.sleepQuality;
    if (sleep != null) {
      _validateScore(sleep, 'Sleep quality');
    }
    int? urges = input.urgeCountEstimate;
    if (urges != null && urges < 0) {
      throw const FormatException('The urge count cannot be negative.');
    }
    String? note = input.note?.trim();
    if (note != null && note.length > AppConstants.noteMaxLength) {
      throw const FormatException(
        'The note cannot exceed ${AppConstants.noteMaxLength} characters.',
      );
    }

    await _database.transaction(() async {
      DailyCheckIn? existing = await getByLocalDate(input.localDate);
      DailyCheckInsCompanion companion = DailyCheckInsCompanion(
        localDate: Value<String>(input.localDate),
        createdAt: Value<DateTime>(
          existing?.createdAt ?? input.recordedAt.toUtc(),
        ),
        updatedAt: Value<DateTime>(input.recordedAt.toUtc()),
        moodScore: Value<int>(input.moodScore),
        controlScore: Value<int>(input.controlScore),
        urgeCountEstimate: Value<int?>(urges),
        sleepQuality: Value<int?>(sleep),
        note: Value<String?>(note == null || note.isEmpty ? null : note),
      );
      await _database.into(_database.dailyCheckIns).insert(companion, mode: InsertMode.insertOrReplace);
    });
  }

  /// Permanently removes the check-in recorded on [localDate].
  Future<void> remove(String localDate) async {
    int deleted = await (_database.delete(
      _database.dailyCheckIns,
    )..where((checkIn) => checkIn.localDate.equals(localDate))).go();
    if (deleted != 1) {
      throw StateError('The daily check-in was not found.');
    }
  }

  /// Rejects a [value] outside the shared zero-to-ten scale.
  void _validateScore(int value, String field) {
    if (value < 0 || value > 10) {
      throw FormatException('$field must be between 0 and 10.');
    }
  }
}

/// Provides the database-backed daily check-in repository.
@Riverpod(keepAlive: true)
CheckInRepository checkInRepository(Ref ref) => CheckInRepository(ref.watch(appDatabaseProvider));
