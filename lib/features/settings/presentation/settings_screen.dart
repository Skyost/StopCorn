import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_checkbox_tile.dart';
import 'package:stopcorn/app/widgets/app_page_viewport.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/app_selection_checkbox.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/features/harvest/presentation/harvest_reward_dialog.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/features/progress/domain/progress_period.dart';
import 'package:stopcorn/features/project_support/presentation/project_support_card.dart';
import 'package:stopcorn/features/settings/application/settings_controller.dart';
import 'package:stopcorn/features/settings/domain/settings_view_state.dart';
import 'package:stopcorn/features/settings/presentation/delete_all_data_flow.dart';
import 'package:stopcorn/features/settings/presentation/goal_editor_sheet.dart';
import 'package:stopcorn/features/settings/presentation/settings_information_dialogs.dart';
import 'package:stopcorn/features/settings/presentation/strategy_editor_sheet.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays all local preferences, plan editors, and data controls.
final class SettingsScreen extends ConsumerWidget {
  /// Creates the settings screen.
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<SettingsViewState> state = ref.watch(
      settingsControllerProvider,
    );
    return state.when(
      loading: () => const AppPageList(
        children: [AsyncStatePanel(child: LoadingState())],
      ),
      error: (error, _) => AppPageList(
        children: [
          AsyncStatePanel(
            child: ErrorState(
              message: context.t.settings.error.load,
              error: error,
              onRetry: () => ref.invalidate(settingsControllerProvider),
            ),
          ),
        ],
      ),
      data: (value) => _SettingsContent(state: value),
    );
  }
}

/// Renders the editable settings sections for the current [state].
final class _SettingsContent extends ConsumerWidget {
  /// Current settings snapshot.
  final SettingsViewState state;

  /// Creates settings content from [state].
  const _SettingsContent({
    required this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsController controller = ref.read(
      settingsControllerProvider.notifier,
    );
    return AppPageList(
      children: [
        ProjectSupportCard(
          debugShowThanks: kDebugMode && state.debugShowSupportThanks,
        ),
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          icon: FLucideIcons.languages,
          title: Text(context.t.locale.section.title),
          subtitle: Text(context.t.locale.section.description),
        ),
        FTileGroup(
          children: [
            FSelectMenuTile(
              key: const Key('locale_select_tile'),
              title: Text(context.t.locale.label),
              details: Text(_localeLabel(state.locale)),
              enabled: !state.isSaving,
              selectControl: .managedRadio(
                initial: state.locale,
                onChange: (values) async {
                  AppLocale? locale = values.firstOrNull;
                  if (locale != null && locale != state.locale) {
                    await controller.setLocale(locale);
                  }
                },
              ),
              menu: [
                for (AppLocale locale in AppLocale.values)
                  FSelectTile(
                    key: Key('locale_${locale.languageCode}'),
                    title: Text(_localeLabel(locale)),
                    value: locale,
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          icon: FLucideIcons.palette,
          title: Text(context.t.settings.appearance.title),
          subtitle: Text(context.t.settings.appearance.description),
        ),
        FTileGroup(
          children: [
            for (final AppThemeMode mode in AppThemeMode.values)
              FTile(
                key: Key('theme_${mode.name}'),
                title: Text(switch (mode) {
                  .system => t.theme.system,
                  .light => t.theme.light,
                  .dark => t.theme.dark,
                }),
                selected: state.themeMode == mode,
                suffix: AppSelectionCheckbox(
                  value: state.themeMode == mode,
                  enabled: !state.isSaving,
                  circular: true,
                ),
                onPress: state.isSaving ? null : () => controller.setThemeMode(mode),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          icon: FLucideIcons.bellRing,
          title: Text(context.t.settings.reminders.title),
          subtitle: Text(context.t.settings.reminders.description),
        ),
        FTileGroup(
          children: [
            AppCheckboxTile(
              controlKey: const Key('daily_check_in_reminder_switch'),
              title: Text(context.t.settings.reminders.daily.label),
              description: Text(
                state.dailyCheckInReminderSupported ? context.t.settings.reminders.daily.description : context.t.settings.reminders.daily.unavailable,
              ),
              value: state.dailyCheckInReminderEnabled,
              onChange: state.isSaving || (!state.dailyCheckInReminderSupported && !state.dailyCheckInReminderEnabled)
                  ? null
                  : (value) async {
                      await controller.setDailyCheckInReminderEnabled(value);
                    },
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          icon: FLucideIcons.chartNoAxesCombined,
          title: Text(context.t.settings.progress.title),
          subtitle: Text(context.t.settings.progress.description),
        ),
        FTileGroup(
          children: [
            AppCheckboxTile(
              controlKey: const Key('show_harvest_switch'),
              title: Text(context.t.settings.progress.harvest.label),
              description: Text(context.t.settings.progress.harvest.description),
              value: state.showHarvest,
              onChange: state.isSaving
                  ? null
                  : (value) async {
                      await controller.setShowHarvest(value);
                    },
            ),
            FSelectMenuTile<ProgressPeriod>(
              key: const Key('default_period_select_tile'),
              title: Text(context.t.settings.progress.defaultPeriod),
              details: Text(state.defaultProgressPeriod.label),
              enabled: !state.isSaving,
              selectControl: FMultiValueControl<ProgressPeriod>.managedRadio(
                initial: state.defaultProgressPeriod,
                onChange: (values) async {
                  ProgressPeriod? period = values.firstOrNull;
                  if (period != null && period != state.defaultProgressPeriod) {
                    await controller.setDefaultProgressPeriod(period);
                  }
                },
              ),
              menu: [
                for (ProgressPeriod period in ProgressPeriod.values)
                  FSelectTile<ProgressPeriod>(
                    key: Key('period_${period.storageKey}'),
                    title: Text(period.label),
                    value: period,
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          icon: FLucideIcons.target,
          title: Text(context.t.settings.personalPlan.title),
          subtitle: Text(context.t.settings.personalPlan.description),
        ),
        FTileGroup(
          children: [
            FTile(
              key: const Key('edit_goal_button'),
              title: Text(context.t.settings.personalPlan.goal.label),
              subtitle: AppTileSubtitle(
                child: Text(
                  state.activeGoal == null ? context.t.settings.personalPlan.goal.none : goalTitle(goalTypeOf(state.activeGoal!)),
                ),
              ),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: state.isSaving ? null : () => showGoalEditorSheet(context, activeGoal: state.activeGoal),
            ),
            FTile(
              key: const Key('open_goal_history_button'),
              title: Text(context.t.settings.personalPlan.history.title),
              subtitle: AppTileSubtitle(
                child: Text(context.t.settings.personalPlan.history.subtitle),
              ),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => context.push(AppRoutes.goalHistory),
            ),
            FTile(
              title: Text(context.t.settings.personalPlan.backup.title),
              subtitle: AppTileSubtitle(
                child: Text(
                  context.t.settings.personalPlan.backup.summary(
                    count: state.selectedStrategyIds.length,
                  ),
                ),
              ),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: state.isSaving ? null : () => showStrategyEditorSheet(context, selectedStrategyIds: state.selectedStrategyIds),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          icon: FLucideIcons.database,
          title: Text(context.t.settings.data.title),
          subtitle: Text(context.t.settings.data.description),
        ),
        FTileGroup(
          children: [
            AppCheckboxTile(
              controlKey: const Key('error_reporting_switch'),
              title: Text(context.t.settings.data.errorReporting.label),
              description: Text(context.t.settings.data.errorReporting.description),
              value: state.errorReportingEnabled,
              onChange: state.isSaving
                  ? null
                  : (value) async {
                      await controller.setErrorReportingEnabled(value);
                    },
            ),
            FTile(
              title: Text(context.t.settings.data.export.title),
              subtitle: AppTileSubtitle(
                child: Text(context.t.settings.data.export.description),
              ),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => context.push(AppRoutes.dataExport),
            ),
            FTile(
              title: Text(context.t.settings.data.stored.title),
              subtitle: AppTileSubtitle(
                child: Text(context.t.settings.data.stored.description),
              ),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => showStorageInformation(context),
            ),
            FTile(
              key: const Key('delete_all_data_tile'),
              variant: .destructive,
              title: Text(context.t.settings.data.delete.action),
              subtitle: AppTileSubtitle(
                child: Text(context.t.settings.data.delete.description),
              ),
              suffix: const Icon(FLucideIcons.trash2),
              onPress: state.isDeleting ? null : () => deleteAllData(context, ref),
            ),
          ],
        ),
        if (kDebugMode) ...[
          const SizedBox(height: AppSpacing.section),
          AppSectionHeader(
            icon: FLucideIcons.bug,
            title: Text(context.t.settings.developer.title),
            subtitle: Text(context.t.settings.developer.description),
          ),
          FTileGroup(
            children: [
              FTile(
                key: const Key('load_sample_data_tile'),
                title: Text(
                  state.isLoadingSampleData ? context.t.settings.developer.sample.progress : context.t.settings.developer.sample.action,
                ),
                subtitle: AppTileSubtitle(
                  child: Text(
                    state.sampleDataLoaded ? context.t.settings.developer.sample.loaded : context.t.settings.developer.sample.description,
                  ),
                ),
                suffix: state.sampleDataLoaded ? const Icon(FLucideIcons.check) : null,
                onPress: state.isSaving ? null : controller.loadSampleData,
              ),
              FTile(
                key: const Key('grant_debug_corn_point_tile'),
                title: Text(
                  context.t.settings.developer.cornPoint.action,
                ),
                subtitle: AppTileSubtitle(
                  child: Text(
                    context.t.settings.developer.cornPoint.description,
                  ),
                ),
                onPress: state.isSaving
                    ? null
                    : () => runWithDebugHarvestReward(
                        context,
                        ref,
                        controller.grantDebugCornPoint,
                      ),
              ),
              AppCheckboxTile(
                controlKey: const Key('debug_show_support_thanks_switch'),
                title: Text(context.t.settings.developer.supportThanks.label),
                description: Text(context.t.settings.developer.supportThanks.description),
                value: state.debugShowSupportThanks,
                onChange: state.isSaving
                    ? null
                    : (value) async {
                        await controller.setDebugShowSupportThanks(value);
                      },
              ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          icon: FLucideIcons.info,
          title: Text(context.t.settings.about.title),
          subtitle: Text(context.t.settings.about.description),
        ),
        FTileGroup(
          children: [
            FTile(
              title: Text(context.t.app.name),
              subtitle: const AppTileSubtitle(
                child: AppVersionSubtitle(),
              ),
              onPress: () => showAbout(context),
            ),
            FTile(
              title: Text(context.t.settings.about.privacy.title),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => showPrivacy(context, ref),
            ),
            FTile(
              title: Text(context.t.settings.about.licenses),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => context.push(AppRoutes.licenses),
            ),
            FTile(
              title: Text(context.t.settings.about.professionalHelp),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => showProfessionalHelp(context),
            ),
          ],
        ),
        if (state.errorMessage != null) ...[
          const SizedBox(height: AppSpacing.big),
          AppCard(
            child: Row(
              crossAxisAlignment: .start,
              children: [
                Icon(
                  FLucideIcons.circleAlert,
                  color: context.theme.colors.error,
                ),
                const SizedBox(width: AppSpacing.medium),
                Expanded(
                  child: Text(
                    state.errorMessage!,
                    style: TextStyle(color: context.theme.colors.error),
                  ),
                ),
              ],
            ),
          ),
        ],
        if (state.isDeleting) ...[
          const SizedBox(height: AppSpacing.big),
          const Center(child: FCircularProgress()),
          const SizedBox(height: AppSpacing.medium),
          Text(context.t.settings.data.delete.progress, textAlign: .center),
        ],
      ],
    );
  }

  /// Returns the localized display name for [locale].
  String _localeLabel(AppLocale locale) => switch (locale) {
    .en => t.locale.english,
    .fr => t.locale.french,
  };
}
