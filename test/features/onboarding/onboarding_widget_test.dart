import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/app.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/app/widgets/app_sheet.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/check_in/data/daily_check_in_notification_gateway.dart';
import 'package:stopcorn/features/onboarding/application/onboarding_controller.dart';
import 'package:stopcorn/features/onboarding/domain/onboarding_draft.dart';

import '../../helpers/fake_daily_check_in_notification_gateway.dart';
import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';

/// Runs onboarding flow widget tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  testWidgets('onboarding works end to end with enlarged text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.6;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(createTestPreferences());
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
    _expectScreen(tester, 'Reprendre le contrôle, sans jugement');

    Finder privacyLink = find.text('En savoir plus sur la confidentialité');
    await tester.ensureVisible(privacyLink);
    await tester.tap(privacyLink);
    await tester.pumpAndSettle();
    Finder sheet = find.byType(AppSheet);
    expect(sheet, findsOneWidget);
    expect(
      find.descendant(
        of: sheet,
        matching: find.byType(SingleChildScrollView),
      ),
      findsOneWidget,
    );
    ColoredBox sheetSurface = tester.widget<ColoredBox>(
      find.descendant(of: sheet, matching: find.byType(ColoredBox)).first,
    );
    expect(sheetSurface.color.a, 1);
    Finder closeSheetButton = find.text('Fermer');
    await tester.ensureVisible(closeSheetButton);
    await tester.tap(closeSheetButton);
    await tester.pumpAndSettle();

    State<StatefulWidget> progressState = tester.state(
      find.byType(FDeterminateProgress),
    );
    await _tapAndWait(tester, 'Commencer');
    _expectScreen(tester, "Qu'aimerais-tu changer ?");
    expect(
      tester.state<State<StatefulWidget>>(
        find.byType(FDeterminateProgress),
      ),
      same(progressState),
    );
    Finder goal = find.text("Observer d'abord");
    await tester.ensureVisible(goal);
    await tester.tap(goal);
    await tester.pump();

    await _tapAndWait(tester, 'Continuer');
    _expectScreen(tester, 'Ton point de départ');

    Finder frequencyField = find.descendant(
      of: find.byKey(const Key('baseline_frequency_field')),
      matching: find.byType(EditableText),
    );
    await tester.enterText(frequencyField, '12');
    await tester.pump();
    expect(tester.takeException(), isNull);
    OnboardingViewState onboarding = container
        .read(
          onboardingControllerProvider,
        )
        .requireValue;
    expect(onboarding.draft.baselineFrequency, 12);

    await _tapAndWait(tester, 'Continuer');
    _expectScreen(tester, 'Prépare ton plan de secours');
    Finder strategy = find.text('Marcher cinq minutes');
    await tester.ensureVisible(strategy);
    await tester.tap(strategy);
    await tester.pump();

    await _tapAndWait(tester, 'Continuer');
    _expectScreen(tester, 'Tes données restent sous ton contrôle');

    Finder reminder = find.byKey(
      const Key('onboarding_daily_check_in_reminder_switch'),
    );
    await tester.ensureVisible(reminder);
    await tester.tap(reminder);
    await tester.pump();

    await _tapAndWait(tester, 'Terminer la configuration');
    expect(
      find.byKey(const Key('home_urge_button')),
      findsOneWidget,
    );
    expect(await preferences.getOnboardingCompleted(), isTrue);
    expect(await preferences.getDailyCheckInReminderEnabled(), isTrue);
    expect(notificationGateway.permissionRequestCount, 1);
    expect(notificationGateway.scheduledRequests, isNotEmpty);
    expect(
      notificationGateway.scheduledRequests.last.firstOccurrence,
      DateTime(2026, 7, 28, 20),
    );
    expect(await database.select(database.goals).get(), hasLength(1));
    expect(tester.takeException(), isNull);
  });
}

/// Verifies that the onboarding screen titled [title] rendered safely.
void _expectScreen(WidgetTester tester, String title) {
  expect(tester.takeException(), isNull, reason: '$title screen');
  expect(find.text(title), findsOneWidget);
}

/// Taps the control labeled [label] and waits for persistence and navigation.
Future<void> _tapAndWait(WidgetTester tester, String label) async {
  Finder labelFinder = find.text(label);
  expect(labelFinder, findsOneWidget);
  Finder button = find.byKey(const Key('onboarding_primary_action'));
  await Scrollable.ensureVisible(
    tester.element(button),
    alignment: 0.5,
  );
  await tester.pumpAndSettle();
  await tester.tap(button.hitTestable());
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 100)),
  );
  await _pumpFrames(tester);
}

/// Advances enough frames for asynchronous test UI to settle.
Future<void> _pumpFrames(WidgetTester tester) async {
  for (int frame = 0; frame < 14; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
