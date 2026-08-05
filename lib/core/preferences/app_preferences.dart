import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stopcorn/core/preferences/preference_keys.dart';

/// Theme preference persisted independently from Flutter's theme enum.
enum AppThemeMode {
  /// Follow the platform brightness setting.
  system,

  /// Always use the light theme.
  light,

  /// Always use the dark theme.
  dark;

  /// Parses [value], falling back to the system theme.
  static AppThemeMode fromStoredValue(String? value) => AppThemeMode.values.firstWhere(
    (mode) => mode.name == value,
    orElse: () => .system,
  );
}

/// Typed facade over the asynchronous local preferences store.
final class AppPreferences {
  /// Underlying asynchronous preferences implementation.
  final SharedPreferencesAsync _store;

  /// Emits after a StopCorn preference changes.
  final StreamController<void> _changes = StreamController<void>.broadcast(
    sync: true,
  );

  /// Creates the preferences facade backed by [store].
  AppPreferences(SharedPreferencesAsync store) : _store = store;

  /// Stream of local preference mutations.
  Stream<void> get changes => _changes.stream;

  /// Returns whether onboarding has been completed.
  Future<bool> getOnboardingCompleted() async => await _store.getBool(PreferenceKeys.onboardingCompleted) ?? false;

  /// Persists whether onboarding has been completed.
  Future<void> setOnboardingCompleted(bool value) => _set(() => _store.setBool(PreferenceKeys.onboardingCompleted, value));

  /// Returns the last durable zero-based onboarding step.
  Future<int> getOnboardingCurrentStep() async => await _store.getInt(PreferenceKeys.onboardingCurrentStep) ?? 0;

  /// Persists the current zero-based onboarding step.
  Future<void> setOnboardingCurrentStep(int value) => _set(() => _store.setInt(PreferenceKeys.onboardingCurrentStep, value));

  /// Returns the selected application theme mode.
  Future<AppThemeMode> getThemeMode() async => AppThemeMode.fromStoredValue(
    await _store.getString(PreferenceKeys.themeMode),
  );

  /// Persists the selected application theme [value].
  Future<void> setThemeMode(AppThemeMode value) => _set(() => _store.setString(PreferenceKeys.themeMode, value.name));

  /// Returns the selected ISO language code, or `null` to follow the device.
  Future<String?> getLocale() async => await _store.getString(PreferenceKeys.locale);

  /// Persists the selected ISO language-code [value].
  Future<void> setLocale(String value) => _set(() => _store.setString(PreferenceKeys.locale, value));

  /// Returns whether the optional harvest indicator is shown.
  Future<bool> getShowHarvest() async {
    bool? current = await _store.getBool(PreferenceKeys.showHarvest);
    return current ?? true;
  }

  /// Persists optional harvest visibility.
  Future<void> setShowHarvest(bool value) => _set(
    () => _store.setBool(PreferenceKeys.showHarvest, value),
  );

  /// Returns Corn points manually granted by debug-only tooling.
  Future<int> getDebugHarvestBonusPoints() async {
    int stored =
        await _store.getInt(
          PreferenceKeys.debugHarvestBonusPoints,
        ) ??
        0;
    return stored < 0 ? 0 : stored;
  }

  /// Persists the non-negative number of debug-only bonus Corn points.
  Future<void> setDebugHarvestBonusPoints(int value) {
    if (value < 0) {
      throw ArgumentError.value(
        value,
        'value',
        'The debug harvest bonus cannot be negative.',
      );
    }
    return _set(
      () => _store.setInt(
        PreferenceKeys.debugHarvestBonusPoints,
        value,
      ),
    );
  }

  /// Returns whether debug tooling forces the project-support thank-you note.
  Future<bool> getDebugShowSupportThanks() async => await _store.getBool(PreferenceKeys.debugShowSupportThanks) ?? false;

  /// Persists the debug-only project-support thank-you override.
  Future<void> setDebugShowSupportThanks(bool value) => _set(
    () => _store.setBool(PreferenceKeys.debugShowSupportThanks, value),
  );

  /// Returns the persisted coping-strategy identifiers.
  Future<List<String>> getSelectedStrategyIds() async => await _store.getStringList(PreferenceKeys.selectedStrategyIds) ?? [];

  /// Persists an immutable copy of selected coping-strategy identifiers.
  Future<void> setSelectedStrategyIds(List<String> values) => _set(
    () => _store.setStringList(
      PreferenceKeys.selectedStrategyIds,
      List<String>.unmodifiable(values),
    ),
  );

  /// Returns whether the local daily check-in reminder is enabled.
  Future<bool> getDailyCheckInReminderEnabled() async => await _store.getBool(PreferenceKeys.dailyCheckInReminderEnabled) ?? false;

  /// Persists whether the local daily check-in reminder is enabled.
  Future<void> setDailyCheckInReminderEnabled(bool value) => _set(
    () => _store.setBool(PreferenceKeys.dailyCheckInReminderEnabled, value),
  );

  /// Returns the storage key of the default progress period.
  Future<String> getProgressPeriod() async => await _store.getString(PreferenceKeys.progressPeriod) ?? '30d';

  /// Persists the storage key of the default progress period.
  Future<void> setProgressPeriod(String value) => _set(() => _store.setString(PreferenceKeys.progressPeriod, value));

  /// Returns whether the project-support status may be checked online.
  ///
  /// StopCorn stays offline until the person opens the support paywall, which
  /// already reaches the store. Nothing is checked before that, so simply
  /// opening Settings never contacts RevenueCat.
  Future<bool> getProjectSupportChecksEnabled() async => await _store.getBool(PreferenceKeys.projectSupportChecksEnabled) ?? false;

  /// Persists whether the project-support status may be checked online.
  Future<void> setProjectSupportChecksEnabled(bool value) => _set(
    () => _store.setBool(PreferenceKeys.projectSupportChecksEnabled, value),
  );

  /// Returns whether anonymous crash reports may be sent.
  ///
  /// Reports are on by default because a crash nobody hears about keeps
  /// happening, and they contain no journal content. Turning the preference
  /// off in Settings stops them entirely, including on the current launch.
  Future<bool> getErrorReportingEnabled() async => await _store.getBool(PreferenceKeys.errorReportingEnabled) ?? true;

  /// Persists whether anonymous crash reports may be sent.
  Future<void> setErrorReportingEnabled(bool value) => _set(
    () => _store.setBool(PreferenceKeys.errorReportingEnabled, value),
  );

  /// Returns every StopCorn-owned preference for the voluntary export.
  Future<Map<String, Object?>> exportValues() => _store.getAll(allowList: PreferenceKeys.all);

  /// Removes every StopCorn-owned preference and emits one change event.
  Future<void> clearStopCornData() async {
    await _store.clear(allowList: PreferenceKeys.all);
    _changes.add(null);
  }

  /// Closes the preference change stream.
  Future<void> dispose() => _changes.close();

  /// Runs one preference write and then emits a change notification.
  Future<void> _set(Future<void> Function() operation) async {
    await operation();
    _changes.add(null);
  }
}
