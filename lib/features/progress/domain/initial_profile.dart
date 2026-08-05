import 'package:stopcorn/core/domain/app_enums.dart';

/// Immutable snapshot of the answers recorded when onboarding completed.
final class InitialProfile {
  /// Date and time at which the initial self-assessment was recorded.
  final DateTime recordedAt;

  /// Goal selected during onboarding, when its historical record is available.
  final GoalType? goalType;

  /// Optional weekly limit attached to the initial reduction goal.
  final int? weeklyLimit;

  /// Context keys attached to the initial contextual goal.
  final List<String> contextKeys;

  /// Optional personal motivation entered during onboarding.
  final String? motivation;

  /// Approximate frequency declared for the seven days before onboarding.
  final int? weeklyFrequency;

  /// Initial perceived-control score from zero to ten.
  final int perceivedControl;

  /// Initial perceived negative-impact score from zero to ten.
  final int negativeImpact;

  /// Initial confidence-to-change score from zero to ten.
  final int confidenceToChange;

  /// Creates a durable presentation-neutral initial profile.
  const InitialProfile({
    required this.recordedAt,
    required this.goalType,
    required this.weeklyLimit,
    required this.contextKeys,
    required this.motivation,
    required this.weeklyFrequency,
    required this.perceivedControl,
    required this.negativeImpact,
    required this.confidenceToChange,
  });
}
