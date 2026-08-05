import 'dart:async';

import 'package:stopcorn/features/check_in/data/daily_check_in_notification_gateway.dart';

/// In-memory local-notification boundary for deterministic reminder tests.
final class FakeDailyCheckInNotificationGateway implements DailyCheckInNotificationGateway {
  /// Whether the simulated platform supports recurring reminders.
  @override
  final bool isSupported;

  /// Whether the simulated launch came from the reminder.
  bool launchedFromNotification = false;

  /// Simulated taps on a displayed reminder.
  final StreamController<void> openedController = StreamController<void>.broadcast();

  /// Permission result returned by the simulated operating system.
  bool permissionGranted;

  /// Whether platform operations should fail.
  bool shouldFail;

  /// Whether only the permission request should fail.
  bool failPermission;

  /// Whether only reminder scheduling should fail.
  bool failScheduling;

  /// Whether only reminder cancellation should fail.
  bool failCancellation;

  /// Number of permission prompts requested by the application.
  int permissionRequestCount = 0;

  /// Number of reminder cancellations requested by the application.
  int cancellationCount = 0;

  /// Reminder requests scheduled in chronological call order.
  final List<DailyCheckInNotificationRequest> scheduledRequests = [];

  /// Creates a configurable in-memory notification gateway.
  FakeDailyCheckInNotificationGateway({
    this.isSupported = true,
    this.permissionGranted = true,
    this.shouldFail = false,
    this.failPermission = false,
    this.failScheduling = false,
    this.failCancellation = false,
  });

  @override
  Stream<void> get opened => openedController.stream;

  @override
  Future<bool> launchedFromReminder() async => launchedFromNotification;

  @override
  Future<void> cancelDailyReminder() async {
    if (shouldFail || failCancellation) {
      throw StateError('Simulated notification cancellation failure.');
    }
    cancellationCount++;
  }

  @override
  Future<bool> requestPermission() async {
    if (shouldFail || failPermission) {
      throw StateError('Simulated notification permission failure.');
    }
    permissionRequestCount++;
    return permissionGranted;
  }

  @override
  Future<void> scheduleDailyReminder(
    DailyCheckInNotificationRequest request,
  ) async {
    if (shouldFail || failScheduling) {
      throw StateError('Simulated notification scheduling failure.');
    }
    scheduledRequests.add(request);
  }
}
