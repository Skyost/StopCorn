/// Keys owned by StopCorn in the platform preferences store.
abstract final class PreferenceKeys {
  /// Whether onboarding has been completed.
  static const String onboardingCompleted = 'onboarding_completed';

  /// Last durable zero-based onboarding step.
  static const String onboardingCurrentStep = 'onboarding_current_step';

  /// Persisted [AppThemeMode] name.
  static const String themeMode = 'theme_mode';

  /// Selected ISO language code.
  static const String locale = 'locale';

  /// Whether the optional harvest indicator is shown.
  static const String showHarvest = 'show_harvest';

  /// Corn points manually granted by debug-only development tooling.
  static const String debugHarvestBonusPoints = 'debug_harvest_bonus_points';

  /// Whether debug tooling forces the project-support thank-you note.
  static const String debugShowSupportThanks = 'debug_show_support_thanks';

  /// Ordered list of selected coping-strategy identifiers.
  static const String selectedStrategyIds = 'selected_strategy_ids';

  /// Whether the local daily check-in reminder is enabled.
  static const String dailyCheckInReminderEnabled = 'daily_check_in_reminder_enabled';

  /// Stored progress-dashboard period key.
  static const String progressPeriod = 'progress_period';

  /// Whether the optional project-support status may be checked online.
  static const String projectSupportChecksEnabled = 'project_support_checks_enabled';

  /// Whether anonymous crash reports may be sent.
  static const String errorReportingEnabled = 'error_reporting_enabled';

  /// Exact allow-list used for export and complete preference deletion.
  static const Set<String> all = {
    onboardingCompleted,
    onboardingCurrentStep,
    themeMode,
    locale,
    showHarvest,
    debugHarvestBonusPoints,
    debugShowSupportThanks,
    selectedStrategyIds,
    dailyCheckInReminderEnabled,
    progressPeriod,
    projectSupportChecksEnabled,
    errorReportingEnabled,
  };
}
