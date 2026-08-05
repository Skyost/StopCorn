import 'package:stopcorn/core/domain/app_enums.dart';

/// One goal the person has set, active or already ended.
final class GoalHistoryEntry {
  /// Stable goal identifier.
  final String id;

  /// Selected direction, or `null` when the stored type is unknown.
  final GoalType? type;

  /// Whether this is the goal currently being pursued.
  final bool isActive;

  /// Local instant at which the goal began.
  final DateTime startedAt;

  /// Local instant at which the goal stopped being active.
  final DateTime? endedAt;

  /// Optional weekly limit attached to a reduction goal.
  final int? weeklyLimit;

  /// Stable contexts attached to a contextual goal.
  final List<String> contextKeys;

  /// Optional reason the person wrote for this goal.
  final String? motivation;

  /// Creates one immutable goal-history entry.
  const GoalHistoryEntry({
    required this.id,
    required this.type,
    required this.isActive,
    required this.startedAt,
    this.endedAt,
    this.weeklyLimit,
    this.contextKeys = const [],
    this.motivation,
  });
}
