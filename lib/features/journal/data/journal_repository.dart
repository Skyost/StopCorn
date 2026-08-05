import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/check_in/data/check_in_repository.dart';
import 'package:stopcorn/features/consumption/data/consumption_repository.dart';
import 'package:stopcorn/features/journal/domain/journal_day.dart';
import 'package:stopcorn/features/urge/data/urge_repository.dart';

part 'journal_repository.g.dart';

/// Combines consumption events, urge sessions, and check-ins into a journal.
final class JournalRepository {
  /// Consumption history source.
  final ConsumptionRepository _consumptions;

  /// Daily check-in history source.
  final CheckInRepository _checkIns;

  /// Urge-support session history source.
  final UrgeRepository _urges;

  /// Creates a journal backed by the existing history repositories.
  const JournalRepository(
    this._consumptions,
    this._checkIns,
    this._urges,
  );

  /// Loads all journal days from newest to oldest.
  Future<List<JournalDay>> getDays() async {
    List<ConsumptionEvent> consumptions = await _consumptions.getAll();
    List<DailyCheckIn> checkIns = await _checkIns.getAll();
    List<UrgeSession> urges = await _urges.getCompleted();
    List<JournalEntry> entries = [
      for (ConsumptionEvent event in consumptions) _consumptionEntry(event),
      for (DailyCheckIn checkIn in checkIns) _checkInEntry(checkIn),
      for (UrgeSession urge in urges)
        if (_urgeEntry(urge) case UrgeJournalEntry entry) entry,
    ]..sort((first, second) => second.sortInstant.compareTo(first.sortInstant));
    Map<DateTime, List<JournalEntry>> grouped = {};
    for (JournalEntry entry in entries) {
      grouped.putIfAbsent(entry.localDate, () => []).add(entry);
    }
    List<DateTime> dates = grouped.keys.toList()..sort((first, second) => second.compareTo(first));
    return [
      for (DateTime date in dates)
        JournalDay(
          date: date,
          entries: grouped[date]!,
        ),
    ];
  }

  /// Converts one Drift [event] into its local journal representation.
  ConsumptionJournalEntry _consumptionEntry(ConsumptionEvent event) {
    DateTime occurredAt = event.occurredAt.toLocal();
    return ConsumptionJournalEntry(
      id: event.id,
      localDate: _dateOnly(occurredAt),
      occurredAt: occurredAt,
      triggerType: enumFromStoredValueOrNull(TriggerType.values, event.triggerType),
      emotionType: enumFromStoredValueOrNull(EmotionType.values, event.emotionType),
      contextLabel: event.contextLabel,
      contextKeys: _decodeStringList(event.contextKeysJson),
      perceivedControl: event.perceivedControl,
      notes: event.notes,
    );
  }

  /// Decodes stable context keys while tolerating an unexpected stored value.
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

  /// Converts one Drift [checkIn] into its local journal representation.
  CheckInJournalEntry _checkInEntry(DailyCheckIn checkIn) {
    DateTime localDate = DateTime.parse(checkIn.localDate);
    return CheckInJournalEntry(
      localDate: _dateOnly(localDate),
      sortInstant: checkIn.updatedAt.toLocal(),
      localDateKey: checkIn.localDate,
      moodScore: checkIn.moodScore,
      controlScore: checkIn.controlScore,
      urgeCountEstimate: checkIn.urgeCountEstimate,
      sleepQuality: checkIn.sleepQuality,
      note: checkIn.note,
    );
  }

  /// Converts one Drift [urge] into its local journal representation.
  ///
  /// Returns `null` when the stored outcome cannot be read, so one unexpected
  /// row never takes the whole journal down with it.
  UrgeJournalEntry? _urgeEntry(UrgeSession urge) {
    UrgeOutcome? outcome = enumFromStoredValueOrNull(UrgeOutcome.values, urge.outcome);
    if (outcome == null) {
      return null;
    }
    DateTime startedAt = urge.startedAt.toLocal();
    return UrgeJournalEntry(
      id: urge.id,
      localDate: _dateOnly(startedAt),
      startedAt: startedAt,
      initialIntensity: urge.initialIntensity,
      finalIntensity: urge.finalIntensity,
      triggerType: enumFromStoredValueOrNull(TriggerType.values, urge.triggerType),
      emotionType: enumFromStoredValueOrNull(EmotionType.values, urge.emotionType),
      outcome: outcome,
      copingStrategyId: urge.copingStrategyId,
      pauseDurationSeconds: urge.pauseDurationSeconds,
      notes: urge.notes,
    );
  }

  /// Returns local midnight for [value].
  DateTime _dateOnly(DateTime value) => DateTime(
    value.year,
    value.month,
    value.day,
  );
}

/// Provides the repository that assembles the combined journal.
@Riverpod(keepAlive: true)
JournalRepository journalRepository(Ref ref) => JournalRepository(
  ref.watch(consumptionRepositoryProvider),
  ref.watch(checkInRepositoryProvider),
  ref.watch(urgeRepositoryProvider),
);

/// Loads the combined journal and releases it when its screen is closed.
@riverpod
Future<List<JournalDay>> journalDays(Ref ref) => ref.watch(journalRepositoryProvider).getDays();
