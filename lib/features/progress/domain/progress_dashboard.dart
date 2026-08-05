import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/progress/domain/initial_profile.dart';
import 'package:stopcorn/features/progress/domain/progress_period.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// One ranked count identified by a stable enum or content key.
final class CountMetric {
  /// Stable value key.
  final String key;

  /// Number of observations carrying [key].
  final int count;

  /// Creates a count metric.
  const CountMetric({
    required this.key,
    required this.count,
  });
}

/// Aggregated use and optional perceived effect for one strategy.
final class StrategyMetric {
  /// Stable coping-strategy identifier.
  final String strategyId;

  /// Total number of uses in the period.
  final int useCount;

  /// Number of uses with a perceived-effect score.
  final int evaluatedUseCount;

  /// Average effect from minus five to five, when evaluated.
  final double? averageEffect;

  /// Creates a strategy aggregate.
  const StrategyMetric({
    required this.strategyId,
    required this.useCount,
    required this.evaluatedUseCount,
    this.averageEffect,
  });
}

/// Observation count inside one four-hour local-time bucket.
final class TimeBucketMetric {
  /// Inclusive local start hour.
  final int startHour;

  /// Exclusive local end hour.
  final int endHourExclusive;

  /// Number of observed urges and events in the bucket.
  final int count;

  /// Creates a local-time bucket metric.
  const TimeBucketMetric({
    required this.startHour,
    required this.endHourExclusive,
    required this.count,
  });

  /// Localized human-readable time range.
  String get label {
    if (endHourExclusive == 24) {
      return t.progress.urges.timeBucket.midnight(start: startHour);
    }
    return t.progress.urges.timeBucket.range(
      start: startHour,
      end: endHourExclusive,
    );
  }
}

/// Number of voluntarily recorded events in one calendar week.
final class WeeklyEventPoint {
  /// Local Monday at the start of the week.
  final DateTime weekStart;

  /// Number of events in that week.
  final int eventCount;

  /// Creates a weekly event point.
  const WeeklyEventPoint({
    required this.weekStart,
    required this.eventCount,
  });
}

/// Complete immutable set of descriptive progress aggregates.
final class ProgressDashboard {
  /// Selected aggregation period.
  final ProgressPeriod period;

  /// Inclusive local start of the observed period.
  final DateTime periodStart;

  /// Voluntarily recorded event count.
  final int eventCount;

  /// Observed day count without a recorded event.
  final int daysWithoutRecordedEvent;

  /// Number of local calendar days represented by the selected period.
  final int observedDayCount;

  /// Number of completed urge-support sessions.
  final int completedUrgeSessions;

  /// Event-count change from the preceding comparable period.
  final double? eventChangePercent;

  /// Mean starting intensity across completed urges.
  final double? averageInitialIntensity;

  /// Mean ending intensity where one was recorded.
  final double? averageFinalIntensity;

  /// Mean initial-minus-final intensity.
  final double? averageIntensityDecrease;

  /// Number of daily check-ins.
  final int checkInCount;

  /// Mean reported mood across check-ins.
  final double? averageMood;

  /// Mean reported perceived control across check-ins.
  final double? averageControl;

  /// Trigger counts sorted from most to least frequent.
  final List<CountMetric> triggerRanking;

  /// Emotion counts sorted from most to least frequent.
  final List<CountMetric> emotionRanking;

  /// Coping-strategy use aggregates.
  final List<StrategyMetric> strategyMetrics;

  /// Counts grouped into local four-hour buckets.
  final List<TimeBucketMetric> timeBuckets;

  /// Event counts grouped into calendar weeks.
  final List<WeeklyEventPoint> weeklyEvents;

  /// Optional weekly limit from an active reduction goal.
  final int? weeklyGoalLimit;

  /// Current calendar-week event count when a limit exists.
  final int? currentWeekEventCount;

  /// Direction of the active goal represented by this dashboard.
  final GoalType? activeGoalType;

  /// Stable contexts protected by the active contextual goal.
  final List<String> activeGoalContextKeys;

  /// Events in the selected period matching an active protected context.
  final int? contextualGoalEventCount;

  /// Answers recorded when the user completed onboarding.
  final InitialProfile? initialProfile;

  /// Creates a progress dashboard snapshot.
  const ProgressDashboard({
    required this.period,
    required this.periodStart,
    required this.eventCount,
    required this.daysWithoutRecordedEvent,
    required this.observedDayCount,
    required this.completedUrgeSessions,
    required this.checkInCount,
    required this.triggerRanking,
    required this.emotionRanking,
    required this.strategyMetrics,
    required this.timeBuckets,
    required this.weeklyEvents,
    this.eventChangePercent,
    this.averageInitialIntensity,
    this.averageFinalIntensity,
    this.averageIntensityDecrease,
    this.averageMood,
    this.averageControl,
    this.weeklyGoalLimit,
    this.currentWeekEventCount,
    this.activeGoalType,
    this.activeGoalContextKeys = const [],
    this.contextualGoalEventCount,
    this.initialProfile,
  });

  /// Whether at least one primary observation exists in this period.
  bool get hasAnyData => eventCount > 0 || completedUrgeSessions > 0 || checkInCount > 0;

  /// Recorded events normalized to a seven-day average after one full week.
  double? get averageWeeklyRecordedEvents => observedDayCount < 7 ? null : eventCount * 7 / observedDayCount;
}
