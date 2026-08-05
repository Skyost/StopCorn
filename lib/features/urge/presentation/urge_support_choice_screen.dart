import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_action_buttons.dart';
import 'package:stopcorn/app/widgets/app_page.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/urge/application/ordered_strategies_provider.dart';
import 'package:stopcorn/features/urge/application/urge_flow_controller.dart';
import 'package:stopcorn/features/urge/domain/urge_flow_state.dart';
import 'package:stopcorn/features/urge/presentation/urge_flow_navigation.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Lets the user choose the form of immediate support they want.
final class UrgeSupportChoiceScreen extends ConsumerWidget {
  /// Creates the immediate-support choice screen.
  const UrgeSupportChoiceScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<StrategyOption>> strategies = ref.watch(
      orderedStrategiesProvider,
    );
    UrgeFlowController controller = ref.read(
      urgeFlowControllerProvider.notifier,
    );
    return UrgeGuard(
      child: AppPage(
        title: Text(context.t.urge.support.pageTitle),
        showBackButton: true,
        onBackButtonPressed: () => quitUrgeFlow(context, ref),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            AppSectionHeader(
              title: Text(context.t.urge.support.title),
              subtitle: Text(context.t.urge.support.subtitle),
            ),
            strategies.when(
              loading: () => Column(
                crossAxisAlignment: .stretch,
                children: [
                  _supportChoices(
                    context,
                    controller,
                    planCount: null,
                    otherIdeasCount: null,
                  ),
                  const SizedBox(height: AppSpacing.big),
                  const AsyncStatePanel(child: LoadingState()),
                ],
              ),
              error: (error, _) => Column(
                crossAxisAlignment: .stretch,
                children: [
                  _supportChoices(
                    context,
                    controller,
                    planCount: null,
                    otherIdeasCount: null,
                  ),
                  const SizedBox(height: AppSpacing.big),
                  AsyncStatePanel(
                    child: ErrorState(
                      message: context.t.urge.strategy.loadError,
                      error: error,
                      onRetry: () => ref.invalidate(orderedStrategiesProvider),
                    ),
                  ),
                ],
              ),
              data: (items) {
                int planCount = items.where((item) => item.isInBackupPlan).length;
                int otherIdeasCount = items.length - planCount;
                return _supportChoices(
                  context,
                  controller,
                  planCount: planCount,
                  otherIdeasCount: otherIdeasCount,
                );
              },
            ),
            const SizedBox(height: AppSpacing.section),
            AppActionButtons(
              onSecondaryPress: () => quitUrgeFlow(context, ref),
              secondaryLabel: Text(context.t.urge.quit),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the three available support choices and their live counts.
  Widget _supportChoices(
    BuildContext context,
    UrgeFlowController controller, {
    required int? planCount,
    required int? otherIdeasCount,
  }) => FTileGroup(
    semanticsLabel: context.t.urge.support.semantics,
    children: [
      FTile(
        key: const Key('guided_pause_choice'),
        prefix: const Icon(FLucideIcons.wind),
        title: Text(context.t.urge.support.guidedTitle),
        subtitle: AppTileSubtitle(
          child: Text(context.t.urge.support.guidedDescription),
        ),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () => _openPath(
          context,
          controller,
          .guidedPause,
        ),
      ),
      FTile(
        key: const Key('backup_plan_choice'),
        prefix: const Icon(FLucideIcons.shieldCheck),
        title: Text(context.t.urge.support.planTitle),
        subtitle: AppTileSubtitle(
          child: Text(
            planCount == null ? context.t.app.loading : context.t.urge.support.planDescription(count: planCount),
          ),
        ),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: planCount == null || planCount == 0
            ? null
            : () => _openPath(
                context,
                controller,
                .backupPlan,
              ),
      ),
      FTile(
        key: const Key('other_ideas_choice'),
        prefix: const Icon(FLucideIcons.sparkles),
        title: Text(context.t.urge.support.ideasTitle),
        subtitle: AppTileSubtitle(
          child: Text(
            otherIdeasCount == null
                ? context.t.app.loading
                : context.t.urge.support.ideasDescription(
                    count: otherIdeasCount,
                  ),
          ),
        ),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: otherIdeasCount == null || otherIdeasCount == 0
            ? null
            : () => _openPath(
                context,
                controller,
                .otherIdeas,
              ),
      ),
    ],
  );

  /// Records [path] and opens its corresponding route.
  void _openPath(
    BuildContext context,
    UrgeFlowController controller,
    UrgeSupportPath path,
  ) {
    if (!controller.chooseSupportPath(path)) {
      return;
    }
    String location = switch (path) {
      .guidedPause => AppRoutes.urgePause,
      .backupPlan => AppRoutes.urgePlan,
      .otherIdeas => AppRoutes.urgeIdeas,
    };
    context.go(location);
  }
}
