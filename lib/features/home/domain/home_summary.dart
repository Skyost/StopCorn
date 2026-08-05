import 'package:stopcorn/core/domain/app_enums.dart';

/// Aggregated non-judgmental markers displayed on the home screen.
final class HomeSummary {
  /// Active goal direction, if one exists.
  final GoalType? goalType;

  /// Optional motivation attached to the active goal.
  final String? motivation;

  /// Optional limit attached to a reduction goal.
  final int? weeklyLimit;

  /// Stable contexts attached to the active contextual goal.
  final List<String> contextKeys;

  /// Whether today's check-in exists.
  final bool checkInCompletedToday;

  /// Number of urge sessions started today.
  final int urgesToday;

  /// Observed days without a voluntarily recorded event.
  final int daysWithoutRecordedConsumption;

  /// Number of urges reported as passed, reduced, or delayed.
  final int traversedUrges;

  /// Average recent perceived-control score.
  final double? averageControl;

  /// Identifier of the most recently helpful strategy.
  final String? lastHelpfulStrategyId;

  /// Whether enough local observations exist to show a summary.
  final bool hasObservations;

  /// Creates a home summary snapshot.
  const HomeSummary({
    required this.goalType,
    required this.motivation,
    required this.weeklyLimit,
    required this.contextKeys,
    required this.checkInCompletedToday,
    required this.urgesToday,
    required this.daysWithoutRecordedConsumption,
    required this.traversedUrges,
    required this.averageControl,
    required this.lastHelpfulStrategyId,
    required this.hasObservations,
  });
}
