import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/utils/app_number.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/features/progress/domain/progress_dashboard.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Describes event-count change from the previous comparable period.
String? eventEvolution(double? value) {
  if (value == null) {
    return null;
  }
  if (value == 0) {
    return t.progress.comparison.stable;
  }
  String direction = value > 0 ? t.progress.comparison.more : t.progress.comparison.less;
  return t.progress.comparison.value(
    value: formatCount(value.abs().round()),
    direction: direction,
  );
}

/// Summarizes the weekly event chart in text.
String weeklyInterpretation(ProgressDashboard dashboard) {
  if (dashboard.eventCount == 0) {
    return t.progress.events.empty;
  }
  return t.progress.events.summary(count: dashboard.eventCount);
}

/// Summarizes initial-to-final urge intensity in text.
String intensityInterpretation(ProgressDashboard dashboard) {
  double? decrease = dashboard.averageIntensityDecrease;
  if (decrease == null) {
    return t.progress.urges.comparison.unavailable;
  }
  return decrease >= 0
      ? t.progress.urges.comparison.decrease(
          count: decrease,
          value: formatDecimal(decrease),
        )
      : t.progress.urges.comparison.increase(
          count: decrease.abs(),
          value: formatDecimal(decrease.abs()),
        );
}

/// Summarizes the most populated local-time bucket.
String timeInterpretation(List<TimeBucketMetric> buckets) {
  List<TimeBucketMetric> populated = buckets.where((bucket) => bucket.count > 0).toList();
  if (populated.isEmpty) {
    return t.progress.overview.notEnough;
  }
  populated.sort((first, second) => second.count.compareTo(first.count));
  return t.progress.urges.hourSummary(label: populated.first.label);
}

/// Summarizes the leading trigger or emotion ranking.
String rankingInterpretation(
  List<CountMetric> ranking,
  String Function(String) label,
  String kind,
) {
  if (ranking.isEmpty) {
    return t.progress.overview.notEnough;
  }
  return t.progress.patterns.rankingSummary(
    label: label(ranking.first.key),
    kind: kind,
  );
}

/// Summarizes strategy evidence while respecting the reliability threshold.
String strategyInterpretation(List<StrategyMetric> metrics) {
  List<StrategyMetric> eligible = metrics.where((metric) => metric.useCount >= 3 && metric.averageEffect != null).toList();
  if (eligible.isEmpty) {
    return t.progress.strategies.threshold;
  }
  eligible.sort(
    (first, second) => second.averageEffect!.compareTo(first.averageEffect!),
  );
  return t.progress.strategies.best(
    strategy: strategyTitle(eligible.first.strategyId),
  );
}

/// Resolves a persisted trigger name with a safe unknown fallback.
String progressTriggerName(String stored) {
  TriggerType? value = TriggerType.values.where((trigger) => trigger.name == stored).firstOrNull;
  return value == null ? t.trigger.other : triggerLabel(value);
}

/// Resolves a persisted emotion name with a safe unknown fallback.
String progressEmotionName(String stored) {
  EmotionType? value = EmotionType.values.where((emotion) => emotion.name == stored).firstOrNull;
  return value == null ? t.emotion.other : emotionLabel(value);
}
