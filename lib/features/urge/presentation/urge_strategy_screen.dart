import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_action_buttons.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_countdown.dart';
import 'package:stopcorn/app/widgets/app_page.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/app_selection_checkbox.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/features/urge/application/ordered_strategies_provider.dart';
import 'package:stopcorn/features/urge/application/urge_flow_controller.dart';
import 'package:stopcorn/features/urge/domain/urge_flow_state.dart';
import 'package:stopcorn/features/urge/presentation/urge_flow_navigation.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Lets the user choose and start one realistic coping strategy.
final class UrgeStrategyScreen extends ConsumerWidget {
  /// Strategy collection displayed by this screen.
  final UrgeSupportPath path;

  /// Creates the strategy selection screen.
  const UrgeStrategyScreen({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UrgeFlowState flow = ref.watch(urgeFlowControllerProvider);
    AsyncValue<List<StrategyOption>> strategies = ref.watch(
      orderedStrategiesProvider,
    );
    UrgeFlowController controller = ref.read(
      urgeFlowControllerProvider.notifier,
    );
    bool strategyStarted = flow.strategyStartedAt != null;
    int? suggestedSeconds = flow.selectedStrategyId == null ? null : strategySuggestedSeconds(flow.selectedStrategyId!);
    String title = switch (path) {
      .backupPlan => context.t.urge.strategy.planTitle,
      .otherIdeas => context.t.urge.strategy.ideasTitle,
      .guidedPause => context.t.urge.strategy.title,
    };
    String subtitle = switch (path) {
      .backupPlan => context.t.urge.strategy.planSubtitle,
      .otherIdeas => context.t.urge.strategy.ideasSubtitle,
      .guidedPause => context.t.urge.strategy.subtitle,
    };
    return UrgeGuard(
      child: AppPage(
        title: Text(context.t.urge.strategy.pageTitle),
        showBackButton: true,
        onBackButtonPressed: () => quitUrgeFlow(context, ref),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            AppSectionHeader(
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            strategies.when(
              loading: () => const AsyncStatePanel(child: LoadingState()),
              error: (error, _) => AsyncStatePanel(
                child: ErrorState(
                  message: context.t.urge.strategy.loadError,
                  error: error,
                  onRetry: () => ref.invalidate(orderedStrategiesProvider),
                ),
              ),
              data: (items) {
                List<StrategyOption> visible = items.where(_includesStrategy).toList();
                if (visible.isEmpty) {
                  return AppCard(
                    child: Text(context.t.urge.strategy.empty),
                  );
                }
                return FTileGroup(
                  semanticsLabel: context.t.urge.strategy.semantics,
                  children: [
                    for (final StrategyOption strategy in visible)
                      FTile(
                        title: Text(strategyTitle(strategy.id)),
                        subtitle: AppTileSubtitle(
                          child: Text(strategyDescription(strategy.id)),
                        ),
                        selected: flow.selectedStrategyId == strategy.id,
                        suffix: AppSelectionCheckbox(
                          value: flow.selectedStrategyId == strategy.id,
                          enabled: flow.strategyStartedAt == null,
                          circular: true,
                        ),
                        onPress: flow.strategyStartedAt == null ? () => controller.chooseStrategy(strategy.id) : null,
                      ),
                  ],
                );
              },
            ),
            if (flow.errorMessage != null) ...[
              const SizedBox(height: AppSpacing.big),
              Text(flow.errorMessage!),
            ],
            const SizedBox(height: AppSpacing.section),
            if (strategyStarted) ...[
              if (suggestedSeconds == null)
                AppCard(
                  child: Row(
                    children: [
                      const Icon(FLucideIcons.timer),
                      const SizedBox(width: AppSpacing.medium),
                      Expanded(
                        child: Text(
                          context.t.urge.strategy.started(
                            strategy: strategyTitle(flow.selectedStrategyId!),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                AppCountdown(
                  key: const Key('strategy_countdown'),
                  startedAt: flow.strategyStartedAt!,
                  totalSeconds: suggestedSeconds,
                  now: () => ref.read(appClockProvider).now(),
                  builder: (context, countdown) => _StrategyCountdownCard(
                    strategy: strategyTitle(flow.selectedStrategyId!),
                    countdown: countdown,
                  ),
                ),
              const SizedBox(height: AppSpacing.big),
            ],
            AppActionButtons(
              primarySize: strategyStarted ? .md : .lg,
              onPrimaryPress: strategyStarted
                  ? () {
                      controller.moveToReassessment();
                      context.go(AppRoutes.urgeResult);
                    }
                  : flow.selectedStrategyId == null || flow.isSaving
                  ? null
                  : () => controller.selectStrategy(flow.selectedStrategyId!),
              primaryLabel: Text(
                strategyStarted
                    ? context.t.urge.strategy.reassess
                    : flow.isSaving
                    ? context.t.app.saving
                    : context.t.urge.strategy.start,
              ),
              onSecondaryPress: () => quitUrgeFlow(context, ref),
              secondaryLabel: Text(context.t.urge.quit),
            ),
          ],
        ),
      ),
    );
  }

  /// Reports whether [strategy] belongs to the requested collection.
  bool _includesStrategy(StrategyOption strategy) => switch (path) {
    .backupPlan => strategy.isInBackupPlan,
    .otherIdeas => !strategy.isInBackupPlan,
    .guidedPause => false,
  };
}

/// Displays a running, non-blocking countdown for one selected action.
final class _StrategyCountdownCard extends StatelessWidget {
  /// Localized title of the action currently being tried.
  final String strategy;

  /// Latest countdown value synchronized from its original start time.
  final AppCountdownValue countdown;

  /// Creates the indicative action countdown.
  const _StrategyCountdownCard({
    required this.strategy,
    required this.countdown,
  });

  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        Row(
          children: [
            const Icon(FLucideIcons.timer),
            const SizedBox(width: AppSpacing.medium),
            Expanded(
              child: Text(
                context.t.urge.strategy.started(strategy: strategy),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        Text(
          context.t.urge.strategy.timerTitle,
          textAlign: .center,
          style: context.theme.typography.body.lg.copyWith(
            fontWeight: .w600,
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        Semantics(
          liveRegion: countdown.isComplete,
          label: context.t.urge.strategy.timerSemantics,
          value: context.t.urge.timer.count(
            count: countdown.remainingSeconds,
          ),
          child: ExcludeSemantics(
            child: Text(
              _formatCountdown(countdown.remainingSeconds),
              textAlign: .center,
              style: context.theme.typography.display.lg.copyWith(
                fontWeight: .w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.section),
        FDeterminateProgress(
          value: countdown.progress,
          semanticsLabel: context.t.urge.strategy.timerSemantics,
        ),
        const SizedBox(height: AppSpacing.big),
        AppSubtitle(
          text: context.t.urge.strategy.timerGuidance,
          textAlign: .center,
        ),
        if (countdown.isComplete) ...[
          const SizedBox(height: AppSpacing.medium),
          Text(
            context.t.urge.strategy.timerComplete,
            textAlign: .center,
            style: context.theme.typography.body.md.copyWith(
              fontWeight: .w600,
            ),
          ),
        ],
      ],
    ),
  );
}

/// Formats [totalSeconds] as a stable `mm:ss` countdown value.
String _formatCountdown(int totalSeconds) {
  int minutes = totalSeconds ~/ 60;
  int seconds = totalSeconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:'
      '${seconds.toString().padLeft(2, '0')}';
}
