import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/app/theme/theme_mode_controller.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/diagnostics/error_reporter.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/utils/app_locale.dart';
import 'package:stopcorn/features/check_in/application/daily_check_in_reminder_service.dart';
import 'package:stopcorn/features/data_export/data/data_export_service.dart';
import 'package:stopcorn/features/goals/data/goal_repository.dart';
import 'package:stopcorn/features/goals/domain/goal_input.dart';
import 'package:stopcorn/features/harvest/application/harvest_providers.dart';
import 'package:stopcorn/features/home/data/home_repository.dart';
import 'package:stopcorn/features/learning/application/module_controller.dart';
import 'package:stopcorn/features/onboarding/application/onboarding_controller.dart';
import 'package:stopcorn/features/progress/application/progress_dashboard_provider.dart';
import 'package:stopcorn/features/progress/domain/progress_period.dart';
import 'package:stopcorn/features/settings/data/debug_data_seeder.dart';
import 'package:stopcorn/features/settings/domain/settings_view_state.dart';
import 'package:stopcorn/i18n/strings.g.dart';

part 'settings_controller.g.dart';

/// Coordinates persistent settings and dependent feature providers.
@riverpod
final class SettingsController extends _$SettingsController {
  @override
  Future<SettingsViewState> build() async {
    AppPreferences preferences = ref.watch(appPreferencesProvider);
    DailyCheckInReminderService reminder = ref.watch(
      dailyCheckInReminderServiceProvider,
    );
    String? storedLocale = await preferences.getLocale();
    return SettingsViewState(
      themeMode: await preferences.getThemeMode(),
      locale: AppLocaleResolver.fromLanguageCode(storedLocale) ?? LocaleSettings.currentLocale,
      dailyCheckInReminderEnabled: await preferences.getDailyCheckInReminderEnabled(),
      dailyCheckInReminderSupported: reminder.isSupported,
      showHarvest: await preferences.getShowHarvest(),
      errorReportingEnabled: await preferences.getErrorReportingEnabled(),
      debugShowSupportThanks: await preferences.getDebugShowSupportThanks(),
      defaultProgressPeriod: ProgressPeriod.fromStorage(
        await preferences.getProgressPeriod(),
      ),
      selectedStrategyIds: (await preferences.getSelectedStrategyIds()).toSet(),
      activeGoal: await ref.watch(goalRepositoryProvider).getActive(),
    );
  }

  /// Persists the selected theme [mode].
  Future<bool> setThemeMode(AppThemeMode mode) async => _mutate(
    operation: () => ref.read(themeModeControllerProvider.notifier).setThemeMode(mode),
    success: (current) => current.copyWith(themeMode: mode),
  );

  /// Persists [locale] and immediately updates the Slang locale.
  Future<bool> setLocale(AppLocale locale) async {
    bool saved = await _mutate(
      operation: () async {
        await ref.read(appPreferencesProvider).setLocale(locale.languageCode);
        await LocaleSettings.setLocale(locale);
      },
      success: (current) => current.copyWith(locale: locale),
    );
    if (saved) {
      await ref.read(dailyCheckInReminderServiceProvider).synchronize();
    }
    return saved;
  }

  /// Applies the local daily check-in reminder [value].
  Future<bool> setDailyCheckInReminderEnabled(bool value) async {
    SettingsViewState? current = state.value;
    if (current == null || current.isSaving || current.isDeleting) {
      return false;
    }
    state = AsyncData(current.copyWith(isSaving: true, errorMessage: null));
    DailyCheckInReminderResult result = await ref.read(dailyCheckInReminderServiceProvider).setEnabled(value);
    if (result.succeeded) {
      state = AsyncData(
        current.copyWith(
          dailyCheckInReminderEnabled: value,
          isSaving: false,
          errorMessage: null,
        ),
      );
      return true;
    }
    state = AsyncData(
      current.copyWith(
        isSaving: false,
        errorMessage: _reminderError(result),
      ),
    );
    return false;
  }

  /// Persists optional harvest visibility and refreshes its presentation.
  Future<bool> setShowHarvest(bool value) async {
    bool result = await _mutate(
      operation: () => ref.read(appPreferencesProvider).setShowHarvest(value),
      success: (current) => current.copyWith(showHarvest: value),
    );
    if (result) {
      ref.invalidate(harvestVisibilityProvider);
    }
    return result;
  }

  /// Applies the anonymous crash-reporting choice [value] immediately.
  ///
  /// The reporter is updated in the same operation as the preference, so
  /// turning reports off stops the next one instead of the next launch.
  Future<bool> setErrorReportingEnabled(bool value) async => _mutate(
    operation: () async {
      await ref.read(appPreferencesProvider).setErrorReportingEnabled(value);
      await ref.read(errorReporterProvider).setEnabled(value);
    },
    success: (current) => current.copyWith(errorReportingEnabled: value),
  );

  /// Persists the default [period] and refreshes progress providers.
  Future<bool> setDefaultProgressPeriod(ProgressPeriod period) async {
    bool result = await _mutate(
      operation: () => ref.read(appPreferencesProvider).setProgressPeriod(period.storageKey),
      success: (current) => current.copyWith(defaultProgressPeriod: period),
    );
    if (result) {
      ref.invalidate(progressPeriodControllerProvider);
      ref.invalidate(progressDashboardProvider);
    }
    return result;
  }

  /// Persists the selected coping-strategy identifiers.
  Future<bool> updateStrategies(Set<String> values) async => _mutate(
    operation: () => ref.read(appPreferencesProvider).setSelectedStrategyIds(values.toList()..sort()),
    success: (current) => current.copyWith(
      selectedStrategyIds: Set<String>.unmodifiable(values),
    ),
  );

  /// Validates and activates a new goal while retaining goal history.
  Future<bool> activateGoal({
    required GoalType type,
    required int? weeklyLimit,
    required List<String> contextKeys,
    required String motivation,
  }) async {
    SettingsViewState? current = state.value;
    if (current == null || current.isSaving || current.isDeleting) {
      return false;
    }
    state = AsyncData(current.copyWith(isSaving: true, errorMessage: null));
    DateTime now = ref.read(appClockProvider).now();
    GoalInput input = GoalInput(
      id: ref.read(uuidProvider).v4(),
      type: type,
      weeklyLimit: type == .reduction ? weeklyLimit : null,
      contextKeys: type == .contextual ? List<String>.unmodifiable(contextKeys) : const [],
      motivation: motivation.trim().isEmpty ? null : motivation.trim(),
      startedAt: now,
    );
    try {
      await ref.read(goalRepositoryProvider).activate(input, now);
      Goal? active = await ref.read(goalRepositoryProvider).getActive();
      state = AsyncData(
        current.copyWith(
          activeGoal: active,
          isSaving: false,
          errorMessage: null,
        ),
      );
      return true;
    } on FormatException catch (error) {
      state = AsyncData(
        current.copyWith(isSaving: false, errorMessage: error.message),
      );
      return false;
    } catch (error, stackTrace) {
      ref.reportFailure(error, stackTrace, operation: 'settings.activate_goal');
      state = AsyncData(
        current.copyWith(
          isSaving: false,
          errorMessage: t.settings.goalEditor.error,
        ),
      );
      return false;
    }
  }

  /// Loads coherent sample history when the application runs in debug mode.
  Future<bool> loadSampleData() async {
    if (!kDebugMode) {
      return false;
    }
    SettingsViewState? current = state.value;
    if (current == null || current.isSaving || current.isDeleting) {
      return false;
    }
    state = AsyncData(
      current.copyWith(
        isSaving: true,
        isLoadingSampleData: true,
        sampleDataLoaded: false,
        errorMessage: null,
      ),
    );
    try {
      await ref.read(debugDataSeederProvider).seed(ref.read(appClockProvider).now());
      ref
        ..invalidate(homeSummaryProvider)
        ..invalidate(harvestSummaryProvider)
        ..invalidate(progressDashboardProvider)
        ..invalidate(learningLibraryProvider);
      state = AsyncData(
        current.copyWith(
          isSaving: false,
          isLoadingSampleData: false,
          sampleDataLoaded: true,
          errorMessage: null,
        ),
      );
      return true;
    } catch (_) {
      state = AsyncData(
        current.copyWith(
          isSaving: false,
          isLoadingSampleData: false,
          sampleDataLoaded: false,
          errorMessage: t.settings.developer.sample.error,
        ),
      );
      return false;
    }
  }

  /// Grants one persistent bonus Corn point from debug-only tooling.
  Future<bool> grantDebugCornPoint() async {
    if (!kDebugMode) {
      return false;
    }
    bool result = await _mutate(
      operation: () async {
        AppPreferences preferences = ref.read(appPreferencesProvider);
        int current = await preferences.getDebugHarvestBonusPoints();
        await preferences.setDebugHarvestBonusPoints(current + 1);
      },
      success: (current) => current,
    );
    if (result) {
      ref.invalidate(harvestSummaryProvider);
    }
    return result;
  }

  /// Persists the debug-only override for previewing the supporter thank-you note.
  Future<bool> setDebugShowSupportThanks(bool value) async {
    if (!kDebugMode) {
      return false;
    }
    bool result = await _mutate(
      operation: () => ref.read(appPreferencesProvider).setDebugShowSupportThanks(value),
      success: (current) => current.copyWith(debugShowSupportThanks: value),
    );
    return result;
  }

  /// Permanently deletes local user data and restores first-launch defaults.
  Future<bool> deleteAllData() async {
    SettingsViewState? current = state.value;
    if (current == null || current.isSaving || current.isDeleting) {
      return false;
    }
    state = AsyncData(current.copyWith(isDeleting: true, errorMessage: null));
    AppDatabase database = ref.read(appDatabaseProvider);
    AppPreferences preferences = ref.read(appPreferencesProvider);
    DataExportService exportService = ref.read(dataExportServiceProvider);
    DailyCheckInReminderService reminder = ref.read(
      dailyCheckInReminderServiceProvider,
    );
    DateTime now = ref.read(appClockProvider).now();
    try {
      // Cached exports contain the same sensitive records and are part of a
      // complete deletion. Do this first so a failure leaves primary data
      // untouched and the operation can safely be retried.
      await exportService.purgeExports(bestEffort: false);
      // A platform notification failure must never prevent local data erasure.
      await reminder.setEnabled(false);
      // Each remaining step is idempotent: if one store fails after another
      // has been cleared, retrying finishes the cleanup safely.
      await database.deleteAllUserDataAndReseed(now);
      await preferences.clearStopCornData();
      await AppLocaleResolver.useDeviceOrEnglish();
      if (ref.mounted) {
        ref
          ..invalidate(onboardingControllerProvider)
          ..invalidate(progressPeriodControllerProvider)
          ..invalidate(progressDashboardProvider)
          // Kept-alive preference caches survive the store being cleared, so
          // the theme would stay on a choice that no longer exists until the
          // next launch.
          ..invalidate(themeModeControllerProvider)
          ..invalidate(bootstrapControllerProvider);
      }
      return true;
    } catch (error, stackTrace) {
      ref.reportFailure(error, stackTrace, operation: 'settings.delete_all_data');
      if (ref.mounted) {
        state = AsyncData(
          current.copyWith(
            isDeleting: false,
            errorMessage: t.settings.data.delete.error,
          ),
        );
      }
      return false;
    }
  }

  /// Maps a failed reminder result to localized settings feedback.
  String _reminderError(DailyCheckInReminderResult result) => switch (result) {
    .permissionDenied => t.settings.reminders.error.permissionDenied,
    _ => t.settings.reminders.error.save,
  };

  /// Runs [operation] while exposing a consistent saving state.
  Future<bool> _mutate({
    required Future<void> Function() operation,
    required SettingsViewState Function(SettingsViewState current) success,
  }) async {
    SettingsViewState? current = state.value;
    if (current == null || current.isSaving || current.isDeleting) {
      return false;
    }
    state = AsyncData(current.copyWith(isSaving: true, errorMessage: null));
    try {
      await operation();
      state = AsyncData(
        success(current).copyWith(isSaving: false, errorMessage: null),
      );
      return true;
    } catch (error, stackTrace) {
      ref.reportFailure(error, stackTrace, operation: 'settings.save_preference');
      state = AsyncData(
        current.copyWith(
          isSaving: false,
          errorMessage: t.settings.error.save,
        ),
      );
      return false;
    }
  }
}
