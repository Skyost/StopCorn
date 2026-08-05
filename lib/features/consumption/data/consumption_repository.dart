import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/utils/local_date.dart';
import 'package:stopcorn/features/consumption/domain/consumption_input.dart';

part 'consumption_repository.g.dart';

/// Persists only consumption events that the user explicitly records.
class ConsumptionRepository {
  /// Local relational store used for voluntary event history.
  final AppDatabase _database;

  /// Creates a repository backed by [database].
  const ConsumptionRepository(this._database);

  /// Validates and inserts one [input].
  Future<void> add(ConsumptionInput input) async {
    _validate(input);
    await _database
        .into(_database.consumptionEvents)
        .insert(
          ConsumptionEventsCompanion.insert(
            id: input.id,
            occurredAt: input.occurredAt.toUtc(),
            triggerType: Value<String?>(input.triggerType?.name),
            emotionType: Value<String?>(input.emotionType?.name),
            contextLabel: Value<String?>(_context(input)),
            contextKeysJson: Value<String?>(_contextKeys(input)),
            perceivedControl: Value<int?>(input.perceivedControl),
            notes: Value<String?>(_notes(input)),
            urgeSessionId: Value<String?>(input.urgeSessionId),
            createdAt: input.createdAt.toUtc(),
          ),
        );
  }

  /// Validates and rewrites the event identified by [input].
  ///
  /// The original creation timestamp is preserved so a correction does not
  /// move the day the event was recorded on.
  Future<void> update(ConsumptionInput input) async {
    _validate(input);
    int updated =
        await (_database.update(
          _database.consumptionEvents,
        )..where((event) => event.id.equals(input.id))).write(
          ConsumptionEventsCompanion(
            occurredAt: Value<DateTime>(input.occurredAt.toUtc()),
            triggerType: Value<String?>(input.triggerType?.name),
            emotionType: Value<String?>(input.emotionType?.name),
            contextLabel: Value<String?>(_context(input)),
            contextKeysJson: Value<String?>(_contextKeys(input)),
            perceivedControl: Value<int?>(input.perceivedControl),
            notes: Value<String?>(_notes(input)),
          ),
        );
    if (updated != 1) {
      throw StateError('The consumption event was not found.');
    }
  }

  /// Permanently removes the event identified by [id].
  Future<void> remove(String id) async {
    int deleted = await (_database.delete(
      _database.consumptionEvents,
    )..where((event) => event.id.equals(id))).go();
    if (deleted != 1) {
      throw StateError('The consumption event was not found.');
    }
  }

  /// Loads one event by [id].
  Future<ConsumptionEvent?> getById(String id) => (_database.select(
    _database.consumptionEvents,
  )..where((event) => event.id.equals(id))).getSingleOrNull();

  /// Counts the events that occurred on the `yyyy-MM-dd` [localDate].
  ///
  /// Timestamps are stored in UTC, so the local day is converted into the
  /// instant range it actually covers rather than compared as text.
  Future<int> countOnLocalDate(String localDate) async {
    DateTime start = startOfLocalDay(DateTime.parse(localDate));
    DateTime end = addLocalDays(start, 1);
    Expression<int> total = _database.consumptionEvents.id.count();
    JoinedSelectStatement<HasResultSet, dynamic> query = _database.selectOnly(_database.consumptionEvents)
      ..addColumns([total])
      ..where(
        _database.consumptionEvents.occurredAt.isBiggerOrEqualValue(
              start.toUtc(),
            ) &
            _database.consumptionEvents.occurredAt.isSmallerThanValue(
              end.toUtc(),
            ),
      );
    TypedResult row = await query.getSingle();
    return row.read(total) ?? 0;
  }

  /// Loads all events from newest to oldest.
  Future<List<ConsumptionEvent>> getAll() {
    SimpleSelectStatement<$ConsumptionEventsTable, ConsumptionEvent> query = _database.select(_database.consumptionEvents)
      ..orderBy(<OrderingTerm Function($ConsumptionEventsTable)>[
        ($ConsumptionEventsTable event) => OrderingTerm.desc(event.occurredAt),
      ]);
    return query.get();
  }

  /// Rejects an [input] that no repository operation should persist.
  void _validate(ConsumptionInput input) {
    if (input.occurredAt.isAfter(input.createdAt)) {
      throw const FormatException('An event cannot occur in the future.');
    }
    int? control = input.perceivedControl;
    if (control != null && (control < 0 || control > 10)) {
      throw const FormatException(
        'Perceived control must be between 0 and 10.',
      );
    }
    _context(input);
    _contextKeys(input);
    _notes(input);
  }

  /// Returns the stored context label for [input].
  String? _context(ConsumptionInput input) => _optionalTrimmed(
    input.contextLabel,
    AppConstants.shortContextMaxLength,
    'The context',
  );

  /// Returns a deterministic JSON representation of selected goal contexts.
  String? _contextKeys(ConsumptionInput input) {
    List<String> keys = input.contextKeys.map((key) => key.trim()).where((key) => key.isNotEmpty).toSet().toList()..sort();
    return keys.isEmpty ? null : jsonEncode(keys);
  }

  /// Returns the stored private note for [input].
  String? _notes(ConsumptionInput input) => _optionalTrimmed(
    input.notes,
    AppConstants.noteMaxLength,
    'The note',
  );

  /// Trims an optional field and enforces its [maxLength].
  String? _optionalTrimmed(String? value, int maxLength, String fieldName) {
    String? trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    if (trimmed.length > maxLength) {
      throw FormatException(
        '$fieldName cannot exceed $maxLength characters.',
      );
    }
    return trimmed;
  }
}

/// Provides the database-backed consumption repository.
@Riverpod(keepAlive: true)
ConsumptionRepository consumptionRepository(Ref ref) => ConsumptionRepository(ref.watch(appDatabaseProvider));
