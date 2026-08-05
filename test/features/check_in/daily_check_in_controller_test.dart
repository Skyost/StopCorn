import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/check_in/application/daily_check_in_controller.dart';
import 'package:stopcorn/features/check_in/data/daily_check_in_notification_gateway.dart';
import 'package:stopcorn/features/check_in/domain/daily_check_in_state.dart';
import 'package:stopcorn/features/consumption/data/consumption_repository.dart';
import 'package:stopcorn/features/consumption/domain/consumption_input.dart';

import '../../helpers/fake_daily_check_in_notification_gateway.dart';
import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';

/// Instant anchoring every check-in scenario to 28 July 2026.
final DateTime _now = DateTime(2026, 7, 28, 21);

/// Runs daily check-in controller tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  test('counts consumption events recorded today', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    ConsumptionRepository consumptions = ConsumptionRepository(database);
    // Two events today, framing the local day, plus one the day before.
    await consumptions.add(
      ConsumptionInput(
        id: 'today-morning',
        occurredAt: DateTime(2026, 7, 28, 0, 5),
        createdAt: _now,
      ),
    );
    await consumptions.add(
      ConsumptionInput(
        id: 'today-evening',
        occurredAt: DateTime(2026, 7, 28, 20, 55),
        createdAt: _now,
      ),
    );
    await consumptions.add(
      ConsumptionInput(
        id: 'yesterday',
        occurredAt: DateTime(2026, 7, 27, 23, 55),
        createdAt: _now,
      ),
    );
    ProviderContainer container = _container(database);
    addTearDown(container.dispose);

    DailyCheckInState state = await container.read(
      dailyCheckInControllerProvider(null).future,
    );

    expect(state.recordedConsumptionCount, 2);
  });

  test('returns zero when nothing was recorded', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    ProviderContainer container = _container(database);
    addTearDown(container.dispose);

    DailyCheckInState state = await container.read(
      dailyCheckInControllerProvider(null).future,
    );

    expect(state.recordedConsumptionCount, 0);
  });

  test('refreshes the count without losing the draft', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    ConsumptionRepository consumptions = ConsumptionRepository(database);
    await consumptions.add(
      ConsumptionInput(
        id: 'first',
        occurredAt: DateTime(2026, 7, 28, 10),
        createdAt: _now,
      ),
    );
    ProviderContainer container = _container(database);
    addTearDown(container.dispose);

    DailyCheckInControllerProvider provider = dailyCheckInControllerProvider(
      null,
    );
    await container.read(provider.future);
    DailyCheckInController controller = container.read(provider.notifier);
    controller.setMoodScore(8);
    controller.setNote('Preserved draft');

    await consumptions.add(
      ConsumptionInput(
        id: 'second',
        occurredAt: DateTime(2026, 7, 28, 20),
        createdAt: _now,
      ),
    );
    await controller.refreshRecordedConsumptionCount();

    DailyCheckInState state = container.read(provider).requireValue;
    expect(state.recordedConsumptionCount, 2);
    expect(state.moodScore, 8);
    expect(state.note, 'Preserved draft');
  });

  test('prefills the requested day rather than today', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await ConsumptionRepository(database).add(
      ConsumptionInput(
        id: 'past',
        occurredAt: DateTime(2026, 7, 20, 18),
        createdAt: _now,
      ),
    );
    ProviderContainer container = _container(database);
    addTearDown(container.dispose);

    DailyCheckInState state = await container.read(
      dailyCheckInControllerProvider('2026-07-20').future,
    );

    expect(state.localDate, '2026-07-20');
    expect(state.recordedConsumptionCount, 1);
  });
}

/// Builds a container wired to [database] and a fixed clock.
///
/// Saving synchronizes the evening reminder, which reads the preferences.
ProviderContainer _container(AppDatabase database) => ProviderContainer(
  overrides: [
    appDatabaseProvider.overrideWithValue(database),
    appPreferencesProvider.overrideWithValue(
      AppPreferences(createTestPreferences()),
    ),
    appClockProvider.overrideWithValue(FixedAppClock(_now)),
    dailyCheckInNotificationGatewayProvider.overrideWithValue(
      FakeDailyCheckInNotificationGateway(),
    ),
  ],
);
