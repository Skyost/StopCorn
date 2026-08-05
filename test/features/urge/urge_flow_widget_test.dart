import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/app.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/app/widgets/app_countdown.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/urge/application/urge_flow_controller.dart';
import 'package:stopcorn/features/urge/domain/urge_flow_state.dart';

import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';

/// Runs urge flow widget tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  testWidgets('an urge flow can be completed end to end', (
    tester,
  ) async {
    DateTime now = DateTime.now();
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(
      createTestPreferences(
        initialValues: {
          'onboarding_completed': true,
          'selected_strategy_ids': ['walk-five-minutes'],
        },
      ),
    );
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(FixedAppClock(now)),
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

    await tester.tap(find.byKey(const Key('home_urge_button')));
    await _pumpFrames(tester);
    expect(
      find.text(
        "Évalue-la sur 10. Il n'y a pas de mauvaise réponse : ce repère "
        'permettra de voir comment elle évolue.',
      ),
      findsOneWidget,
    );

    Finder continueAction = find.text('Continuer');
    await tester.ensureVisible(continueAction);
    await tester.tap(continueAction);
    await _pumpFrames(tester);
    expect(
      find.text("Qu'est-ce qui t'aiderait maintenant ?"),
      findsOneWidget,
    );
    expect(find.text('Pause guidée'), findsOneWidget);
    expect(find.text('Plan de secours'), findsOneWidget);
    expect(find.text('Autres idées'), findsOneWidget);

    await tester.tap(find.text('Plan de secours'));
    await _pumpFrames(tester);
    expect(
      find.text('Ton plan de secours'),
      findsOneWidget,
    );
    expect(find.text('Poser le téléphone hors de portée'), findsNothing);

    await tester.tap(find.text('Marcher cinq minutes'));
    await tester.pump();
    Finder launch = find.text('Je lance cette action');
    await tester.ensureVisible(launch);
    await tester.tap(launch);
    await _pumpFrames(tester);
    expect(find.byKey(const Key('strategy_countdown')), findsOneWidget);
    expect(find.byType(AppCountdown), findsOneWidget);
    expect(find.text('05:00'), findsOneWidget);
    expect(
      find.text(
        'Ce minuteur est seulement indicatif : tu peux terminer plus tôt ou '
        'prendre tout le temps dont tu as besoin.',
      ),
      findsOneWidget,
    );
    expect(find.byType(FDeterminateProgress), findsOneWidget);
    Finder reassess = find.text('Faire le point à nouveau');
    await tester.ensureVisible(reassess);
    await tester.tap(reassess);
    await _pumpFrames(tester);

    Finder reduced = find.text('Elle a diminué');
    expect(find.text('Je préfère arrêter le parcours ici'), findsNothing);
    await tester.ensureVisible(reduced);
    await tester.tap(reduced);
    await tester.pump();
    expect(
      container.read(urgeFlowControllerProvider).outcome,
      UrgeOutcome.reduced,
    );
    Finder finish = find.text('Terminer le parcours');
    await tester.ensureVisible(finish);
    await tester.tap(finish);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 80)),
    );
    await _pumpFrames(tester);

    expect(
      container.read(urgeFlowControllerProvider).step,
      UrgeFlowStep.completed,
    );
    expect(
      find.text('Tu as espacé ton envie et ton choix.'),
      findsOneWidget,
    );
    await _dismissHarvestReward(tester);
  });

  testWidgets(
    'a flow ending in consumption opens the journal and persists the event',
    (tester) async {
      DateTime now = DateTime.now();
      AppDatabase database = AppDatabase(NativeDatabase.memory());
      AppPreferences preferences = AppPreferences(
        createTestPreferences(
          initialValues: {
            'onboarding_completed': true,
            'selected_strategy_ids': ['walk-five-minutes'],
          },
        ),
      );
      ProviderContainer container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          appPreferencesProvider.overrideWithValue(preferences),
          appClockProvider.overrideWithValue(FixedAppClock(now)),
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

      await tester.tap(find.byKey(const Key('home_urge_button')));
      await _pumpFrames(tester);
      Finder continueAction = find.text('Continuer');
      await tester.ensureVisible(continueAction);
      await tester.tap(continueAction);
      await _pumpFrames(tester);
      await tester.tap(find.text('Autres idées'));
      await _pumpFrames(tester);
      expect(find.text('Marcher cinq minutes'), findsNothing);
      await tester.tap(find.text('Poser le téléphone hors de portée'));
      await tester.pump();

      Finder launch = find.text('Je lance cette action');
      await tester.ensureVisible(launch);
      await tester.tap(launch);
      await _pumpFrames(tester);
      Finder reassess = find.text('Faire le point à nouveau');
      await tester.ensureVisible(reassess);
      await tester.tap(reassess);
      await _pumpFrames(tester);

      Finder consumed = find.text('Je vais consommer');
      await tester.ensureVisible(consumed);
      await tester.tap(consumed);
      await tester.pump();
      Finder finish = find.text('Terminer le parcours');
      await tester.ensureVisible(finish);
      await tester.tap(finish);
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 80)),
      );
      await _pumpFrames(tester);

      expect(
        find.text("Cet événement n'efface pas tes progrès."),
        findsOneWidget,
      );
      await _dismissHarvestReward(tester);
      await tester.tap(find.text("Noter ce qui s'est passé"));
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 80)),
      );
      await _pumpFrames(tester);

      Finder save = find.byKey(const Key('save_consumption_button'));
      await tester.ensureVisible(save);
      await tester.tap(save);
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 80)),
      );
      await _pumpFrames(tester);

      expect(find.text("C'est enregistré."), findsOneWidget);
      expect(
        find.byKey(const Key('harvest_reward_dialog')),
        findsNothing,
      );
      List<ConsumptionEvent>? events = await tester.runAsync(
        () => database.select(database.consumptionEvents).get(),
      );
      expect(events, hasLength(1));
    },
  );
}

/// Closes the reward earned by the first constructive action of the day.
Future<void> _dismissHarvestReward(WidgetTester tester) async {
  expect(
    find.byKey(const Key('harvest_reward_dialog')),
    findsOneWidget,
  );
  await tester.tap(
    find.byKey(const Key('harvest_reward_close_button')),
  );
  await tester.pumpAndSettle();
}

/// Advances enough frames for asynchronous test UI to settle.
Future<void> _pumpFrames(WidgetTester tester) async {
  for (int frame = 0; frame < 12; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
