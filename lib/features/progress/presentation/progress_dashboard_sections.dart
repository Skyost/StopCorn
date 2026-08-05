import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:stopcorn/app/widgets/accessible_bar_chart.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/corn_brand_mark.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/utils/app_number.dart';
import 'package:stopcorn/features/harvest/domain/harvest_summary.dart';
import 'package:stopcorn/features/harvest/presentation/harvest_tile.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/features/progress/domain/initial_profile.dart';
import 'package:stopcorn/features/progress/domain/progress_dashboard.dart';
import 'package:stopcorn/features/progress/presentation/progress_interpretations.dart';
import 'package:stopcorn/features/progress/presentation/progress_metric_cards.dart';
import 'package:stopcorn/features/progress/presentation/progress_starting_point.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Offset moving a signed perceived effect onto a positive bar scale.
const double _effectChartOffset = 5.01;

/// Renders all descriptive sections of a loaded dashboard.
List<Widget> progressDashboardSections(
  BuildContext context,
  ProgressDashboard dashboard,
  HarvestSummary? harvest,
) => [
  AppSectionHeader(title: Text(context.t.progress.overview.title)),
  ProgressMetricGrid(
    keyPrefix: 'overview',
    metrics: [
      ProgressMetricData(
        value: formatCount(dashboard.eventCount),
        label: context.t.progress.overview.events(
          count: dashboard.eventCount,
        ),
        detail: eventEvolution(dashboard.eventChangePercent),
      ),
      ProgressMetricData(
        value: formatCount(dashboard.daysWithoutRecordedEvent),
        label: context.t.progress.overview.daysWithout(
          count: dashboard.daysWithoutRecordedEvent,
        ),
      ),
      ProgressMetricData(
        value: formatCount(dashboard.completedUrgeSessions),
        label: context.t.progress.overview.completedUrges(
          count: dashboard.completedUrgeSessions,
        ),
      ),
      ProgressMetricData(
        value: dashboard.averageIntensityDecrease == null ? '—' : formatDecimal(dashboard.averageIntensityDecrease!),
        label: context.t.progress.overview.averageDecrease,
        detail: dashboard.averageIntensityDecrease == null ? context.t.progress.overview.notEnough : context.t.progress.overview.decreaseDetail,
        valueSuffix: dashboard.averageIntensityDecrease == null ? null : '/ 10',
      ),
    ],
  ),
  if (dashboard.activeGoalType != null) ...[
    const SizedBox(height: AppSpacing.big),
    AppCard(
      key: const Key('progress_active_goal_card'),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          const Icon(FLucideIcons.target),
          const SizedBox(width: AppSpacing.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  goalTitle(dashboard.activeGoalType!),
                  style: context.theme.typography.body.lg.copyWith(
                    fontWeight: .w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                Text(
                  activeGoalSummary(context, dashboard),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ],
  if (!dashboard.hasAnyData) ...[
    const SizedBox(height: AppSpacing.big),
    AppCard(
      child: Text(context.t.progress.overview.empty),
    ),
  ],
  if (dashboard.initialProfile case InitialProfile profile) ...[
    const SizedBox(height: AppSpacing.section),
    AppSectionHeader(
      title: Text(context.t.progress.startingPoint.sectionTitle),
      subtitle: Text(
        context.t.progress.startingPoint.comparison.intro,
      ),
    ),
    StartingPointComparison(
      dashboard: dashboard,
      profile: profile,
    ),
  ],
  const SizedBox(height: AppSpacing.section),
  AppSectionHeader(title: Text(context.t.progress.events.title)),
  ProgressChartCard(
    title: context.t.progress.events.weeklyTitle,
    interpretation: weeklyInterpretation(dashboard),
    child: AccessibleBarChart(
      emptyMessage: context.t.progress.events.empty,
      data: [
        for (final WeeklyEventPoint point in dashboard.weeklyEvents)
          AccessibleBarDatum(
            label: context.t.progress.events.weekOf(
              date: DateFormat(
                'd MMM',
                LocaleSettings.currentLocale.languageCode,
              ).format(point.weekStart),
            ),
            value: point.eventCount.toDouble(),
            valueLabel: formatCount(point.eventCount),
          ),
      ],
    ),
  ),
  const SizedBox(height: AppSpacing.section),
  AppSectionHeader(
    title: Text.rich(
      context.t.progress.urges.title(
        corn: cornBrandSpan(context),
      ),
    ),
  ),
  ProgressChartCard(
    title: context.t.progress.urges.averageIntensity,
    interpretation: intensityInterpretation(dashboard),
    child: AccessibleBarChart(
      emptyMessage: context.t.progress.urges.empty,
      maximum: 10,
      data: [
        if (dashboard.averageInitialIntensity case double value?)
          AccessibleBarDatum(
            label: context.t.progress.urges.initial,
            value: value,
            valueLabel: t.app.score.outOfTen(value: formatDecimal(value)),
          ),
        if (dashboard.averageFinalIntensity case double value?)
          AccessibleBarDatum(
            label: context.t.progress.urges.finalLabel,
            value: value,
            valueLabel: t.app.score.outOfTen(value: formatDecimal(value)),
          ),
      ],
    ),
  ),
  const SizedBox(height: AppSpacing.big),
  ProgressChartCard(
    title: context.t.progress.urges.observationHours,
    interpretation: timeInterpretation(dashboard.timeBuckets),
    child: AccessibleBarChart(
      emptyMessage: context.t.progress.urges.noHours,
      data: [
        for (final TimeBucketMetric bucket in dashboard.timeBuckets)
          AccessibleBarDatum(
            label: bucket.label,
            value: bucket.count.toDouble(),
            valueLabel: formatCount(bucket.count),
          ),
      ],
    ),
  ),
  const SizedBox(height: AppSpacing.section),
  AppSectionHeader(title: Text(context.t.progress.patterns.title)),
  ProgressChartCard(
    title: context.t.progress.patterns.triggers.title,
    interpretation: rankingInterpretation(
      dashboard.triggerRanking,
      progressTriggerName,
      context.t.progress.patterns.triggers.kind,
    ),
    child: AccessibleBarChart(
      emptyMessage: context.t.progress.patterns.triggers.empty,
      data: [
        for (final CountMetric item in dashboard.triggerRanking.take(6))
          AccessibleBarDatum(
            label: progressTriggerName(item.key),
            value: item.count.toDouble(),
            valueLabel: '${item.count}',
          ),
      ],
    ),
  ),
  const SizedBox(height: AppSpacing.big),
  ProgressChartCard(
    title: context.t.progress.patterns.emotions.title,
    interpretation: rankingInterpretation(
      dashboard.emotionRanking,
      progressEmotionName,
      context.t.progress.patterns.emotions.kind,
    ),
    child: AccessibleBarChart(
      emptyMessage: context.t.progress.patterns.emotions.empty,
      data: [
        for (final CountMetric item in dashboard.emotionRanking.take(6))
          AccessibleBarDatum(
            label: progressEmotionName(item.key),
            value: item.count.toDouble(),
            valueLabel: '${item.count}',
          ),
      ],
    ),
  ),
  const SizedBox(height: AppSpacing.section),
  AppSectionHeader(title: Text(context.t.progress.strategies.title)),
  ProgressChartCard(
    title: context.t.progress.strategies.effectiveness,
    interpretation: strategyInterpretation(dashboard.strategyMetrics),
    child: AccessibleBarChart(
      emptyMessage: context.t.progress.strategies.empty,
      data: [
        for (final StrategyMetric metric in dashboard.strategyMetrics)
          if (metric.averageEffect case double effect?)
            AccessibleBarDatum(
              label: strategyTitle(metric.strategyId),
              // The perceived effect runs from −5 to 5, which a bar length
              // cannot express. Shifting it onto a 0-to-10 scale keeps the
              // ordering readable; the signed value stays in the label, and
              // the small offset keeps the lowest bar visible.
              value: effect + _effectChartOffset,
              valueLabel: context.t.progress.strategies.evaluations(
                effect: formatSignedDecimal(effect),
                count: metric.evaluatedUseCount,
              ),
            ),
      ],
    ),
  ),
  const SizedBox(height: AppSpacing.section),
  AppSectionHeader(title: Text(context.t.progress.checkIns.title)),
  ProgressMetricGrid(
    keyPrefix: 'check_in',
    metrics: [
      ProgressMetricData(
        value: formatCount(dashboard.checkInCount),
        label: context.t.progress.checkIns.count(
          count: dashboard.checkInCount,
        ),
      ),
      ProgressMetricData(
        value: dashboard.averageMood == null ? '—' : formatDecimal(dashboard.averageMood!),
        label: context.t.progress.checkIns.averageMood,
        valueSuffix: dashboard.averageMood == null ? null : '/ 10',
        detail: dashboard.averageMood == null ? context.t.progress.overview.notEnough : null,
      ),
      ProgressMetricData(
        value: dashboard.averageControl == null ? '—' : formatDecimal(dashboard.averageControl!),
        label: context.t.progress.checkIns.averageControl,
        valueSuffix: dashboard.averageControl == null ? null : '/ 10',
        detail: dashboard.averageControl == null ? context.t.progress.overview.notEnough : null,
      ),
    ],
  ),
  if (harvest != null) ...[
    const SizedBox(height: AppSpacing.section),
    AppSectionHeader(title: Text(context.t.progress.harvest)),
    HarvestTile(
      key: const Key('progress_harvest_card'),
      summary: harvest,
      expanded: true,
    ),
  ],
];

/// Describes progress using the semantics of the active goal.
String activeGoalSummary(BuildContext context, ProgressDashboard dashboard) {
  GoalType type = dashboard.activeGoalType!;
  return switch (type) {
    .abstinence => context.t.progress.overview.goal.abstinence(
      count: dashboard.eventCount,
    ),
    .reduction => context.t.progress.overview.goal.reduction(
      count: dashboard.currentWeekEventCount ?? 0,
      limit: dashboard.weeklyGoalLimit ?? 0,
    ),
    .contextual => context.t.progress.overview.goal.contextual(
      count: dashboard.contextualGoalEventCount ?? 0,
      contexts: dashboard.activeGoalContextKeys.map((key) => contextualOptions[key] ?? key).join(', '),
    ),
    .observation => context.t.progress.overview.goal.observation(
      count: dashboard.eventCount + dashboard.completedUrgeSessions + dashboard.checkInCount,
    ),
  };
}
