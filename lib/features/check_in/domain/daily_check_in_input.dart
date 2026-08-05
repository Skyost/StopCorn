/// Validated persistence input for one local-date check-in.
final class DailyCheckInInput {
  /// Local date encoded as `yyyy-MM-dd`.
  final String localDate;

  /// Instant used for creation and update timestamps.
  final DateTime recordedAt;

  /// Mood score from zero to ten.
  final int moodScore;

  /// Perceived-control score from zero to ten.
  final int controlScore;

  /// Optional approximate number of urges.
  final int? urgeCountEstimate;

  /// Optional sleep-quality score from zero to ten.
  final int? sleepQuality;

  /// Optional private note.
  final String? note;

  /// Creates a daily check-in persistence command.
  const DailyCheckInInput({
    required this.localDate,
    required this.recordedAt,
    required this.moodScore,
    required this.controlScore,
    this.urgeCountEstimate,
    this.sleepQuality,
    this.note,
  });
}
