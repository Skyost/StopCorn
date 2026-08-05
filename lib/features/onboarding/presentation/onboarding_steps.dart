import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_selection_checkbox.dart';
import 'package:stopcorn/app/widgets/app_sheet.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/app_switch_card.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/app/widgets/corn_brand_mark.dart';
import 'package:stopcorn/app/widgets/score_selector.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/onboarding/application/onboarding_controller.dart';
import 'package:stopcorn/features/onboarding/domain/onboarding_draft.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays the welcome step and its privacy overview.
final class OnboardingWelcomeStep extends StatelessWidget {
  /// Creates the welcome step.
  const OnboardingWelcomeStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .stretch,
    children: [
      const Center(
        child: CornBrandMark(
          size: AppIconSize.brand,
        ),
      ),
      const SizedBox(height: AppSpacing.big),
      Text(
        context.t.onboarding.welcome.title,
        textAlign: .center,
        style: context.theme.typography.display.xl.copyWith(
          fontWeight: .w700,
        ),
      ),
      const SizedBox(height: AppSpacing.big),
      Text(
        context.t.onboarding.welcome.subtitle,
        textAlign: .center,
      ),
      const SizedBox(height: AppSpacing.section),
      AppCard(
        child: Column(
          children: [
            _privacyPoint(
              FLucideIcons.userRoundX,
              context.t.onboarding.welcome.noAccount,
            ),
            _privacyPoint(
              FLucideIcons.smartphone,
              context.t.onboarding.welcome.localData,
            ),
            _privacyPoint(
              FLucideIcons.badgeEuro,
              context.t.onboarding.welcome.noAds,
            ),
            _privacyPoint(
              FLucideIcons.heartHandshake,
              context.t.onboarding.welcome.selfHelp,
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.big),
      AppButton(
        variant: .ghost,
        onPress: () => _showPrivacySheet(context),
        child: Text(context.t.onboarding.welcome.privacyAction),
      ),
    ],
  );
}

/// Displays goal selection and the fields each direction requires.
final class OnboardingGoalStep extends StatelessWidget {
  /// Controller owning the draft edited by this step.
  final OnboardingController controller;

  /// Draft answers displayed by this step.
  final OnboardingDraft draft;

  /// Creates the goal step.
  const OnboardingGoalStep({
    super.key,
    required this.controller,
    required this.draft,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .stretch,
    children: [
      OnboardingStepHeading(
        title: t.onboarding.goal.title,
        subtitle: t.onboarding.goal.subtitle,
      ),
      const SizedBox(height: AppSpacing.big),
      FTileGroup(
        semanticsLabel: t.onboarding.goal.semantics,
        children: [
          for (final GoalType type in GoalType.values)
            FTile(
              title: Text(goalTitle(type)),
              subtitle: AppTileSubtitle(
                child: Text(goalDescription(type)),
              ),
              selected: draft.goalType == type,
              suffix: AppSelectionCheckbox(
                value: draft.goalType == type,
                circular: true,
              ),
              onPress: () => controller.selectGoal(type),
            ),
        ],
      ),
      if (draft.goalType == .reduction) ...[
        const SizedBox(height: AppSpacing.big),
        FTextField(
          control: FTextFieldControl.managed(
            initial: TextEditingValue(
              text: draft.weeklyLimit?.toString() ?? '',
            ),
            onChange: (value) => controller.setWeeklyLimit(int.tryParse(value.text)),
          ),
          label: Text(t.onboarding.goal.weeklyLimit),
          hint: t.onboarding.goal.weeklyHint,
          keyboardType: .number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
        ),
      ],
      if (draft.goalType == .contextual) ...[
        const SizedBox(height: AppSpacing.big),
        FTileGroup(
          label: Text(t.onboarding.goal.contexts),
          children: [
            for (final MapEntry<String, String> option in contextualOptions.entries)
              FTile(
                title: Text(option.value),
                selected: draft.contextKeys.contains(option.key),
                suffix: AppSelectionCheckbox(
                  value: draft.contextKeys.contains(option.key),
                ),
                onPress: () => controller.toggleContext(option.key),
              ),
          ],
        ),
      ],
      const SizedBox(height: AppSpacing.big),
      FTextField(
        control: FTextFieldControl.managed(
          initial: TextEditingValue(text: draft.motivation),
          onChange: (value) => controller.setMotivation(value.text),
        ),
        label: Text(t.onboarding.goal.motivation),
        hint: t.onboarding.goal.motivationHint,
        minLines: 2,
        maxLines: 3,
        maxLength: AppConstants.motivationMaxLength,
        textCapitalization: .sentences,
      ),
    ],
  );
}

/// Displays the non-medical baseline self-observation fields.
final class OnboardingBaselineStep extends StatelessWidget {
  /// Controller owning the draft edited by this step.
  final OnboardingController controller;

  /// Draft answers displayed by this step.
  final OnboardingDraft draft;

  /// Creates the baseline step.
  const OnboardingBaselineStep({
    super.key,
    required this.controller,
    required this.draft,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .stretch,
    children: [
      OnboardingStepHeading(
        title: t.onboarding.baseline.title,
        subtitle: t.onboarding.baseline.subtitle,
      ),
      const SizedBox(height: AppSpacing.section),
      FTextField(
        key: const Key('baseline_frequency_field'),
        control: FTextFieldControl.managed(
          initial: TextEditingValue(text: '${draft.baselineFrequency}'),
          onChange: (value) => controller.setBaselineFrequency(int.tryParse(value.text) ?? 0),
        ),
        label: Text(t.onboarding.baseline.frequency),
        keyboardType: .number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
        ],
      ),
      const SizedBox(height: AppSpacing.big),
      ScoreSelector(
        label: t.onboarding.baseline.control,
        value: draft.perceivedControl,
        onChanged: controller.setPerceivedControl,
      ),
      const SizedBox(height: AppSpacing.big),
      ScoreSelector(
        label: t.onboarding.baseline.impact,
        value: draft.negativeImpact,
        onChanged: controller.setNegativeImpact,
      ),
      const SizedBox(height: AppSpacing.big),
      ScoreSelector(
        label: t.onboarding.baseline.confidence,
        value: draft.confidenceToChange,
        onChanged: controller.setConfidenceToChange,
      ),
    ],
  );
}

/// Displays the initial coping-strategy backup plan.
final class OnboardingStrategiesStep extends StatelessWidget {
  /// Controller owning the draft edited by this step.
  final OnboardingController controller;

  /// Draft answers displayed by this step.
  final OnboardingDraft draft;

  /// Creates the strategy step.
  const OnboardingStrategiesStep({
    super.key,
    required this.controller,
    required this.draft,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .stretch,
    children: [
      OnboardingStepHeading(
        title: t.onboarding.strategies.title,
        subtitle: t.onboarding.strategies.subtitle,
      ),
      const SizedBox(height: AppSpacing.big),
      Text(
        t.onboarding.strategies.selected(count: draft.strategyIds.length),
      ),
      const SizedBox(height: AppSpacing.big),
      FTileGroup(
        semanticsLabel: t.onboarding.strategies.semantics,
        children: [
          for (final BuiltInStrategyDefinition strategy in builtInStrategies)
            FTile(
              title: Text(strategyTitle(strategy.id)),
              subtitle: AppTileSubtitle(
                child: Text(strategyDescription(strategy.id)),
              ),
              selected: draft.strategyIds.contains(strategy.id),
              suffix: AppSelectionCheckbox(
                value: draft.strategyIds.contains(strategy.id),
              ),
              onPress: () => controller.toggleStrategy(strategy.id),
            ),
        ],
      ),
    ],
  );
}

/// Displays final local-data promises and the optional reminder.
final class OnboardingPrivacyStep extends StatelessWidget {
  /// Controller owning the draft edited by this step.
  final OnboardingController controller;

  /// Draft answers displayed by this step.
  final OnboardingDraft draft;

  /// Whether the platform can schedule the local daily reminder.
  final bool reminderSupported;

  /// Creates the closing privacy step.
  const OnboardingPrivacyStep({
    super.key,
    required this.controller,
    required this.draft,
    required this.reminderSupported,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .stretch,
    children: [
      OnboardingStepHeading(
        title: t.onboarding.privacy.title,
        subtitle: t.onboarding.privacy.subtitle,
      ),
      const SizedBox(height: AppSpacing.big),
      AppCard(
        child: Column(
          children: [
            _privacyPoint(
              FLucideIcons.smartphone,
              t.onboarding.privacy.local,
            ),
            _privacyPoint(
              FLucideIcons.eyeOff,
              t.onboarding.privacy.noHistory,
            ),
            _privacyPoint(
              FLucideIcons.shieldCheck,
              t.onboarding.privacy.control,
            ),
            _privacyPoint(
              FLucideIcons.cloudCog,
              t.onboarding.privacy.backup,
            ),
            _privacyPoint(
              FLucideIcons.bug,
              t.onboarding.privacy.crashReports,
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.section),
      AppSwitchCard(
        controlKey: const Key('onboarding_daily_check_in_reminder_switch'),
        value: draft.dailyCheckInReminderEnabled,
        onChange: reminderSupported || draft.dailyCheckInReminderEnabled ? controller.setDailyCheckInReminderEnabled : null,
        label: Text(t.onboarding.privacy.dailyCheckInReminder),
        description: Text(
          reminderSupported ? t.onboarding.privacy.dailyCheckInReminderDescription : t.onboarding.privacy.reminderUnavailable,
        ),
      ),
    ],
  );
}

/// Shared title and subtitle used by onboarding steps.
final class OnboardingStepHeading extends StatelessWidget {
  /// Main step heading.
  final String title;

  /// Supporting explanation.
  final String subtitle;

  /// Creates a heading for one onboarding step.
  const OnboardingStepHeading({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    children: [
      Text(
        title,
        style: context.theme.typography.display.xl.copyWith(
          fontWeight: .w700,
        ),
      ),
      const SizedBox(height: AppSpacing.small),
      AppSubtitle(text: subtitle),
    ],
  );
}

/// Builds one concise privacy promise.
Widget _privacyPoint(IconData icon, String text) => Padding(
  padding: const .symmetric(vertical: AppSpacing.medium),
  child: Row(
    children: [
      Icon(icon),
      const SizedBox(width: AppSpacing.medium),
      Expanded(child: Text(text)),
    ],
  ),
);

/// Opens the extended first-step privacy explanation.
Future<void> _showPrivacySheet(BuildContext context) => showAppSheet<void>(
  context: context,
  builder: (sheetContext) => Column(
    mainAxisSize: .min,
    crossAxisAlignment: .stretch,
    children: [
      Text(
        sheetContext.t.onboarding.welcome.privacyTitle,
        style: sheetContext.theme.typography.display.lg.copyWith(
          fontWeight: .w700,
        ),
      ),
      const SizedBox(height: AppSpacing.big),
      Text(sheetContext.t.onboarding.welcome.privacyBody),
      const SizedBox(height: AppSpacing.section),
      AppButton(
        onPress: () => Navigator.of(sheetContext).pop(),
        child: Text(sheetContext.t.app.close),
      ),
    ],
  ),
);
