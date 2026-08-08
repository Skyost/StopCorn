import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest_all.dart' as timezone_data;
import 'package:timezone/timezone.dart' as timezone;

part 'daily_check_in_notification_gateway.g.dart';

/// Complete platform-facing content for one recurring check-in reminder.
final class DailyCheckInNotificationRequest {
  /// First local calendar occurrence of the recurring reminder.
  final DateTime firstOccurrence;

  /// Short notification title.
  final String title;

  /// Short notification body.
  final String body;

  /// Android notification-channel name.
  final String channelName;

  /// Android notification-channel explanation.
  final String channelDescription;

  /// Creates a request for a daily local notification.
  const DailyCheckInNotificationRequest({
    required this.firstOccurrence,
    required this.title,
    required this.body,
    required this.channelName,
    required this.channelDescription,
  });
}

/// Platform boundary used to request, schedule, and cancel local notifications.
abstract interface class DailyCheckInNotificationGateway {
  /// Whether recurring local reminders are implemented on this platform.
  bool get isSupported;

  /// Emits once each time a check-in reminder is opened by the user.
  Stream<void> get opened;

  /// Whether the running application was launched from the reminder.
  Future<bool> launchedFromReminder();

  /// Requests the operating-system notification permission.
  Future<bool> requestPermission();

  /// Replaces the recurring daily reminder with [request].
  Future<void> scheduleDailyReminder(
    DailyCheckInNotificationRequest request,
  );

  /// Cancels the pending and currently displayed check-in reminder.
  Future<void> cancelDailyReminder();
}

/// Mobile implementation backed by the local-notifications platform plugin.
final class FlutterDailyCheckInNotificationGateway implements DailyCheckInNotificationGateway {
  /// Stable Android channel identifier retained across application runs.
  static const String _channelId = 'daily_check_in_reminders';

  /// Stable identifier shared by the scheduled and displayed notification.
  final int _notificationId;

  /// Plugin instance used for all platform operations.
  final FlutterLocalNotificationsPlugin _plugin;

  /// Whether plugin initialization has completed successfully.
  bool _initialized = false;

  /// Broadcasts each user tap on a displayed check-in reminder.
  final StreamController<void> _opened = StreamController<void>.broadcast();

  /// Creates a mobile notification gateway.
  FlutterDailyCheckInNotificationGateway(
    this._notificationId, {
    FlutterLocalNotificationsPlugin? plugin,
  }) : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  @override
  bool get isSupported => !kIsWeb && (defaultTargetPlatform == .android || defaultTargetPlatform == .iOS);

  @override
  Stream<void> get opened => _opened.stream;

  @override
  Future<bool> launchedFromReminder() async {
    if (!isSupported) {
      return false;
    }
    try {
      await _ensureInitialized();
      NotificationAppLaunchDetails? details = await _plugin.getNotificationAppLaunchDetails();
      return details?.didNotificationLaunchApp == true && details?.notificationResponse?.id == _notificationId;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> requestPermission() async {
    await _ensureInitialized();
    return switch (defaultTargetPlatform) {
      .android => await _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission() ?? false,
      .iOS =>
        await _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
              alert: true,
              badge: false,
              sound: true,
            ) ??
            false,
      _ => false,
    };
  }

  @override
  Future<void> scheduleDailyReminder(
    DailyCheckInNotificationRequest request,
  ) async {
    await _ensureInitialized();
    timezone.Location location = await _loadDeviceTimeZone();
    DateTime first = request.firstOccurrence;
    timezone.TZDateTime scheduledDate = timezone.TZDateTime(
      location,
      first.year,
      first.month,
      first.day,
      first.hour,
      first.minute,
    );
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        request.channelName,
        channelDescription: request.channelDescription,
        importance: .defaultImportance,
        priority: .defaultPriority,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: false,
        presentSound: true,
      ),
    );
    await _plugin.cancel(id: _notificationId);
    await _plugin.zonedSchedule(
      id: _notificationId,
      title: request.title,
      body: request.body,
      scheduledDate: scheduledDate,
      notificationDetails: details,
      androidScheduleMode: .inexactAllowWhileIdle,
      matchDateTimeComponents: .time,
    );
  }

  @override
  Future<void> cancelDailyReminder() async {
    if (!isSupported) {
      return;
    }
    await _ensureInitialized();
    await _plugin.cancel(id: _notificationId);
  }

  /// Initializes the plugin without prompting for notification permission.
  Future<void> _ensureInitialized() async {
    if (!isSupported) {
      throw UnsupportedError(
        'Daily check-in notifications are unavailable on this platform.',
      );
    }
    if (_initialized) {
      return;
    }
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('ic_stat_stopcorn'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: _handleResponse,
    );
    _initialized = true;
  }

  /// Reports a tap on the check-in reminder to the application.
  void _handleResponse(NotificationResponse response) {
    if (response.id == _notificationId && !_opened.isClosed) {
      _opened.add(null);
    }
  }

  /// Loads the current IANA device zone for daylight-saving-safe scheduling.
  Future<timezone.Location> _loadDeviceTimeZone() async {
    timezone_data.initializeTimeZones();
    TimezoneInfo information = await FlutterTimezone.getLocalTimezone();
    timezone.Location location = timezone.getLocation(information.identifier);
    timezone.setLocalLocation(location);
    return location;
  }
}

/// Explicit implementation for platforms without recurring local reminders.
final class UnsupportedDailyCheckInNotificationGateway implements DailyCheckInNotificationGateway {
  /// Creates an unsupported-platform gateway.
  const UnsupportedDailyCheckInNotificationGateway();

  @override
  bool get isSupported => false;

  @override
  Stream<void> get opened => const Stream<void>.empty();

  @override
  Future<bool> launchedFromReminder() => Future<bool>.value(false);

  @override
  Future<void> cancelDailyReminder() => Future<void>.value();

  @override
  Future<bool> requestPermission() => Future<bool>.value(false);

  @override
  Future<void> scheduleDailyReminder(
    DailyCheckInNotificationRequest request,
  ) => Future<void>.error(
    UnsupportedError(
      'Daily check-in notifications are unavailable on this platform.',
    ),
  );
}

/// Exposes the process-wide local-notification boundary injected by [main].
@Riverpod(keepAlive: true)
DailyCheckInNotificationGateway dailyCheckInNotificationGateway(Ref ref) => const UnsupportedDailyCheckInNotificationGateway();
