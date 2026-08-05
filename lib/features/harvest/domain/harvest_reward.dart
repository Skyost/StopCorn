/// Rule used to recognize the point earned around an action.
enum HarvestRewardPolicy {
  /// A normal action earns the first Corn point of its local day.
  cultivatedDay,

  /// Debug tooling may grant a point independently from the cultivated day.
  debugBonus,
}

/// Values changed by a newly cultivated local day.
final class HarvestReward {
  /// Corn-point total before the constructive action.
  final int pointsBefore;

  /// Corn-point total after the constructive action.
  final int pointsAfter;

  /// Current momentum before the constructive action.
  final int momentumBefore;

  /// Current momentum after the constructive action.
  final int momentumAfter;

  /// Creates an immutable reward transition.
  const HarvestReward({
    required this.pointsBefore,
    required this.pointsAfter,
    required this.momentumBefore,
    required this.momentumAfter,
  });

  /// Number of Corn points collected by the action.
  int get pointDelta => pointsAfter - pointsBefore;

  /// Number of days added to the current momentum.
  int get momentumDelta => momentumAfter - momentumBefore;
}

/// Outcome of a persisted action that may also yield a harvest reward.
final class HarvestActionResult {
  /// Whether the underlying action succeeded.
  final bool succeeded;

  /// Reward earned by the action, if it cultivated a new day.
  final HarvestReward? reward;

  /// Creates an immutable action outcome.
  const HarvestActionResult({
    required this.succeeded,
    this.reward,
  });
}
