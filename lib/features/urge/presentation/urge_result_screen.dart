import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_action_buttons.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_page.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/app_selection_checkbox.dart';
import 'package:stopcorn/app/widgets/score_selector.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/utils/app_number.dart';
import 'package:stopcorn/features/harvest/presentation/harvest_reward_dialog.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/features/urge/application/urge_flow_controller.dart';
import 'package:stopcorn/features/urge/domain/urge_flow_state.dart';
import 'package:stopcorn/features/urge/presentation/urge_flow_navigation.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Captures the final intensity, outcome, and optional notes.
final class UrgeResultScreen extends ConsumerWidget {
  /// Creates the urge reassessment screen.
  const UrgeResultScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UrgeFlowState flow = ref.watch(urgeFlowControllerProvider);
    if (flow.step == .completed) {
      return _CompletedUrge(flow: flow);
    }
    UrgeFlowController controller = ref.read(
      urgeFlowControllerProvider.notifier,
    );
    return UrgeGuard(
      child: AppPage(
        title: Text(context.t.urge.result.pageTitle),
        showBackButton: true,
        onBackButtonPressed: () => quitUrgeFlow(context, ref),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            AppSectionHeader(
              title: Text.rich(context.t.urge.result.title),
              subtitle: Text(context.t.urge.result.subtitle),
            ),
            ScoreSelector(
              label: context.t.urge.intensity.label,
              value: flow.finalIntensity,
              onChanged: controller.setFinalIntensity,
            ),
            const SizedBox(height: AppSpacing.section),
            AppSectionHeader(
              title: Text(context.t.urge.result.outcome.title),
              subtitle: Text(context.t.urge.result.outcome.subtitle),
            ),
            FTileGroup(
              label: Text(context.t.urge.result.outcome.label),
              children: [
                for (final UrgeOutcome outcome in UrgeOutcome.values.where(
                  (outcome) => outcome != .abandoned,
                ))
                  FTile(
                    title: Text(urgeOutcomeLabel(outcome)),
                    selected: flow.outcome == outcome,
                    suffix: AppSelectionCheckbox(
                      value: flow.outcome == outcome,
                      circular: true,
                    ),
                    onPress: () => controller.setOutcome(outcome),
                  ),
              ],
            ),
            if (flow.strategyUseId != null) ...[
              const SizedBox(height: AppSpacing.section),
              _EffectSelector(
                value: flow.strategyEffect,
                onChanged: controller.setStrategyEffect,
              ),
            ],
            const SizedBox(height: AppSpacing.section),
            FTextField(
              control: FTextFieldControl.managed(
                initial: TextEditingValue(text: flow.notes),
                onChange: (value) => controller.setNotes(value.text),
              ),
              label: Text(context.t.urge.result.note),
              hint: context.t.urge.result.noteHint,
              minLines: 2,
              maxLines: 4,
              maxLength: AppConstants.noteMaxLength,
              textCapitalization: .sentences,
            ),
            if (flow.errorMessage != null) ...[
              const SizedBox(height: AppSpacing.big),
              Text(flow.errorMessage!),
            ],
            const SizedBox(height: AppSpacing.section),
            AppActionButtons(
              onPrimaryPress: flow.outcome == null || flow.isSaving
                  ? null
                  : () => runWithHarvestReward(
                      context,
                      ref,
                      controller.completeSession,
                    ),
              primaryLabel: Text(
                flow.isSaving ? context.t.app.saving : context.t.urge.result.finish,
              ),
              onSecondaryPress: () => quitUrgeFlow(context, ref),
              secondaryLabel: Text(context.t.urge.quit),
            ),
          ],
        ),
      ),
    );
  }
}

/// Displays the non-judgmental completion state of an urge flow.
final class _CompletedUrge extends ConsumerWidget {
  /// Completed urge flow.
  final UrgeFlowState flow;

  /// Creates the completion view for [flow].
  const _CompletedUrge({
    required this.flow,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool consumed = flow.outcome == .consumed;
    return AppPage(
      title: Text(context.t.urge.complete.title),
      showBackButton: true,
      onBackButtonPressed: () => quitUrgeFlow(context, ref, abandon: false),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          const SizedBox(height: AppSpacing.section),
          Icon(
            consumed ? FLucideIcons.sprout : FLucideIcons.circleCheck,
            size: AppIconSize.display,
            color: context.theme.colors.primary,
          ),
          const SizedBox(height: AppSpacing.big),
          Text(
            consumed ? context.t.urge.complete.consumedHeadline : context.t.urge.complete.otherHeadline,
            textAlign: .center,
            style: context.theme.typography.display.xl.copyWith(
              fontWeight: .w700,
            ),
          ),
          const SizedBox(height: AppSpacing.medium),
          Text(
            consumed ? context.t.urge.complete.consumedBody : context.t.urge.complete.otherBody,
            textAlign: .center,
          ),
          const SizedBox(height: AppSpacing.section),
          if (consumed) ...[
            AppButton(
              onPress: () {
                String? sessionId = flow.sessionId;
                ref.read(urgeFlowControllerProvider.notifier).reset();
                context.go(AppRoutes.logConsumptionFor(sessionId));
              },
              child: Text(context.t.urge.complete.log),
            ),
            const SizedBox(height: AppSpacing.medium),
          ],
          AppButton(
            variant: consumed ? .outline : .primary,
            onPress: () => quitUrgeFlow(context, ref, abandon: false),
            child: Text(context.t.app.backHome),
          ),
        ],
      ),
    );
  }
}

/// Lets the user rate how a coping strategy affected the urge.
final class _EffectSelector extends StatelessWidget {
  /// Selected effect from −5 to +5.
  final int value;

  /// Called with a new effect value.
  final ValueChanged<int> onChanged;

  /// Creates a strategy effect selector for [value].
  const _EffectSelector({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(context.t.urge.strategy.effect)),
            FBadge(child: Text(formatSignedCount(value))),
          ],
        ),
        const SizedBox(height: AppSpacing.big),
        FSlider(
          control: FSliderControl.liftedDiscrete(
            value: FSliderValue(max: (value + 5) / 10),
            onChange: (sliderValue) => onChanged((sliderValue.max * 10).round() - 5),
          ),
          marks: [
            for (int index = 0; index <= 10; index++)
              FSliderMark(
                value: index / 10,
                label: index == 0 || index == 5 || index == 10 ? Text(formatCount(index - 5)) : null,
              ),
          ],
        ),
      ],
    ),
  );
}
