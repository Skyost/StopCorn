/// Non-visual application limits, versions, and storage constants.
abstract final class AppConstants {
  /// Product name written into exports and metadata.
  static const String appName = 'StopCorn';

  /// Schema version of the generated JSON export.
  static const int exportVersion = 1;

  /// SQLite filename inside the application documents directory.
  static const String databaseFileName = 'stopcorn.sqlite';

  /// Current Drift schema version.
  static const int databaseSchemaVersion = 1;

  /// Current bundled learning-content schema version.
  static const int learningContentVersion = 1;

  /// Maximum number of characters accepted for a motivation.
  static const int motivationMaxLength = 280;

  /// Maximum number of characters accepted for a short context label.
  static const int shortContextMaxLength = 80;

  /// Maximum number of characters accepted for a private note.
  static const int noteMaxLength = 1000;

  /// Default duration of the guided pause.
  static const int guidedPauseSeconds = 90;

  /// Local hour at which an unfinished daily check-in is recalled.
  static const int dailyCheckInReminderHour = 20;

  /// Stable platform notification identifier for the daily check-in reminder.
  static const int dailyCheckInNotificationId = 2001;
}
