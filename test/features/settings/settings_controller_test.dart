import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/check_in/data/daily_check_in_notification_gateway.dart';
import 'package:stopcorn/features/data_export/data/data_export_service.dart';
import 'package:stopcorn/features/settings/application/settings_controller.dart';

import '../../helpers/fake_daily_check_in_notification_gateway.dart';
import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';

/// Runs settings controller tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  test('a new goal keeps the previous one in history', () async {
    _SettingsFixture fixture = await _settingsFixture();
    addTearDown(fixture.dispose);
    SettingsController controller = fixture.container.read(
      settingsControllerProvider.notifier,
    );
    await fixture.container.read(settingsControllerProvider.future);

    expect(
      await controller.activateGoal(
        type: GoalType.observation,
        weeklyLimit: null,
        contextKeys: const [],
        motivation: 'Observe',
      ),
      isTrue,
    );
    expect(
      await controller.activateGoal(
        type: GoalType.reduction,
        weeklyLimit: 2,
        contextKeys: const [],
        motivation: 'Reduce',
      ),
      isTrue,
    );

    List<Goal> goals = await fixture.database.select(fixture.database.goals).get();
    expect(goals, hasLength(2));
    expect(goals.where((goal) => goal.isActive), hasLength(1));
    expect(
      goals.singleWhere((goal) => goal.isActive).type,
      GoalType.reduction.name,
    );
  });

  test(
    'complete deletion clears data and reinserts strategies',
    () async {
      _SettingsFixture fixture = await _settingsFixture();
      addTearDown(fixture.dispose);
      DateTime now = DateTime.utc(2026, 7, 28, 12);
      await fixture.database
          .into(fixture.database.consumptionEvents)
          .insert(
            ConsumptionEventsCompanion.insert(
              id: 'event',
              occurredAt: now,
              createdAt: now,
            ),
          );
      await fixture.preferences.setOnboardingCompleted(true);
      Directory exportDirectory = Directory.fromUri(
        fixture.temporaryDirectory.uri.resolve('exports/'),
      );
      await exportDirectory.create(recursive: true);
      File cachedExport = File.fromUri(
        exportDirectory.uri.resolve('stopcorn-export.json'),
      );
      await cachedExport.writeAsString('{"private": true}');
      await fixture.container.read(settingsControllerProvider.future);

      bool deleted = await fixture.container.read(settingsControllerProvider.notifier).deleteAllData();

      expect(deleted, isTrue);
      expect(
        await fixture.database.select(fixture.database.consumptionEvents).get(),
        isEmpty,
      );
      expect(
        await fixture.database.select(fixture.database.copingStrategies).get(),
        hasLength(9),
      );
      expect(await fixture.preferences.getOnboardingCompleted(), isFalse);
      expect(await fixture.preferences.getSelectedStrategyIds(), isEmpty);
      expect(await fixture.preferences.getLocale(), isNull);
      expect(await cachedExport.exists(), isFalse);
    },
  );

  test('notification cancellation failure does not block data deletion', () async {
    FakeDailyCheckInNotificationGateway notificationGateway = FakeDailyCheckInNotificationGateway(shouldFail: true);
    _SettingsFixture fixture = await _settingsFixture(
      notificationGateway: notificationGateway,
    );
    addTearDown(fixture.dispose);
    DateTime now = DateTime.utc(2026, 7, 28, 12);
    await fixture.database
        .into(fixture.database.consumptionEvents)
        .insert(
          ConsumptionEventsCompanion.insert(
            id: 'event',
            occurredAt: now,
            createdAt: now,
          ),
        );
    await fixture.preferences.setDailyCheckInReminderEnabled(true);
    await fixture.container.read(settingsControllerProvider.future);

    bool deleted = await fixture.container.read(settingsControllerProvider.notifier).deleteAllData();

    expect(deleted, isTrue);
    expect(
      await fixture.database.select(fixture.database.consumptionEvents).get(),
      isEmpty,
    );
    expect(await fixture.preferences.getDailyCheckInReminderEnabled(), isFalse);
  });
}

/// Creates an isolated settings fixture with seeded strategies.
Future<_SettingsFixture> _settingsFixture({
  DailyCheckInNotificationGateway? notificationGateway,
}) async {
  AppDatabase database = AppDatabase(NativeDatabase.memory());
  AppPreferences preferences = AppPreferences(createTestPreferences());
  Directory temporaryDirectory = await Directory.systemTemp.createTemp(
    'stopcorn-settings-test-',
  );
  DataExportService exportService = DataExportService(
    database,
    preferences,
    FixedAppClock(DateTime.utc(2026, 7, 28, 12)),
    () async => temporaryDirectory,
    (_) async {},
  );
  ProviderContainer container = ProviderContainer(
    overrides: [
      appDatabaseProvider.overrideWithValue(database),
      appPreferencesProvider.overrideWithValue(preferences),
      appClockProvider.overrideWithValue(
        FixedAppClock(DateTime.utc(2026, 7, 28, 12)),
      ),
      dataExportServiceProvider.overrideWithValue(exportService),
      if (notificationGateway != null)
        dailyCheckInNotificationGatewayProvider.overrideWithValue(
          notificationGateway,
        ),
    ],
  );
  await database.seedBuiltInStrategies(DateTime.utc(2026, 7, 28));
  return _SettingsFixture(
    database,
    preferences,
    container,
    temporaryDirectory,
  );
}

/// Owns the disposable dependencies used by settings controller tests.
final class _SettingsFixture {
  /// In-memory application database.
  final AppDatabase database;

  /// Isolated preferences store.
  final AppPreferences preferences;

  /// Provider container wired to the test dependencies.
  final ProviderContainer container;

  /// Isolated temporary cache used by data-export tests.
  final Directory temporaryDirectory;

  /// Creates a fixture that owns [database], [preferences], and [container].
  const _SettingsFixture(
    this.database,
    this.preferences,
    this.container,
    this.temporaryDirectory,
  );

  /// Releases every dependency owned by this fixture.
  Future<void> dispose() async {
    container.dispose();
    await preferences.dispose();
    await database.close();
    if (await temporaryDirectory.exists()) {
      await temporaryDirectory.delete(recursive: true);
    }
  }
}
