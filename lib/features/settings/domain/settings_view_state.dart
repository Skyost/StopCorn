import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/features/progress/domain/progress_period.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Immutable state displayed by the settings feature.
final class SettingsViewState {
  /// Selected application theme.
  final AppThemeMode themeMode;

  /// Selected application language.
  final AppLocale locale;

  /// Whether the local daily check-in reminder is enabled.
  final bool dailyCheckInReminderEnabled;

  /// Whether the current platform supports recurring local reminders.
  final bool dailyCheckInReminderSupported;

  /// Whether the optional harvest presentation is displayed.
  final bool showHarvest;

  /// Whether anonymous crash reports may be sent.
  final bool errorReportingEnabled;

  /// Default period selected on the progress dashboard.
  final ProgressPeriod defaultProgressPeriod;

  /// Strategy identifiers selected for the personal plan.
  final Set<String> selectedStrategyIds;

  /// Currently active goal, if one exists.
  final Goal? activeGoal;

  /// Whether a local operation currently disables the settings controls.
  final bool isSaving;

  /// Whether complete data deletion is in progress.
  final bool isDeleting;

  /// Whether debug sample history is currently being generated.
  final bool isLoadingSampleData;

  /// Whether sample history was loaded during the current settings session.
  final bool sampleDataLoaded;

  /// Whether debug tooling should force the supporter thank-you note.
  final bool debugShowSupportThanks;

  /// Recoverable error shown by the settings screen.
  final String? errorMessage;

  /// Creates a complete settings snapshot.
  const SettingsViewState({
    required this.themeMode,
    required this.locale,
    required this.dailyCheckInReminderEnabled,
    required this.dailyCheckInReminderSupported,
    required this.showHarvest,
    required this.errorReportingEnabled,
    required this.defaultProgressPeriod,
    required this.selectedStrategyIds,
    this.activeGoal,
    this.isSaving = false,
    this.isDeleting = false,
    this.isLoadingSampleData = false,
    this.sampleDataLoaded = false,
    this.debugShowSupportThanks = false,
    this.errorMessage,
  });

  /// Returns a copy with the supplied settings changed.
  SettingsViewState copyWith({
    AppThemeMode? themeMode,
    AppLocale? locale,
    bool? dailyCheckInReminderEnabled,
    bool? dailyCheckInReminderSupported,
    bool? showHarvest,
    bool? errorReportingEnabled,
    ProgressPeriod? defaultProgressPeriod,
    Set<String>? selectedStrategyIds,
    Object? activeGoal = _unchanged,
    bool? isSaving,
    bool? isDeleting,
    bool? isLoadingSampleData,
    bool? sampleDataLoaded,
    bool? debugShowSupportThanks,
    Object? errorMessage = _unchanged,
  }) => SettingsViewState(
    themeMode: themeMode ?? this.themeMode,
    locale: locale ?? this.locale,
    dailyCheckInReminderEnabled: dailyCheckInReminderEnabled ?? this.dailyCheckInReminderEnabled,
    dailyCheckInReminderSupported: dailyCheckInReminderSupported ?? this.dailyCheckInReminderSupported,
    showHarvest: showHarvest ?? this.showHarvest,
    errorReportingEnabled: errorReportingEnabled ?? this.errorReportingEnabled,
    defaultProgressPeriod: defaultProgressPeriod ?? this.defaultProgressPeriod,
    selectedStrategyIds: selectedStrategyIds ?? this.selectedStrategyIds,
    activeGoal: identical(activeGoal, _unchanged) ? this.activeGoal : activeGoal as Goal?,
    isSaving: isSaving ?? this.isSaving,
    isDeleting: isDeleting ?? this.isDeleting,
    isLoadingSampleData: isLoadingSampleData ?? this.isLoadingSampleData,
    sampleDataLoaded: sampleDataLoaded ?? this.sampleDataLoaded,
    debugShowSupportThanks: debugShowSupportThanks ?? this.debugShowSupportThanks,
    errorMessage: identical(errorMessage, _unchanged) ? this.errorMessage : errorMessage as String?,
  );
}

/// Sentinel used to distinguish an omitted nullable copy value from `null`.
const Object _unchanged = Object();
