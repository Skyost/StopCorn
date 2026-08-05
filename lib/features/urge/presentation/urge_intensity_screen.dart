import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_navigation.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_action_buttons.dart';
import 'package:stopcorn/app/widgets/app_page.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/optional_choice_tile.dart';
import 'package:stopcorn/app/widgets/score_selector.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/features/urge/application/urge_flow_controller.dart';
import 'package:stopcorn/features/urge/domain/urge_flow_state.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Captures the initial intensity and optional context of an urge.
final class UrgeIntensityScreen extends ConsumerWidget {
  /// Creates the initial urge screen.
  const UrgeIntensityScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UrgeFlowState flow = ref.watch(urgeFlowControllerProvider);
    UrgeFlowController controller = ref.read(
      urgeFlowControllerProvider.notifier,
    );
    return AppPage(
      title: Text(context.t.urge.pauseTitle),
      showBackButton: true,
      backFallbackLocation: AppRoutes.home,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          AppSectionHeader(
            title: Text.rich(context.t.urge.intensity.title),
            subtitle: Text(context.t.urge.intensity.subtitle),
          ),
          ScoreSelector(
            label: context.t.urge.intensity.label,
            value: flow.initialIntensity,
            onChanged: controller.setInitialIntensity,
          ),
          const SizedBox(height: AppSpacing.section),
          AppSectionHeader(
            title: Text(context.t.urge.factors.title),
            subtitle: Text(context.t.urge.factors.subtitle),
          ),
          FTileGroup(
            label: Text(context.t.urge.factors.label),
            children: [
              OptionalChoiceTile<TriggerType>(
                title: Text(context.t.urge.factors.trigger),
                value: flow.triggerType,
                values: TriggerType.values,
                format: triggerLabel,
                onSelected: controller.setTrigger,
              ),
              OptionalChoiceTile<EmotionType>(
                title: Text(context.t.urge.factors.emotion),
                value: flow.emotionType,
                values: EmotionType.values,
                format: emotionLabel,
                onSelected: controller.setEmotion,
              ),
            ],
          ),
          if (flow.errorMessage != null) ...[
            const SizedBox(height: AppSpacing.big),
            Text(flow.errorMessage!),
          ],
          const SizedBox(height: AppSpacing.section),
          AppActionButtons(
            primarySize: .lg,
            secondaryButtonKey: const Key('urge_back_home_button'),
            onPrimaryPress: flow.isSaving
                ? null
                : () async {
                    bool started = await controller.startSession();
                    if (started && context.mounted) {
                      context.go(AppRoutes.urgeOptions);
                    }
                  },
            primaryLabel: Text(
              flow.isSaving ? context.t.app.saving : context.t.app.continueLabel,
            ),
            onSecondaryPress: () {
              controller.reset();
              popOrGo(context, AppRoutes.home);
            },
            secondaryLabel: Text(context.t.app.backHome),
          ),
        ],
      ),
    );
  }
}
