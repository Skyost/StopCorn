import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/app.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/app/widgets/app_equal_height_row.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';

import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';
import '../../helpers/widget_scrolling.dart';

/// Runs progress screen widget tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  testWidgets('progress displays a descriptive empty state', (tester) async {
    await _openProgressScreen(tester);

    expect(find.text("Vue d'ensemble"), findsOneWidget);
    Finder empty = find.textContaining(
      'Pas encore assez de données. Quelques repères',
    );
    await scrollAppPageUntilVisible(tester, empty);
    expect(empty, findsOneWidget);
    Finder harvest = find.byKey(const Key('progress_harvest_card'));
    await scrollAppPageUntilVisible(tester, harvest);
    expect(harvest, findsOneWidget);
  });

  testWidgets('charts use ForUI colored progress indicators', (
    tester,
  ) async {
    await _openProgressScreen(tester, withEvent: true);

    Finder indicators = find.byType(FDeterminateProgress);
    await scrollAppPageUntilVisible(tester, indicators);
    expect(indicators, findsWidgets);
    FDeterminateProgress indicator = tester.widget(indicators.first);
    BuildContext indicatorContext = tester.element(indicators.first);
    FDeterminateProgressStyle style = indicator.style(
      indicatorContext.theme.determinateProgressStyle,
    );
    ShapeDecoration fillDecoration = style.fillDecoration as ShapeDecoration;
    expect(indicator.value, greaterThan(0));
    expect(fillDecoration.color, indicatorContext.theme.colors.primary);
  });

  testWidgets('each metric row uses the height of its tallest card', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(900, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await _openProgressScreen(tester);

    Finder first = find.byKey(const Key('progress_overview_metric_0'));
    Finder second = find.byKey(const Key('progress_overview_metric_1'));
    Finder third = find.byKey(const Key('progress_overview_metric_2'));
    Finder fourth = find.byKey(const Key('progress_overview_metric_3'));
    await scrollAppPageUntilVisible(tester, fourth);

    expect(find.byType(AppEqualHeightRow), findsWidgets);
    expect(
      tester.getSize(first).height,
      closeTo(tester.getSize(second).height, 0.01),
    );
    expect(
      tester.getSize(third).height,
      closeTo(tester.getSize(fourth).height, 0.01),
    );
  });

  testWidgets('compares the period with the baseline and opens its details', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.6;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await _openProgressScreen(
      tester,
      withInitialProfile: true,
    );

    Finder controlCard = find.byKey(
      const Key('progress_starting_point_control_card'),
    );
    Finder frequencyCard = find.byKey(
      const Key('progress_starting_point_frequency_card'),
    );
    await scrollAppPageUntilVisible(tester, controlCard);
    expect(controlCard, findsOneWidget);
    expect(frequencyCard, findsOneWidget);
    expect(
      find.descendant(
        of: controlCard,
        matching: find.byType(FDeterminateProgress),
      ),
      findsNWidgets(2),
    );
    expect(
      find.descendant(
        of: frequencyCard,
        matching: find.byType(FDeterminateProgress),
      ),
      findsNWidgets(2),
    );
    expect(
      find.descendant(of: controlCard, matching: find.text('Initiale')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: controlCard, matching: find.text('Finale')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: frequencyCard, matching: find.text('Initiale')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: frequencyCard, matching: find.text('Finale')),
      findsOneWidget,
    );

    Finder open = find.byKey(const Key('open_initial_profile_button'));
    await scrollAppPageUntilVisible(tester, open);
    await tester.tap(open);
    await _pumpFrames(tester);

    expect(find.text('Mon point de départ'), findsOneWidget);
    expect(find.text('Regain time'), findsOneWidget);
    expect(find.byKey(const Key('initial_profile_control')), findsOneWidget);
    expect(find.byKey(const Key('initial_profile_impact')), findsOneWidget);
    expect(find.byKey(const Key('initial_profile_confidence')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

/// Opens the progress screen with an optional recent event.
Future<void> _openProgressScreen(
  WidgetTester tester, {
  bool withEvent = false,
  bool withInitialProfile = false,
}) async {
  AppDatabase database = AppDatabase(NativeDatabase.memory());
  DateTime now = DateTime.utc(2026, 7, 28, 12);
  if (withEvent) {
    await database
        .into(database.consumptionEvents)
        .insert(
          ConsumptionEventsCompanion.insert(
            id: 'progress-screen-event',
            occurredAt: now,
            createdAt: now,
          ),
        );
  }
  if (withInitialProfile) {
    await database
        .into(database.goals)
        .insert(
          GoalsCompanion.insert(
            id: 'initial-goal',
            createdAt: DateTime.utc(2026, 7, 1),
            updatedAt: DateTime.utc(2026, 7, 1),
            type: GoalType.reduction.name,
            weeklyLimit: const Value<int?>(3),
            motivation: const Value<String?>('Regain time'),
            startedAt: DateTime.utc(2026, 7, 1),
          ),
        );
    await database
        .into(database.selfAssessments)
        .insert(
          SelfAssessmentsCompanion.insert(
            id: 'initial-assessment',
            recordedAt: DateTime.utc(2026, 7, 1),
            kind: AssessmentKind.baseline.name,
            weeklyFrequency: const Value<int?>(8),
            perceivedControl: 4,
            negativeImpact: 7,
            confidenceToChange: 6,
          ),
        );
    for (int index = 0; index < 5; index++) {
      String day = (24 + index).toString().padLeft(2, '0');
      await database
          .into(database.dailyCheckIns)
          .insert(
            DailyCheckInsCompanion.insert(
              localDate: '2026-07-$day',
              createdAt: now,
              updatedAt: now,
              moodScore: 6,
              controlScore: 6,
            ),
          );
    }
    await database
        .into(database.consumptionEvents)
        .insert(
          ConsumptionEventsCompanion.insert(
            id: 'comparison-event',
            occurredAt: now.subtract(const Duration(days: 2)),
            createdAt: now,
          ),
        );
  }
  AppPreferences preferences = AppPreferences(
    createTestPreferences(
      initialValues: {
        'onboarding_completed': true,
        'show_harvest': true,
      },
    ),
  );
  ProviderContainer container = ProviderContainer(
    overrides: [
      appDatabaseProvider.overrideWithValue(database),
      appPreferencesProvider.overrideWithValue(preferences),
      appClockProvider.overrideWithValue(
        FixedAppClock(now),
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

  await tester.tap(find.text('Progression'));
  await _pumpFrames(tester);
}

/// Advances enough frames for asynchronous test UI to settle.
Future<void> _pumpFrames(WidgetTester tester) async {
  for (int frame = 0; frame < 12; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
