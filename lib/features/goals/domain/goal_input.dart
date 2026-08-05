import 'package:stopcorn/core/domain/app_enums.dart';

/// Persistence command for activating a new goal.
final class GoalInput {
  /// Stable UUID reserved for the goal.
  final String id;

  /// Direction selected by the user.
  final GoalType type;

  /// Instant at which this goal begins.
  final DateTime startedAt;

  /// Optional desired maximum number of weekly events.
  final int? weeklyLimit;

  /// General context keys covered by a contextual goal.
  final List<String> contextKeys;

  /// Optional user-written reason for the goal.
  final String? motivation;

  /// Creates an immutable goal activation command.
  const GoalInput({
    required this.id,
    required this.type,
    required this.startedAt,
    this.weeklyLimit,
    this.contextKeys = const [],
    this.motivation,
  });
}
