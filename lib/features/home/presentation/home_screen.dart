import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_equal_height_row.dart';
import 'package:stopcorn/app/widgets/app_metric_card.dart';
import 'package:stopcorn/app/widgets/app_page_viewport.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/app_selection_checkbox.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/app/widgets/corn_brand_mark.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/utils/app_number.dart';
import 'package:stopcorn/features/harvest/application/harvest_providers.dart';
import 'package:stopcorn/features/harvest/domain/harvest_summary.dart';
import 'package:stopcorn/features/harvest/presentation/harvest_tile.dart';
import 'package:stopcorn/features/home/data/home_repository.dart';
import 'package:stopcorn/features/home/domain/home_summary.dart';
import 'package:stopcorn/features/home/presentation/home_learning_recommendation.dart';
import 'package:stopcorn/features/learning/application/module_controller.dart';
import 'package:stopcorn/features/learning/domain/learning_library_item.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays today's markers and the primary actions.
final class HomeScreen extends ConsumerWidget {
  /// Creates the home screen.
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<HomeSummary> summary = ref.watch(homeSummaryProvider);
    AsyncValue<List<LearningLibraryItem>> library = ref.watch(
      learningLibraryProvider,
    );
    bool showHarvest = ref.watch(harvestVisibilityProvider).value ?? false;
    HarvestSummary? harvest = showHarvest ? ref.watch(harvestSummaryProvider).value : null;
    List<LearningLibraryItem>? modules = library.value;
    LearningLibraryItem? recommendation = modules == null ? null : selectLearningRecommendation(modules);
    return summary.when(
      loading: () => const AppPageList(
        children: [AsyncStatePanel(child: LoadingState())],
      ),
      error: (error, _) => AppPageList(
        children: [
          AsyncStatePanel(
            child: ErrorState(
              message: context.t.home.load.error,
              error: error,
              onRetry: () => ref.invalidate(homeSummaryProvider),
            ),
          ),
        ],
      ),
      data: (value) => _HomeContent(
        summary: value,
        harvest: harvest,
        recommendation: recommendation,
      ),
    );
  }
}

/// Renders the loaded home summary and primary actions.
final class _HomeContent extends StatelessWidget {
  /// Aggregated home data.
  final HomeSummary summary;

  /// Optional constructive-action harvest.
  final HarvestSummary? harvest;

  /// Current or next learning module suggested on the Home screen.
  final LearningLibraryItem? recommendation;

  /// Creates home content for [summary].
  const _HomeContent({
    required this.summary,
    required this.harvest,
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) => AppPageList(
    children: [
      AppButton(
        key: const Key('home_urge_button'),
        size: .lg,
        semanticsLabel: context.t.home.urge.semantics,
        onPress: () => context.push(AppRoutes.urge),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                children: [
                  context.t.home.urge.action(
                    corn: cornBrandSpan(
                      context,
                      style: context.theme.typography.body.lg,
                    ),
                  ),
                ],
                style: context.theme.typography.body.lg.copyWith(
                  color: context.theme.colors.primaryForeground,
                  fontWeight: .w700,
                  height: 1.25,
                ),
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: context.t.home.urge.subtitle,
                style: context.theme.typography.body.xs.copyWith(
                  color: context.theme.colors.primaryForeground,
                  fontWeight: .w400,
                  height: 1.25,
                ),
              ),
            ],
          ),
          textAlign: .center,
        ),
      ),
      const SizedBox(height: AppSpacing.section),
      AppSectionHeader(title: Text(context.t.home.sections.today)),
      FTileGroup(
        label: harvest == null ? null : Text(context.t.home.sections.metrics),
        children: [
          FTile(
            title: Text(context.t.home.goal.title),
            subtitle: AppTileSubtitle(
              child: Text(
                summary.goalType == null ? context.t.home.goal.undefined : _activeGoalDescription(context, summary),
              ),
            ),
            prefix: const Icon(FLucideIcons.target),
            suffix: summary.goalType == null ? const Icon(FLucideIcons.chevronRight) : Text(goalTitle(summary.goalType!)),
            onPress: summary.goalType == null ? (() => context.push(AppRoutes.settings)) : null,
          ),
          FTile(
            title: Text(context.t.home.urge.today),
            subtitle: AppTileSubtitle(
              child: Text.rich(
                context.t.home.urge.count(
                  count: summary.urgesToday,
                  countBuilder: (count) => TextSpan(text: '$count'),
                ),
              ),
            ),
            prefix: const Icon(FLucideIcons.activity),
            suffix: Text(summary.urgesToday.toString()),
          ),
          FTile(
            prefix: AppSelectionCheckbox(
              value: summary.checkInCompletedToday,
              circular: true,
            ),
            title: Text(context.t.home.checkIn.title),
            subtitle: AppTileSubtitle(
              child: Text(summary.checkInCompletedToday ? context.t.home.checkIn.completed : context.t.home.checkIn.available),
            ),
            onPress: () => context.push(AppRoutes.checkIn),
            suffix: const Icon(FLucideIcons.chevronRight),
          ),
          if (summary.lastHelpfulStrategyId != null)
            FTile(
              prefix: const Icon(FLucideIcons.sparkles),
              title: Text(context.t.home.strategy.lastHelpful),
              subtitle: AppTileSubtitle(
                child: Text('${strategyTitle(summary.lastHelpfulStrategyId!)}.'),
              ),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => context.replace(AppRoutes.progress),
            ),
        ],
      ),
      if (harvest != null) ...[
        const SizedBox(height: AppSpacing.big),
        HarvestTile(
          showLabel: true,
          summary: harvest!,
        ),
      ],
      const SizedBox(height: AppSpacing.section),
      AppSectionHeader(title: Text(context.t.home.sections.lastThirtyDays)),
      AppEqualHeightRow(
        children: [
          AppMetricCard(
            key: const Key('home_metric_days_without'),
            value: formatCount(summary.daysWithoutRecordedConsumption),
            label: Text(
              context.t.home.metrics.daysWithout(
                count: summary.daysWithoutRecordedConsumption,
              ),
            ),
            centered: true,
          ),
          AppMetricCard(
            key: const Key('home_metric_traversed_urges'),
            value: formatCount(summary.traversedUrges),
            label: Text(
              context.t.home.metrics.traversedUrges(
                count: summary.traversedUrges,
              ),
            ),
            centered: true,
          ),
          if (summary.averageControl != null)
            AppMetricCard(
              key: const Key('home_metric_average_control'),
              value: formatDecimal(summary.averageControl!),
              label: Text(context.t.home.metrics.averageControl),
              valueSuffix: '/ 10',
              centered: true,
            ),
        ],
      ),
      if (!summary.hasObservations) ...[
        const SizedBox(height: AppSpacing.big),
        AppSubtitle(text: context.t.home.metrics.empty),
      ],
      const SizedBox(height: AppSpacing.section),
      AppSectionHeader(title: Text(context.t.home.sections.quickActions)),
      FTileGroup(
        children: [
          FTile(
            key: const Key('home_quick_journal'),
            onPress: () => context.push(AppRoutes.journal),
            prefix: const Icon(FLucideIcons.notebookTabs),
            suffix: const Icon(FLucideIcons.chevronRight),
            title: Text(context.t.home.actions.openJournal),
          ),
          FTile(
            key: const Key('home_quick_check_in'),
            onPress: () => context.push(AppRoutes.checkIn),
            prefix: Icon(summary.checkInCompletedToday ? FLucideIcons.clipboardCheck : FLucideIcons.clipboard),
            suffix: const Icon(FLucideIcons.chevronRight),
            title: Text(summary.checkInCompletedToday ? context.t.home.checkIn.action.done : context.t.home.checkIn.action.pending),
          ),
          FTile(
            key: const Key('home_quick_log_consumption'),
            onPress: () => context.push(AppRoutes.logConsumption),
            prefix: const Icon(FLucideIcons.notebookPen),
            suffix: const Icon(FLucideIcons.chevronRight),
            title: Text(context.t.home.actions.logConsumption),
          ),
          FTile(
            key: const Key('home_quick_review_plan'),
            onPress: () => context.push(AppRoutes.settings),
            prefix: const Icon(FLucideIcons.listChecks),
            suffix: const Icon(FLucideIcons.chevronRight),
            title: Text(context.t.home.actions.reviewPlan),
          ),
        ],
      ),
      if (recommendation != null) ...[
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(title: Text(context.t.home.learningRecommendation.title)),
        LearningRecommendationCard(item: recommendation!),
      ],
    ],
  );
}

/// Builds a goal-specific home description from the active plan details.
String _activeGoalDescription(BuildContext context, HomeSummary summary) {
  GoalType type = summary.goalType!;
  List<String> lines = [goalDescription(type)];
  if (type == .reduction && summary.weeklyLimit != null) {
    lines.add(
      context.t.home.goal.weeklyLimit(count: summary.weeklyLimit!),
    );
  }
  if (type == .contextual && summary.contextKeys.isNotEmpty) {
    lines.add(
      context.t.home.goal.contexts(
        contexts: summary.contextKeys.map((key) => contextualOptions[key] ?? key).join(', '),
      ),
    );
  }
  if (summary.motivation case String motivation when motivation.isNotEmpty) {
    lines.add(motivation);
  }
  return lines.join('\n');
}
