import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/diagnostics/error_reporter.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/core/utils/local_date.dart';
import 'package:stopcorn/features/check_in/data/check_in_repository.dart';
import 'package:stopcorn/features/check_in/data/daily_check_in_notification_gateway.dart';
import 'package:stopcorn/i18n/strings.g.dart';

part 'daily_check_in_reminder_service.g.dart';

/// Result of a local daily check-in reminder operation.
enum DailyCheckInReminderResult {
  /// The reminder is enabled and scheduled.
  enabled,

  /// The reminder is disabled and cancelled.
  disabled,

  /// The user did not grant the system notification permission.
  permissionDenied,

  /// The current platform cannot schedule this reminder.
  unsupported,

  /// A platform or persistence operation failed.
  failed;

  /// Whether the requested enabled or disabled state was fully applied.
  bool get succeeded => this == .enabled || this == .disabled;
}

/// Coordinates reminder preference, check-in history, and platform scheduling.
final class DailyCheckInReminderService {
  /// Simple persisted reminder preference.
  final AppPreferences _preferences;

  /// Repository used to determine whether today's check-in already exists.
  final CheckInRepository _checkIns;

  /// Clock used for local-calendar scheduling decisions.
  final AppClock _clock;

  /// Replaceable platform-notification boundary.
  final DailyCheckInNotificationGateway _gateway;

  /// Boundary used to report a reminder that could not be applied.
  ///
  /// A reminder failing silently is invisible to the person who asked for it,
  /// so the failure is worth reporting even though it is already handled.
  final ErrorReporter _errorReporter;

  /// Creates a reminder coordinator from local dependencies.
  const DailyCheckInReminderService(
    this._preferences,
    this._checkIns,
    this._clock,
    this._gateway, [
    this._errorReporter = const DisabledErrorReporter(),
  ]);

  /// Whether reminders are implemented on the current platform.
  bool get isSupported => _gateway.isSupported;

  /// Requests notification permission without changing the stored preference.
  Future<DailyCheckInReminderResult> requestPermission() async {
    if (!_gateway.isSupported) {
      return .unsupported;
    }
    try {
      bool granted = await _gateway.requestPermission();
      return granted ? .enabled : .permissionDenied;
    } catch (error, stackTrace) {
      _errorReporter.reportError(error, stackTrace, operation: 'reminder.request_permission');
      return .failed;
    }
  }

  /// Enables or disables the reminder and applies it immediately.
  Future<DailyCheckInReminderResult> setEnabled(bool enabled) async {
    if (!enabled) {
      return _disable();
    }
    DailyCheckInReminderResult permission = await requestPermission();
    if (permission != .enabled) {
      return permission;
    }
    try {
      await _preferences.setDailyCheckInReminderEnabled(true);
    } catch (_) {
      return .failed;
    }
    DailyCheckInReminderResult result = await synchronize();
    if (result != .enabled) {
      try {
        await _preferences.setDailyCheckInReminderEnabled(false);
      } catch (_) {
        return .failed;
      }
      DailyCheckInReminderResult cancellation = await _cancelDisabledReminder();
      if (cancellation == .failed) {
        return .failed;
      }
    }
    return result;
  }

  /// Reconciles the stored preference and today's check-in with the OS schedule.
  Future<DailyCheckInReminderResult> synchronize() async {
    bool enabled;
    try {
      enabled = await _preferences.getDailyCheckInReminderEnabled();
    } catch (error, stackTrace) {
      _errorReporter.reportError(error, stackTrace, operation: 'reminder.read_preference');
      return .failed;
    }
    if (!enabled) {
      return _cancelDisabledReminder();
    }
    if (!_gateway.isSupported) {
      return .unsupported;
    }
    try {
      DateTime now = _clock.now().toLocal();
      DailyCheckIn? checkIn = await _checkIns.getByLocalDate(
        localDateKey(now),
      );
      DateTime firstOccurrence = _firstOccurrence(
        now,
        checkInCompleted: checkIn != null,
      );
      await _gateway.scheduleDailyReminder(
        DailyCheckInNotificationRequest(
          firstOccurrence: firstOccurrence,
          title: t.notifications.dailyCheckIn.title,
          body: t.notifications.dailyCheckIn.body,
          channelName: t.notifications.dailyCheckIn.channelName,
          channelDescription: t.notifications.dailyCheckIn.channelDescription,
        ),
      );
      return .enabled;
    } catch (error, stackTrace) {
      _errorReporter.reportError(error, stackTrace, operation: 'reminder.schedule');
      return .failed;
    }
  }

  /// Disables the preference before cancelling any platform reminder.
  Future<DailyCheckInReminderResult> _disable() async {
    try {
      await _preferences.setDailyCheckInReminderEnabled(false);
    } catch (_) {
      return .failed;
    }
    return _cancelDisabledReminder();
  }

  /// Cancels stale schedules when the persisted preference is disabled.
  Future<DailyCheckInReminderResult> _cancelDisabledReminder() async {
    if (!_gateway.isSupported) {
      return .disabled;
    }
    try {
      await _gateway.cancelDailyReminder();
      return .disabled;
    } catch (error, stackTrace) {
      _errorReporter.reportError(error, stackTrace, operation: 'reminder.cancel');
      return .failed;
    }
  }

  /// Computes today at 20:00, or tomorrow when today is complete or too late.
  DateTime _firstOccurrence(
    DateTime now, {
    required bool checkInCompleted,
  }) {
    DateTime today = DateTime(
      now.year,
      now.month,
      now.day,
      AppConstants.dailyCheckInReminderHour,
    );
    if (!checkInCompleted && now.isBefore(today)) {
      return today;
    }
    return DateTime(
      now.year,
      now.month,
      now.day + 1,
      AppConstants.dailyCheckInReminderHour,
    );
  }
}

/// Provides the local daily check-in reminder coordinator.
@Riverpod(keepAlive: true)
DailyCheckInReminderService dailyCheckInReminderService(Ref ref) => DailyCheckInReminderService(
  ref.watch(appPreferencesProvider),
  ref.watch(checkInRepositoryProvider),
  ref.watch(appClockProvider),
  ref.watch(dailyCheckInNotificationGatewayProvider),
  ref.watch(errorReporterProvider),
);
