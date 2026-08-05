import 'package:flutter/services.dart';
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
import 'package:stopcorn/app/widgets/app_sheet.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/app/widgets/score_selector.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/check_in/application/daily_check_in_controller.dart';
import 'package:stopcorn/features/check_in/domain/daily_check_in_state.dart';
import 'package:stopcorn/features/consumption/presentation/log_consumption_screen.dart';
import 'package:stopcorn/features/harvest/presentation/harvest_reward_dialog.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays the editable daily self-assessment.
final class DailyCheckInScreen extends ConsumerWidget {
  /// Local date being edited, or `null` for today's check-in.
  final String? requestedDate;

  /// Creates the daily check-in screen.
  const DailyCheckInScreen({
    super.key,
    this.requestedDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DailyCheckInControllerProvider provider = dailyCheckInControllerProvider(
      requestedDate,
    );
    AsyncValue<DailyCheckInState> state = ref.watch(provider);
    return AppPage(
      title: Text(context.t.checkIn.title),
      showBackButton: true,
      backFallbackLocation: AppRoutes.home,
      child: state.when(
        loading: () => const AsyncStatePanel(child: LoadingState()),
        error: (error, _) => AsyncStatePanel(
          child: ErrorState(
            message: context.t.checkIn.error.load,
            error: error,
            onRetry: () => ref.invalidate(provider),
          ),
        ),
        data: (value) => value.isSaved
            ? const _CheckInSaved()
            : _CheckInForm(
                state: value,
                controller: ref.read(provider.notifier),
                onSave: () => runWithHarvestReward(
                  context,
                  ref,
                  ref.read(provider.notifier).save,
                ),
              ),
      ),
    );
  }
}

/// Editable controls for today's daily check-in.
final class _CheckInForm extends StatelessWidget {
  /// Current draft and saving state.
  final DailyCheckInState state;

  /// Controller receiving form mutations.
  final DailyCheckInController controller;

  /// Saves the check-in and presents any newly earned harvest reward.
  final Future<bool> Function() onSave;

  /// Creates the editable form for [state].
  const _CheckInForm({
    required this.state,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .stretch,
    children: [
      AppSubtitle(
        text: state.wasExisting ? context.t.checkIn.intro.edit : context.t.checkIn.intro.create,
      ),
      const SizedBox(height: AppSpacing.section),
      ScoreSelector(
        label: context.t.checkIn.mood.label,
        value: state.moodScore,
        onChanged: controller.setMoodScore,
        description: context.t.checkIn.mood.scale,
      ),
      const SizedBox(height: AppSpacing.big),
      ScoreSelector(
        label: context.t.checkIn.control.label,
        value: state.controlScore,
        onChanged: controller.setControlScore,
        description: context.t.checkIn.control.scale,
      ),
      const SizedBox(height: AppSpacing.big),
      FTextField(
        control: FTextFieldControl.managed(
          initial: TextEditingValue(text: state.urgeCountInput),
          onChange: (value) => controller.setUrgeCountInput(value.text),
        ),
        label: Text(context.t.checkIn.urge.count),
        hint: context.t.checkIn.urge.hint,
        keyboardType: .number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
      ),
      const SizedBox(height: AppSpacing.big),
      AppCard(
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Text(
              state.recordedConsumptionCount == 0
                  ? context.t.checkIn.consumption.none
                  : context.t.checkIn.consumption.recorded(
                      count: state.recordedConsumptionCount,
                    ),
              key: const Key('check_in_consumption_count'),
            ),
            const SizedBox(height: AppSpacing.big),
            AppButton(
              key: const Key('check_in_log_consumption'),
              onPress: () async {
                bool? saved = await showAppSheet<bool>(
                  context: context,
                  builder: (sheetContext) => LogConsumptionScreen.sheet(
                    initialLocalDate: state.localDate,
                  ),
                );
                if (saved == true) {
                  await controller.refreshRecordedConsumptionCount();
                }
              },
              child: Text(context.t.consumption.title),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.big),
      ScoreSelector(
        key: const Key('check_in_sleep_score'),
        label: context.t.checkIn.sleep.label,
        value: state.sleepQuality,
        onChanged: controller.setSleepQuality,
        onCleared: () => controller.setSleepQuality(null),
        description: context.t.checkIn.sleep.scale,
      ),
      const SizedBox(height: AppSpacing.big),
      FTextField(
        control: FTextFieldControl.managed(
          initial: TextEditingValue(text: state.note),
          onChange: (value) => controller.setNote(value.text),
        ),
        label: Text(context.t.checkIn.note.label),
        hint: context.t.checkIn.note.hint,
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
        primaryButtonKey: const Key('save_check_in_button'),
        secondaryButtonKey: const Key('check_in_cancel_button'),
        onPrimaryPress: state.isSaving ? null : onSave,
        primaryLabel: Text(
          state.isSaving ? context.t.app.saving : context.t.app.save,
        ),
        onSecondaryPress: state.isSaving ? null : () => popOrGo(context, AppRoutes.home),
        secondaryLabel: Text(context.t.app.cancel),
      ),
    ],
  );
}

/// Supportive confirmation shown after a successful check-in save.
final class _CheckInSaved extends StatelessWidget {
  /// Creates the successful check-in confirmation.
  const _CheckInSaved();

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        const SizedBox(height: AppSpacing.section),
        const Icon(
          FLucideIcons.circleCheck,
          size: AppIconSize.display,
        ),
        const SizedBox(height: AppSpacing.big),
        Text(
          context.t.checkIn.saved.title,
          textAlign: .center,
          style: context.theme.typography.display.xl.copyWith(
            fontWeight: .w700,
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        Text(
          context.t.checkIn.saved.body,
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
