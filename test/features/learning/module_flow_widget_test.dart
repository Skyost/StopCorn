import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_sheet.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';

import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';
import '../../helpers/widget_scrolling.dart';

/// Runs learning module flow widget tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  testWidgets('a module can be read and completed end to end', (
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

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const StopCornApp(),
      ),
    );
    await _pumpFrames(tester);
    expect(tester.takeException(), isNull, reason: 'home screen');

    await tester.tap(find.text('Apprendre'));
    await _pumpFrames(tester);
    expect(tester.takeException(), isNull, reason: 'module catalog');
    expect(
      find.byKey(const Key('learning_module_why-change')),
      findsOneWidget,
    );

    Finder firstModule = find.byKey(const Key('learning_module_why-change'));
    Finder lastModule = find.byKey(
      const Key('learning_module_continue-after-setback'),
    );
    Finder evidence = find.byKey(const Key('learning_evidence_button'));
    await scrollAppPageUntilVisible(tester, evidence);
    AppButton evidenceButton = tester.widget(evidence);
    expect(evidenceButton.variant, FButtonVariant.ghost);
    expect(
      tester.getTopLeft(evidence).dy,
      greaterThan(tester.getTopLeft(lastModule).dy),
    );

    await tester.tap(evidence);
    await _pumpFrames(tester);
    expect(find.byType(AppSheet), findsOneWidget);
    expect(
      find.text('Sources et limites'),
      findsOneWidget,
    );
    await tester.tap(find.text('Fermer'));
    await _pumpFrames(tester);

    await scrollAppPageUntilVisible(tester, firstModule, delta: -400);
    await tester.tap(firstModule);
    await _waitForPersistence(tester);
    expect(tester.takeException(), isNull, reason: 'first section');
    expect(find.text('Une direction qui vient de toi'), findsOneWidget);
    _expectReadingProgress(tester, 1 / 3);

    Finder sources = find.byKey(const Key('module_sources_tile'));
    await tester.ensureVisible(sources);
    await tester.tap(sources);
    await _pumpFrames(tester);
    expect(find.text('Sources scientifiques'), findsOneWidget);
    expect(
      find.text('https://pubmed.ncbi.nlm.nih.gov/26168470/'),
      findsOneWidget,
    );
    await tester.tap(find.text('Fermer'));
    await _pumpFrames(tester);

    Finder next = find.byKey(const Key('module_primary_button'));
    await tester.ensureVisible(next);
    await tester.tap(next);
    await _waitForPersistence(tester);
    _expectReadingProgress(tester, 2 / 3);

    GoRouter.of(tester.element(next)).pop();
    await _pumpFrames(tester);
    expect(firstModule, findsOneWidget);
    _expectReadingProgress(tester, 2 / 3);

    await scrollAppPageUntilVisible(tester, firstModule, delta: -400);
    await tester.tap(firstModule);
    await _waitForPersistence(tester);
    _expectReadingProgress(tester, 2 / 3);

    next = find.byKey(const Key('module_primary_button'));
    await tester.ensureVisible(next);
    await tester.tap(next);
    await _waitForPersistence(tester);
    _expectReadingProgress(tester, 1);

    await tester.ensureVisible(next);
    await tester.tap(next);
    await _waitForPersistence(tester);
    _expectReadingProgress(tester, 1);
    expect(find.text('Réflexion facultative'), findsOneWidget);

    Finder complete = find.byKey(const Key('module_primary_button'));
    await tester.ensureVisible(complete);
    await tester.tap(complete);
    await _waitForPersistence(tester);

    expect(find.text('Module terminé'), findsOneWidget);
    List<ModuleProgressData> progress = await database.select(database.moduleProgress).get();
    expect(progress, hasLength(1));
    expect(progress.single.completedAt, isNotNull);

    expect(
      find.byKey(const Key('harvest_reward_dialog')),
      findsOneWidget,
    );
    await tester.tap(
      find.byKey(const Key('harvest_reward_close_button')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('module_restart_button')));
    await _waitForPersistence(tester);
    expect(find.text('Une direction qui vient de toi'), findsOneWidget);
    progress = await database.select(database.moduleProgress).get();
    expect(progress.single.completedAt, isNotNull);
    expect(progress.single.isReviewing, isTrue);
    expect(progress.single.lastSectionIndex, 0);
  });
}

/// Verifies the single visible reading indicator against [expected].
void _expectReadingProgress(
  WidgetTester tester,
  double expected,
) {
  Finder indicator = find.byType(FDeterminateProgress);
  expect(indicator, findsOneWidget);
  FDeterminateProgress progress = tester.widget(indicator);
  expect(progress.value, closeTo(expected, 0.001));
}

/// Waits for local persistence and then settles the widget tree.
Future<void> _waitForPersistence(WidgetTester tester) async {
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 80)),
  );
  await _pumpFrames(tester);
}

/// Advances enough frames for asynchronous test UI to settle.
Future<void> _pumpFrames(WidgetTester tester) async {
  for (int frame = 0; frame < 12; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
