import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/app/app.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/check_in/data/daily_check_in_notification_gateway.dart';

import '../../helpers/fake_daily_check_in_notification_gateway.dart';
import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';
import '../../helpers/widget_scrolling.dart';

/// Runs daily check-in widget tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  testWidgets('the daily check-in is saved from the home screen', (
    tester,
  ) async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(
      createTestPreferences(
        initialValues: {
          'onboarding_completed': true,
          'daily_check_in_reminder_enabled': true,
        },
      ),
    );
    FakeDailyCheckInNotificationGateway notificationGateway = FakeDailyCheckInNotificationGateway();
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(
          FixedAppClock(DateTime.utc(2026, 7, 28, 12)),
        ),
        dailyCheckInNotificationGatewayProvider.overrideWithValue(
          notificationGateway,
        ),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await preferences.dispose();
      await database.close();
    });
    await tester.runAsync(
      () => container.read(bootstrapControllerProvider.future),
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const StopCornApp(),
      ),
    );
    await _pumpFrames(tester);

    Finder open = find.byKey(const Key('home_quick_check_in'));
    await scrollAppPageUntilVisible(tester, open);
    await tester.tap(open);
    await _pumpFrames(tester);
    expect(find.text('Bilan du jour'), findsOneWidget);

    Finder save = find.byKey(const Key('save_check_in_button'));
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 80)),
    );
    await _pumpFrames(tester);

    expect(find.text('Bilan enregistré.'), findsOneWidget);
    expect(
      find.byKey(const Key('harvest_reward_dialog')),
      findsOneWidget,
    );
    expect(find.text('Corn point récolté !'), findsOneWidget);
    expect(
      tester
          .widget<Text>(
            find.byKey(const Key('harvest_reward_points_value')),
          )
          .data,
      '1',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(const Key('harvest_reward_momentum_value')),
          )
          .data,
      '1',
    );
    await tester.tap(
      find.byKey(const Key('harvest_reward_close_button')),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('harvest_reward_dialog')),
      findsNothing,
    );
    List<DailyCheckIn> checkIns = await database.select(database.dailyCheckIns).get();
    expect(checkIns, hasLength(1));
    expect(notificationGateway.scheduledRequests, hasLength(2));
    expect(
      notificationGateway.scheduledRequests.last.firstOccurrence,
      DateTime(2026, 7, 29, 20),
    );
  });

  testWidgets('a consumption can be recorded from the check-in', (
    tester,
  ) async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(
      createTestPreferences(
        initialValues: {
          'onboarding_completed': true,
        },
      ),
    );
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(
          FixedAppClock(DateTime(2026, 7, 28, 12)),
        ),
        dailyCheckInNotificationGatewayProvider.overrideWithValue(
          FakeDailyCheckInNotificationGateway(),
        ),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await preferences.dispose();
      await database.close();
    });
    await tester.runAsync(
      () => container.read(bootstrapControllerProvider.future),
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const StopCornApp(),
      ),
    );
    await _pumpFrames(tester);

    Finder openCheckIn = find.byKey(const Key('home_quick_check_in'));
    await scrollAppPageUntilVisible(tester, openCheckIn);
    await tester.tap(openCheckIn);
    await _pumpFrames(tester);

    expect(
      find.text('Aucune consommation enregistrée ce jour-là.'),
      findsOneWidget,
    );
    Finder openConsumption = find.byKey(
      const Key('check_in_log_consumption'),
    );
    await tester.ensureVisible(openConsumption);
    await tester.tap(openConsumption);
    await _pumpFrames(tester);

    Finder saveConsumption = find.byKey(
      const Key('save_consumption_button'),
    );
    await tester.ensureVisible(saveConsumption);
    await tester.tap(saveConsumption);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 80)),
    );
    await _pumpFrames(tester);

    await tester.tap(
      find.byKey(const Key('harvest_reward_close_button')),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('1 consommation enregistrée ce jour-là.'),
      findsOneWidget,
    );
    List<ConsumptionEvent> events = await database.select(database.consumptionEvents).get();
    expect(events, hasLength(1));
    expect(events.single.occurredAt.toLocal(), DateTime(2026, 7, 28, 12));
    expect(await database.select(database.dailyCheckIns).get(), isEmpty);
  });
}

/// Advances enough frames for asynchronous test UI to settle.
Future<void> _pumpFrames(WidgetTester tester) async {
  for (int frame = 0; frame < 12; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
