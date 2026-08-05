import 'package:flutter/material.dart' show SelectionArea;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_page.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/goals/data/goal_repository.dart';
import 'package:stopcorn/features/goals/domain/goal_history_entry.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays every goal the person has set, including the ones already ended.
///
/// Goal history is kept by the database anyway; showing it lets someone see
/// how their own direction changed instead of only the current one.
final class GoalHistoryScreen extends ConsumerWidget {
  /// Creates the goal history screen.
  const GoalHistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<GoalHistoryEntry>> history = ref.watch(goalHistoryProvider);
    return AppPage(
      title: Text(context.t.settings.personalPlan.history.title),
      showBackButton: true,
      backFallbackLocation: AppRoutes.settings,
      child: history.when(
        loading: () => const AsyncStatePanel(child: LoadingState()),
        error: (error, _) => AsyncStatePanel(
          child: ErrorState(
            message: context.t.settings.personalPlan.history.error,
            error: error,
            onRetry: () => ref.invalidate(goalHistoryProvider),
          ),
        ),
        data: (goals) => goals.isEmpty ? const _EmptyGoalHistory() : _GoalHistory(goals: goals),
      ),
    );
  }
}

/// Explains that no goal has been recorded yet.
final class _EmptyGoalHistory extends StatelessWidget {
  /// Creates the empty goal history.
  const _EmptyGoalHistory();

  @override
  Widget build(BuildContext context) => AppCard(
    child: Text(context.t.settings.personalPlan.history.empty),
  );
}

/// Lists goals from the most recent to the oldest.
final class _GoalHistory extends StatelessWidget {
  /// Goals ordered from newest to oldest.
  final List<GoalHistoryEntry> goals;

  /// Creates the history of [goals].
  const _GoalHistory({
    required this.goals,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .stretch,
    children: [
      AppSubtitle(text: context.t.settings.personalPlan.history.subtitle),
      const SizedBox(height: AppSpacing.section),
      AppSectionHeader(
        title: Text(
          context.t.settings.personalPlan.history.count(count: goals.length),
        ),
      ),
      FTileGroup(
        children: [
          for (final GoalHistoryEntry goal in goals) _goalTile(context, goal),
        ],
      ),
    ],
  );

  /// Builds one history row describing [goal] and its period.
  FTile _goalTile(BuildContext context, GoalHistoryEntry goal) {
    GoalType? type = goal.type;
    DateFormat format = DateFormat.yMMMMd(
      LocaleSettings.currentLocale.languageCode,
    );
    return FTile(
      key: Key('goal_history_${goal.id}'),
      prefix: Icon(
        goal.isActive ? FLucideIcons.target : FLucideIcons.history,
      ),
      title: Text(type == null ? context.t.app.unknown : goalTitle(type)),
      subtitle: AppTileSubtitle(
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(
              context.t.settings.personalPlan.history.started(
                date: format.format(goal.startedAt),
              ),
            ),
            if (goal.endedAt case DateTime endedAt)
              Text(
                context.t.settings.personalPlan.history.ended(
                  date: format.format(endedAt),
                ),
              ),
            if (goal.weeklyLimit case int limit)
              Text(
                context.t.settings.personalPlan.history.weeklyLimit(
                  count: limit,
                ),
              ),
            if (goal.contextKeys.isNotEmpty)
              Text(
                context.t.settings.personalPlan.history.contexts(
                  contexts: goal.contextKeys.map((key) => contextualOptions[key] ?? key).join(', '),
                ),
              ),
            if (goal.motivation case String motivation when motivation.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.small),
              SelectionArea(child: Text(motivation)),
            ],
          ],
        ),
      ),
      suffix: goal.isActive ? FBadge(child: Text(context.t.settings.personalPlan.history.current)) : null,
    );
  }
}
