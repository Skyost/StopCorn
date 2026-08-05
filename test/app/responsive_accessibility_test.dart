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

import '../helpers/test_database.dart';
import '../helpers/test_preferences.dart';

/// Runs responsive layout and accessibility tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  testWidgets(
    'the main screens remain usable on a narrow phone with enlarged text',
    (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 1.6;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

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
      _expectNoLayoutError(tester, 'accueil');

      for (String destination in [
        'Progression',
        'Apprendre',
        'Réglages',
      ]) {
        await tester.tap(find.text(destination));
        await _pumpFrames(tester);
        _expectNoLayoutError(tester, destination);
      }
    },
  );

  testWidgets('the primary action exposes an explicit semantic label', (
    tester,
  ) async {
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
    addTearDown(() async {
      container.dispose();
      await preferences.dispose();
      await database.close();
    });
    await tester.runAsync(
      () => container.read(bootstrapControllerProvider.future),
    );
    SemanticsHandle semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const StopCornApp(),
      ),
    );
    await _pumpFrames(tester);

    Finder label = find.bySemanticsLabel(
      "J'ai envie de consulter du contenu, faire une pause",
    );
    expect(label, findsOneWidget);
    expect(
      tester.getSemantics(label).label,
      "J'ai envie de consulter du contenu, faire une pause",
    );
    semantics.dispose();
  });
}

/// Verifies that [screen] rendered without a framework layout exception.
void _expectNoLayoutError(WidgetTester tester, String screen) {
  expect(
    tester.takeException(),
    isNull,
    reason: 'no overflow expected on the $screen screen',
  );
}

/// Advances enough frames for asynchronous test UI to settle.
Future<void> _pumpFrames(WidgetTester tester) async {
  for (int frame = 0; frame < 12; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
