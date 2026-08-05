/// One local calendar day represented in the recent harvest.
final class HarvestDay {
  /// Local date at the start of the represented day.
  final DateTime date;

  /// Whether at least one constructive action was persisted that day.
  final bool cultivated;

  /// Creates one immutable harvest day.
  const HarvestDay({
    required this.date,
    required this.cultivated,
  });
}

/// Immutable progress earned from constructive, locally persisted actions.
final class HarvestSummary {
  /// Total number of unique cultivated days.
  final int grainCount;

  /// Consecutive cultivated days ending today or yesterday.
  final int currentMomentum;

  /// Longest consecutive sequence of cultivated days.
  final int bestMomentum;

  /// Seven local calendar days ending today.
  final List<HarvestDay> recentDays;

  /// Creates a complete harvest snapshot.
  const HarvestSummary({
    required this.grainCount,
    required this.currentMomentum,
    required this.bestMomentum,
    required this.recentDays,
  });

  /// Whether a Corn point has already been earned today.
  bool get cultivatedToday => recentDays.last.cultivated;
}
