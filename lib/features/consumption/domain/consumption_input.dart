import 'package:stopcorn/core/domain/app_enums.dart';

/// Persistence input for a voluntarily recorded consumption event.
final class ConsumptionInput {
  /// Stable UUID of the event.
  final String id;

  /// User-selected instant at which the event occurred.
  final DateTime occurredAt;

  /// Instant at which the record is created.
  final DateTime createdAt;

  /// Optional general trigger marker.
  final TriggerType? triggerType;

  /// Optional general emotion marker.
  final EmotionType? emotionType;

  /// Optional general context label.
  final String? contextLabel;

  /// Stable contextual-goal keys that applied to this event.
  final List<String> contextKeys;

  /// Optional perceived-control score.
  final int? perceivedControl;

  /// Optional private note.
  final String? notes;

  /// Urge session this event was recorded from, when there is one.
  final String? urgeSessionId;

  /// Creates an immutable event command.
  const ConsumptionInput({
    required this.id,
    required this.occurredAt,
    required this.createdAt,
    this.triggerType,
    this.emotionType,
    this.contextLabel,
    this.contextKeys = const [],
    this.perceivedControl,
    this.notes,
    this.urgeSessionId,
  });
}
