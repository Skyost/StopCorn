import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/check_in/application/daily_check_in_reminder_service.dart';
import 'package:stopcorn/features/check_in/data/check_in_repository.dart';
import 'package:stopcorn/features/check_in/domain/daily_check_in_input.dart';

import '../../helpers/fake_daily_check_in_notification_gateway.dart';
import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';

/// Runs local daily check-in reminder coordination tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  test('enabling schedules the first reminder at 8 p.m.', () async {
    _ReminderFixture fixture = _ReminderFixture.create(
      DateTime(2026, 7, 28, 12),
    );
    addTearDown(fixture.dispose);

    DailyCheckInReminderResult result = await fixture.service.setEnabled(true);

    expect(result, DailyCheckInReminderResult.enabled);
    expect(await fixture.preferences.getDailyCheckInReminderEnabled(), isTrue);
    expect(fixture.gateway.permissionRequestCount, 1);
    expect(fixture.gateway.scheduledRequests, hasLength(1));
    expect(
      fixture.gateway.scheduledRequests.single.firstOccurrence,
      DateTime(2026, 7, 28, 20),
    );
  });

  test('an existing check-in postpones the reminder until tomorrow', () async {
    DateTime now = DateTime(2026, 7, 28, 12);
    _ReminderFixture fixture = _ReminderFixture.create(now);
    addTearDown(fixture.dispose);
    await fixture.checkIns.save(
      DailyCheckInInput(
        localDate: '2026-07-28',
        recordedAt: now,
        moodScore: 6,
        controlScore: 7,
      ),
    );
    await fixture.preferences.setDailyCheckInReminderEnabled(true);

    DailyCheckInReminderResult result = await fixture.service.synchronize();

    expect(result, DailyCheckInReminderResult.enabled);
    expect(
      fixture.gateway.scheduledRequests.single.firstOccurrence,
      DateTime(2026, 7, 29, 20),
    );
  });

  test('after 8 p.m. the next reminder starts tomorrow', () async {
    _ReminderFixture fixture = _ReminderFixture.create(
      DateTime(2026, 7, 28, 21),
    );
    addTearDown(fixture.dispose);
    await fixture.preferences.setDailyCheckInReminderEnabled(true);

    await fixture.service.synchronize();

    expect(
      fixture.gateway.scheduledRequests.single.firstOccurrence,
      DateTime(2026, 7, 29, 20),
    );
  });

  test('denied permission keeps the reminder disabled', () async {
    FakeDailyCheckInNotificationGateway gateway = FakeDailyCheckInNotificationGateway(
      permissionGranted: false,
    );
    _ReminderFixture fixture = _ReminderFixture.create(
      DateTime(2026, 7, 28, 12),
      gateway: gateway,
    );
    addTearDown(fixture.dispose);

    DailyCheckInReminderResult result = await fixture.service.setEnabled(true);

    expect(result, DailyCheckInReminderResult.permissionDenied);
    expect(await fixture.preferences.getDailyCheckInReminderEnabled(), isFalse);
    expect(gateway.scheduledRequests, isEmpty);
  });

  test('disabling cancels the system reminder', () async {
    _ReminderFixture fixture = _ReminderFixture.create(
      DateTime(2026, 7, 28, 12),
    );
    addTearDown(fixture.dispose);
    await fixture.preferences.setDailyCheckInReminderEnabled(true);

    DailyCheckInReminderResult result = await fixture.service.setEnabled(false);

    expect(result, DailyCheckInReminderResult.disabled);
    expect(await fixture.preferences.getDailyCheckInReminderEnabled(), isFalse);
    expect(fixture.gateway.cancellationCount, 1);
  });
}

/// Owns local dependencies used by reminder-service tests.
final class _ReminderFixture {
  /// In-memory relational store.
  final AppDatabase database;

  /// Isolated preference store.
  final AppPreferences preferences;

  /// Daily check-in repository backed by [database].
  final CheckInRepository checkIns;

  /// Configurable platform-notification double.
  final FakeDailyCheckInNotificationGateway gateway;

  /// Reminder service under test.
  final DailyCheckInReminderService service;

  /// Creates a fixture from fully initialized dependencies.
  const _ReminderFixture({
    required this.database,
    required this.preferences,
    required this.checkIns,
    required this.gateway,
    required this.service,
  });

  /// Creates an isolated fixture fixed at [now].
  factory _ReminderFixture.create(
    DateTime now, {
    FakeDailyCheckInNotificationGateway? gateway,
  }) {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(createTestPreferences());
    CheckInRepository checkIns = CheckInRepository(database);
    FakeDailyCheckInNotificationGateway notificationGateway = gateway ?? FakeDailyCheckInNotificationGateway();
    return _ReminderFixture(
      database: database,
      preferences: preferences,
      checkIns: checkIns,
      gateway: notificationGateway,
      service: DailyCheckInReminderService(
        preferences,
        checkIns,
        FixedAppClock(now),
        notificationGateway,
      ),
    );
  }

  /// Releases the local fixture resources.
  Future<void> dispose() async {
    await preferences.dispose();
    await database.close();
  }
}
