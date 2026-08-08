import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_navigation.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_action_buttons.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_page.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/app_selection_checkbox.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/app/widgets/optional_choice_tile.dart';
import 'package:stopcorn/app/widgets/score_selector.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/consumption/application/log_consumption_controller.dart';
import 'package:stopcorn/features/consumption/domain/log_consumption_state.dart';
import 'package:stopcorn/features/harvest/presentation/harvest_reward_dialog.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays the voluntary, non-explicit consumption log.
final class LogConsumptionScreen extends ConsumerWidget {
  /// Urge session linked to this event, if any.
  final String? urgeSessionId;

  /// Existing event corrected by this form, if any.
  final String? eventId;

  /// Local date preselected for a new event, if any.
  final String? initialLocalDate;

  /// Whether the form is hosted by a modal sheet instead of a routed page.
  final bool _inSheet;

  /// Creates a form optionally associated with an urge [urgeSessionId].
  const LogConsumptionScreen({
    super.key,
    this.urgeSessionId,
    this.eventId,
    this.initialLocalDate,
  }) : _inSheet = false;

  /// Creates a consumption form embedded in an application sheet.
  const LogConsumptionScreen.sheet({
    super.key,
    this.urgeSessionId,
    this.eventId,
    this.initialLocalDate,
  }) : _inSheet = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LogConsumptionControllerProvider provider = logConsumptionControllerProvider(
      urgeSessionId,
      eventId,
      initialLocalDate,
    );
    AsyncValue<LogConsumptionState> state = ref.watch(provider);
    String title = eventId == null ? context.t.consumption.title : context.t.consumption.edit.title;
    Widget content = state.when(
      loading: () => const AsyncStatePanel(child: LoadingState()),
      error: (error, _) => AsyncStatePanel(
        child: ErrorState(
          message: context.t.consumption.error.load,
          error: error,
          onRetry: () => ref.invalidate(provider),
        ),
      ),
      data: (value) => value.isSaved
          ? const _ConsumptionSaved()
          : _ConsumptionForm(
              state: value,
              controller: ref.read(provider.notifier),
              onSave: () async {
                bool saved = await runWithHarvestReward(
                  context,
                  ref,
                  ref.read(provider.notifier).save,
                );
                if (saved && _inSheet && context.mounted) {
                  Navigator.of(context).pop(true);
                }
                return saved;
              },
              onCancel: () {
                if (_inSheet) {
                  Navigator.of(context).pop(false);
                } else {
                  popOrGo(context, AppRoutes.home);
                }
              },
            ),
    );

    if (_inSheet) {
      return Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          AppSectionHeader(title: Text(title)),
          const SizedBox(height: AppSpacing.big),
          content,
        ],
      );
    }
    return AppPage(
      title: Text(title),
      showBackButton: true,
      backFallbackLocation: AppRoutes.home,
      child: content,
    );
  }
}

/// Editable controls for a voluntarily recorded consumption event.
final class _ConsumptionForm extends StatelessWidget {
  /// Current form state.
  final LogConsumptionState state;

  /// Controller receiving form changes.
  final LogConsumptionController controller;

  /// Saves the event and presents any newly earned harvest reward.
  final Future<bool> Function() onSave;

  /// Closes the form without saving.
  final VoidCallback onCancel;

  /// Creates the consumption form for [state].
  const _ConsumptionForm({
    required this.state,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.utc(
      state.occurredAt.year,
      state.occurredAt.month,
      state.occurredAt.day,
    );
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        AppSubtitle(text: context.t.consumption.intro),
        const SizedBox(height: AppSpacing.section),
        FDateField.calendar(
          key: const Key('consumption_date'),
          selectionControl: FDateSelectionControl.managedSingle(
            initial: selectedDate,
            toggleable: false,
            onChange: (value) {
              if (value != null) {
                controller.setDate(value);
              }
            },
          ),
          label: Text(context.t.consumption.date),
          clearable: false,
        ),
        const SizedBox(height: AppSpacing.big),
        FTimeField.picker(
          key: const Key('consumption_time'),
          control: FTimeFieldControl.managed(
            initial: FTime.fromDateTime(state.occurredAt),
            onChange: (value) {
              if (value != null) {
                controller.setTime(hour: value.hour, minute: value.minute);
              }
            },
          ),
          hour24: true,
          label: Text(context.t.consumption.time),
        ),
        const SizedBox(height: AppSpacing.big),
        FTileGroup(
          label: Text(context.t.consumption.factors.label),
          children: [
            OptionalChoiceTile<TriggerType>(
              title: Text(context.t.consumption.factors.trigger),
              value: state.triggerType,
              values: TriggerType.values,
              format: triggerLabel,
              onSelected: controller.setTrigger,
            ),
            OptionalChoiceTile<EmotionType>(
              title: Text(context.t.consumption.factors.emotion),
              value: state.emotionType,
              values: EmotionType.values,
              format: emotionLabel,
              onSelected: controller.setEmotion,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.big),
        ScoreSelector(
          key: const Key('consumption_control_score'),
          label: context.t.consumption.control.label,
          value: state.perceivedControl,
          onChanged: controller.setPerceivedControl,
          onCleared: () => controller.setPerceivedControl(null),
          description: context.t.consumption.control.scale,
        ),
        if (state.availableContextKeys.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.big),
          AppSectionHeader(
            title: Text(context.t.consumption.contextualGoal.title),
            subtitle: Text(context.t.consumption.contextualGoal.description),
          ),
          FTileGroup(
            label: Text(context.t.consumption.contextualGoal.label),
            children: [
              for (final String key in state.availableContextKeys)
                FTile(
                  key: Key('consumption_context_$key'),
                  title: Text(contextualOptions[key] ?? key),
                  selected: state.selectedContextKeys.contains(key),
                  suffix: AppSelectionCheckbox(
                    value: state.selectedContextKeys.contains(key),
                  ),
                  onPress: () => controller.toggleContextKey(key),
                ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.big),
        FTextField(
          control: FTextFieldControl.managed(
            initial: TextEditingValue(text: state.contextLabel),
            onChange: (value) => controller.setContextLabel(value.text),
          ),
          label: Text(context.t.consumption.context.label),
          hint: context.t.consumption.context.hint,
          description: Text(context.t.consumption.context.description),
          maxLength: AppConstants.shortContextMaxLength,
          textCapitalization: .sentences,
        ),
        const SizedBox(height: AppSpacing.big),
        FTextField(
          control: FTextFieldControl.managed(
            initial: TextEditingValue(text: state.notes),
            onChange: (value) => controller.setNotes(value.text),
          ),
          label: Text(context.t.consumption.note.label),
          hint: context.t.consumption.note.hint,
          minLines: 2,
          maxLines: 4,
          maxLength: AppConstants.noteMaxLength,
          textCapitalization: .sentences,
        ),
        if (state.errorMessage != null) ...[
          const SizedBox(height: AppSpacing.big),
          AppCard(
            child: Row(
              crossAxisAlignment: .start,
              children: [
                const Icon(FLucideIcons.circleAlert),
                const SizedBox(width: AppSpacing.medium),
                Expanded(child: Text(state.errorMessage!)),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.section),
        AppActionButtons(
          secondaryButtonKey: const Key('log_consumption_cancel_button'),
          primaryButtonKey: const Key('save_consumption_button'),
          onPrimaryPress: state.isSaving ? null : onSave,
          primaryLabel: Text(
            state.isSaving ? context.t.app.saving : context.t.app.save,
          ),
          onSecondaryPress: state.isSaving ? null : onCancel,
          secondaryLabel: Text(context.t.app.cancel),
        ),
      ],
    );
  }
}

/// Non-judgmental confirmation shown after the event is saved.
final class _ConsumptionSaved extends StatelessWidget {
  /// Creates the successful event confirmation.
  const _ConsumptionSaved();

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        const SizedBox(height: AppSpacing.section),
        const Icon(
          FLucideIcons.sprout,
          size: AppIconSize.display,
        ),
        const SizedBox(height: AppSpacing.big),
        Text(
          context.t.consumption.saved.title,
          textAlign: .center,
          style: context.theme.typography.display.xl.copyWith(
            fontWeight: .w700,
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        Text(
          context.t.consumption.saved.body,
          textAlign: .center,
        ),
        const SizedBox(height: AppSpacing.section),
        AppButton(
          onPress: () => context.go(AppRoutes.home),
          child: Text(context.t.app.backHome),
        ),
      ],
    ),
  );
}
