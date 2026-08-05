import 'package:stopcorn/core/domain/app_enums.dart';

/// Immutable state of the voluntary event form.
final class LogConsumptionState {
  /// Local date and time selected for the event.
  final DateTime occurredAt;

  /// Optional general trigger marker.
  final TriggerType? triggerType;

  /// Optional general emotion marker.
  final EmotionType? emotionType;

  /// Optional perceived-control score.
  final int? perceivedControl;

  /// Current optional general context.
  final String contextLabel;

  /// Context keys offered by the active contextual goal or saved event.
  final List<String> availableContextKeys;

  /// Contextual-goal keys selected for this event.
  final Set<String> selectedContextKeys;

  /// Current optional private note.
  final String notes;

  /// Whether persistence is in progress.
  final bool isSaving;

  /// Whether the current event has been saved.
  final bool isSaved;

  /// Identifier of the event being corrected, or `null` when creating one.
  final String? editedEventId;

  /// Urge session this event is being recorded from, when there is one.
  final String? urgeSessionId;

  /// Localized recoverable error shown by the form.
  final String? errorMessage;

  /// Creates a voluntary event form snapshot.
  const LogConsumptionState({
    required this.occurredAt,
    this.triggerType,
    this.emotionType,
    this.perceivedControl,
    this.contextLabel = '',
    this.availableContextKeys = const [],
    this.selectedContextKeys = const {},
    this.notes = '',
    this.isSaving = false,
    this.isSaved = false,
    this.editedEventId,
    this.urgeSessionId,
    this.errorMessage,
  });

  /// Whether this form corrects an event that already exists.
  bool get isEditing => editedEventId != null;

  /// Returns a new snapshot with the supplied fields replaced.
  LogConsumptionState copyWith({
    DateTime? occurredAt,
    Object? triggerType = _unchanged,
    Object? emotionType = _unchanged,
    Object? perceivedControl = _unchanged,
    String? contextLabel,
    List<String>? availableContextKeys,
    Set<String>? selectedContextKeys,
    String? notes,
    bool? isSaving,
    bool? isSaved,
    Object? errorMessage = _unchanged,
  }) => LogConsumptionState(
    editedEventId: editedEventId,
    urgeSessionId: urgeSessionId,
    occurredAt: occurredAt ?? this.occurredAt,
    triggerType: identical(triggerType, _unchanged) ? this.triggerType : triggerType as TriggerType?,
    emotionType: identical(emotionType, _unchanged) ? this.emotionType : emotionType as EmotionType?,
    perceivedControl: identical(perceivedControl, _unchanged) ? this.perceivedControl : perceivedControl as int?,
    contextLabel: contextLabel ?? this.contextLabel,
    availableContextKeys: availableContextKeys ?? this.availableContextKeys,
    selectedContextKeys: selectedContextKeys ?? this.selectedContextKeys,
    notes: notes ?? this.notes,
    isSaving: isSaving ?? this.isSaving,
    isSaved: isSaved ?? this.isSaved,
    errorMessage: identical(errorMessage, _unchanged) ? this.errorMessage : errorMessage as String?,
  );
}

/// Sentinel distinguishing an omitted nullable value from an explicit `null`.
const Object _unchanged = Object();
