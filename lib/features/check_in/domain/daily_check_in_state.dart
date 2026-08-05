/// Immutable state of the daily check-in form.
final class DailyCheckInState {
  /// Local date encoded as `yyyy-MM-dd`.
  final String localDate;

  /// Current mood score.
  final int moodScore;

  /// Current perceived-control score.
  final int controlScore;

  /// Raw optional urge-count text.
  final String urgeCountInput;

  /// Number of consumption events already recorded on this local date.
  final int recordedConsumptionCount;

  /// Optional sleep-quality score.
  final int? sleepQuality;

  /// Current private note.
  final String note;

  /// Whether the form edits a previously persisted check-in.
  final bool wasExisting;

  /// Whether a persistence operation is running.
  final bool isSaving;

  /// Whether the current save has completed.
  final bool isSaved;

  /// Localized recoverable error shown by the form.
  final String? errorMessage;

  /// Creates a daily check-in form snapshot.
  const DailyCheckInState({
    required this.localDate,
    required this.moodScore,
    required this.controlScore,
    this.urgeCountInput = '',
    this.recordedConsumptionCount = 0,
    this.sleepQuality,
    this.note = '',
    this.wasExisting = false,
    this.isSaving = false,
    this.isSaved = false,
    this.errorMessage,
  });

  /// Returns a new snapshot with the supplied fields replaced.
  DailyCheckInState copyWith({
    int? moodScore,
    int? controlScore,
    String? urgeCountInput,
    int? recordedConsumptionCount,
    Object? sleepQuality = _unchanged,
    String? note,
    bool? wasExisting,
    bool? isSaving,
    bool? isSaved,
    Object? errorMessage = _unchanged,
  }) => DailyCheckInState(
    localDate: localDate,
    moodScore: moodScore ?? this.moodScore,
    controlScore: controlScore ?? this.controlScore,
    urgeCountInput: urgeCountInput ?? this.urgeCountInput,
    recordedConsumptionCount: recordedConsumptionCount ?? this.recordedConsumptionCount,
    sleepQuality: identical(sleepQuality, _unchanged) ? this.sleepQuality : sleepQuality as int?,
    note: note ?? this.note,
    wasExisting: wasExisting ?? this.wasExisting,
    isSaving: isSaving ?? this.isSaving,
    isSaved: isSaved ?? this.isSaved,
    errorMessage: identical(errorMessage, _unchanged) ? this.errorMessage : errorMessage as String?,
  );
}

/// Sentinel distinguishing an omitted nullable value from an explicit `null`.
const Object _unchanged = Object();
