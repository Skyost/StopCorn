import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/app/router.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';

import '../helpers/test_database.dart';
import '../helpers/test_preferences.dart';

/// Runs routed back-navigation tests without assuming a previous page exists.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  testWidgets('direct detail routes fall back to their logical parent', (
    tester,
  ) async {
    _NavigationFixture fixture = await _NavigationFixture.create();
    addTearDown(() => fixture.disposeAfterUnmount(tester));
    await fixture.pump(tester);

    for (var (String location, String fallback) in <(String, String)>[
      (AppRoutes.urge, AppRoutes.home),
      (AppRoutes.journal, AppRoutes.home),
      (AppRoutes.logConsumption, AppRoutes.home),
      (AppRoutes.checkIn, AppRoutes.home),
      (AppRoutes.initialProfile, AppRoutes.progress),
      (AppRoutes.goalHistory, AppRoutes.settings),
      (AppRoutes.dataExport, AppRoutes.settings),
      (AppRoutes.licenses, AppRoutes.settings),
      (AppRoutes.module('why-change'), AppRoutes.learn),
    ]) {
      fixture.router.go(location);
      await _pumpFrames(tester);
      expect(fixture.location, Uri.parse(location).path);

      Finder back = find.byKey(const Key('app_page_back_button'));
      expect(back, findsOneWidget, reason: 'Missing back action on $location.');
      tester.widget<FHeaderAction>(back).onPress!();
      await _pumpFrames(tester);

      expect(fixture.location, fallback, reason: 'Wrong fallback from $location.');
      expect(tester.takeException(), isNull, reason: 'Back failed from $location.');
    }

    for (var (String name, String location, Key actionKey, String fallback) in <(String, String, Key, String)>[
      (
        'urge',
        AppRoutes.urge,
        const Key('urge_back_home_button'),
        AppRoutes.home,
      ),
      (
        'consumption',
        AppRoutes.logConsumption,
        const Key('log_consumption_cancel_button'),
        AppRoutes.home,
      ),
      (
        'check-in',
        AppRoutes.checkIn,
        const Key('check_in_cancel_button'),
        AppRoutes.home,
      ),
      (
        'export',
        AppRoutes.dataExport,
        const Key('data_export_back_button'),
        AppRoutes.settings,
      ),
    ]) {
      fixture.router.go(location);
      await _pumpFrames(tester);
      Finder action = find.byKey(actionKey);
      expect(action, findsOneWidget, reason: 'Missing secondary action on $name.');
      tester.widget<AppButton>(action).onPress!();
      await _pumpFrames(tester);

      expect(fixture.location, fallback, reason: 'Wrong secondary fallback on $name.');
      expect(tester.takeException(), isNull, reason: 'Secondary exit failed on $name.');
    }

    fixture.router.go(AppRoutes.settings);
    await _pumpFrames(tester);
    fixture.router.push<void>(AppRoutes.checkIn);
    await _pumpFrames(tester);

    Finder back = find.byKey(const Key('app_page_back_button'));
    tester.widget<FHeaderAction>(back).onPress!();
    await _pumpFrames(tester);

    expect(fixture.location, AppRoutes.settings);
    expect(tester.takeException(), isNull);
  });
}

/// Owns a routed application with completed onboarding.
final class _NavigationFixture {
  /// In-memory application database.
  final AppDatabase database;

  /// Isolated application preferences.
  final AppPreferences preferences;

  /// Provider container owning the router.
  final ProviderContainer container;

  /// Creates a fixture from its isolated dependencies.
  const _NavigationFixture(
    this.database,
    this.preferences,
    this.container,
  );

  /// Creates a fully bootstrapped navigation fixture.
  static Future<_NavigationFixture> create() async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(
      createTestPreferences(
        initialValues: {'onboarding_completed': true},
      ),
    );
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(
          FixedAppClock(DateTime.utc(2026, 7, 28, 12)),
        ),
      ],
    );
    await container.read(bootstrapControllerProvider.future);
    return _NavigationFixture(database, preferences, container);
  }

  /// Application router under test.
  GoRouter get router => container.read(appRouterProvider);

  /// Current path exposed by the router.
  String get location => router.routeInformationProvider.value.uri.path;

  /// Renders the routed application.
  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const StopCornApp(),
      ),
    );
    await _pumpFrames(tester);
  }

  /// Unmounts the application before releasing every owned dependency.
  Future<void> disposeAfterUnmount(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
    await preferences.dispose();
    await database.close();
  }
}

/// Advances enough frames for routing and asynchronous providers to settle.
Future<void> _pumpFrames(WidgetTester tester) async {
  for (int frame = 0; frame < 14; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
