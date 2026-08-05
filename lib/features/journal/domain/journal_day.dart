import 'package:stopcorn/core/domain/app_enums.dart';

/// Base type for one voluntarily recorded journal entry.
sealed class JournalEntry {
  /// Local calendar day under which the entry is grouped.
  final DateTime localDate;

  /// Instant used to order entries inside one day.
  final DateTime sortInstant;

  /// Creates a journal entry associated with [localDate].
  const JournalEntry({
    required this.localDate,
    required this.sortInstant,
  });
}

/// Consumption event displayed in the combined journal.
final class ConsumptionJournalEntry extends JournalEntry {
  /// Stable database identifier.
  final String id;

  /// Local occurrence date and time.
  final DateTime occurredAt;

  /// Optional selected trigger.
  final TriggerType? triggerType;

  /// Optional selected emotion.
  final EmotionType? emotionType;

  /// Optional short context written by the user.
  final String? contextLabel;

  /// Stable contextual-goal keys selected for this event.
  final List<String> contextKeys;

  /// Optional perceived-control score.
  final int? perceivedControl;

  /// Optional private note.
  final String? notes;

  /// Creates a journal representation of one consumption event.
  const ConsumptionJournalEntry({
    required super.localDate,
    required this.id,
    required this.occurredAt,
    this.triggerType,
    this.emotionType,
    this.contextLabel,
    this.contextKeys = const [],
    this.perceivedControl,
    this.notes,
  }) : super(sortInstant: occurredAt);
}

/// Daily check-in displayed in the combined journal.
final class CheckInJournalEntry extends JournalEntry {
  /// Stable local-date database key.
  final String localDateKey;

  /// Reported mood score.
  final int moodScore;

  /// Reported perceived-control score.
  final int controlScore;

  /// Optional approximate number of Corn urges.
  final int? urgeCountEstimate;

  /// Optional sleep-quality score.
  final int? sleepQuality;

  /// Optional private daily note.
  final String? note;

  /// Creates a journal representation of one daily check-in.
  const CheckInJournalEntry({
    required super.localDate,
    required super.sortInstant,
    required this.localDateKey,
    required this.moodScore,
    required this.controlScore,
    this.urgeCountEstimate,
    this.sleepQuality,
    this.note,
  });
}

/// Completed urge-support session displayed in the combined journal.
///
/// Only sessions the user actually finished appear: an abandoned one carries
/// no reflection and would read as a failure rather than an observation.
final class UrgeJournalEntry extends JournalEntry {
  /// Stable database identifier.
  final String id;

  /// Local instant at which support began.
  final DateTime startedAt;

  /// Urge intensity reported at the start.
  final int initialIntensity;

  /// Optional urge intensity reported at the end.
  final int? finalIntensity;

  /// Optional selected trigger.
  final TriggerType? triggerType;

  /// Optional selected emotion.
  final EmotionType? emotionType;

  /// Reported session outcome.
  final UrgeOutcome outcome;

  /// Optional strategy used during the session.
  final String? copingStrategyId;

  /// Optional completed guided-pause duration.
  final int? pauseDurationSeconds;

  /// Optional private reflection written at the end of the session.
  final String? notes;

  /// Creates a journal representation of one urge-support session.
  const UrgeJournalEntry({
    required super.localDate,
    required this.id,
    required this.startedAt,
    required this.initialIntensity,
    required this.outcome,
    this.finalIntensity,
    this.triggerType,
    this.emotionType,
    this.copingStrategyId,
    this.pauseDurationSeconds,
    this.notes,
  }) : super(sortInstant: startedAt);
}

/// Entries recorded on one local calendar day.
final class JournalDay {
  /// Local date at midnight.
  final DateTime date;

  /// Entries ordered from newest to oldest.
  final List<JournalEntry> entries;

  /// Creates an immutable journal group for [date].
  JournalDay({
    required this.date,
    required List<JournalEntry> entries,
  }) : entries = List.unmodifiable(entries);
}
