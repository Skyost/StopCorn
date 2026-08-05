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
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/features/urge/application/urge_flow_controller.dart';
import 'package:stopcorn/features/urge/domain/urge_flow_state.dart';
import 'package:stopcorn/features/urge/presentation/urge_flow_navigation.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Runs the optional configured grounding pause.
final class UrgePauseScreen extends ConsumerWidget {
  /// Creates the guided pause.
  const UrgePauseScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UrgeFlowState flow = ref.watch(urgeFlowControllerProvider);
    DateTime startedAt = flow.pauseStartedAt ?? ref.read(appClockProvider).now();
    List<String> instructions = [
      context.t.urge.grounding.feet,
      context.t.urge.grounding.inhale,
      context.t.urge.grounding.observe,
      context.t.urge.grounding.exhale,
      context.t.urge.grounding.change,
    ];
    return AppCountdown(
      key: const Key('guided_pause_countdown'),
      startedAt: startedAt,
      totalSeconds: AppConstants.guidedPauseSeconds,
      now: () => ref.read(appClockProvider).now(),
      builder: (context, countdown) {
        int instructionIndex = (countdown.elapsedSeconds * instructions.length ~/ AppConstants.guidedPauseSeconds).clamp(0, instructions.length - 1);
        return UrgeGuard(
          child: AppPage(
            title: Text(context.t.urge.pauseTitle),
            showBackButton: true,
            onBackButtonPressed: () => quitUrgeFlow(context, ref),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                AppSectionHeader(
                  title: Text(context.t.urge.grounding.title),
                  subtitle: Text(context.t.urge.grounding.subtitle),
                ),
                Semantics(
                  liveRegion: true,
                  label: instructions[instructionIndex],
                  child: AppCard(
                    child: Column(
                      children: [
                        Icon(
                          countdown.isComplete ? FLucideIcons.circleCheck : FLucideIcons.wind,
                          size: AppIconSize.display,
                          color: context.theme.colors.primary,
                        ),
                        const SizedBox(height: AppSpacing.big),
                        Text(
                          instructions[instructionIndex],
                          textAlign: .center,
                          style: context.theme.typography.display.lg.copyWith(
                            fontWeight: .w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.section),
                        FDeterminateProgress(
                          value: countdown.progress,
                          semanticsLabel: context.t.urge.grounding.semantics,
                        ),
                        const SizedBox(height: AppSpacing.medium),
                        Text(
                          context.t.urge.timer.count(
                            count: countdown.remainingSeconds,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.section),
                AppActionButtons(
                  primaryVariant: countdown.isComplete ? .primary : .outline,
                  onPrimaryPress: () => _continue(
                    context,
                    ref,
                    countdown.elapsedSeconds,
                  ),
                  primaryLabel: Text(
                    countdown.isComplete ? context.t.app.continueLabel : context.t.urge.grounding.skip,
                  ),
                  onSecondaryPress: () => quitUrgeFlow(context, ref),
                  secondaryLabel: Text(context.t.urge.quit),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Completes the pause after [elapsedSeconds] and opens the final check-in.
  void _continue(
    BuildContext context,
    WidgetRef ref,
    int elapsedSeconds,
  ) {
    ref.read(urgeFlowControllerProvider.notifier).finishPause(elapsedSeconds);
    context.go(AppRoutes.urgeResult);
  }
}
