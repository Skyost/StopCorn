import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/app.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_equal_height_row.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';

import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';
import '../../helpers/widget_scrolling.dart';

/// Runs home urge-button widget tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  testWidgets('the urge button is visible without scrolling', (tester) async {
    await _pumpHome(tester);

    Finder button = find.byKey(const Key('home_urge_button'));
    expect(button, findsOneWidget);
    double bottom = tester.getBottomRight(button).dy;
    double viewportHeight = tester.view.physicalSize.height / tester.view.devicePixelRatio;
    expect(bottom, lessThan(viewportHeight));

    await tester.tap(button);
    await _pumpFrames(tester);
    expect(
      find.text(
        "Évalue-la sur 10. Il n'y a pas de mauvaise réponse : ce repère "
        'permettra de voir comment elle évolue.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('the next module is recommended and opens directly', (
    tester,
  ) async {
    await _pumpHome(tester);

    Finder cta = find.byKey(
      const Key('home_learning_recommendation_button'),
    );
    await scrollAppPageUntilVisible(tester, cta);
    expect(find.text('À découvrir'), findsOneWidget);
    expect(find.text('Pourquoi changer ?'), findsOneWidget);
    expect(
      find.text('Précise ce que tu aimerais retrouver ou préserver.'),
      findsOneWidget,
    );
    expect(find.text('Poursuivre la lecture'), findsOneWidget);
    expect(cta, findsOneWidget);
    AppButton button = tester.widget(cta);
    expect(button.variant, FButtonVariant.secondary);

    await tester.tap(cta);
    await _pumpFrames(tester);

    expect(
      find.byKey(const Key('module_primary_button')),
      findsOneWidget,
    );
  });

  testWidgets('metrics in the same row have equal height', (
    tester,
  ) async {
    await _pumpHome(tester);

    Finder days = find.byKey(const Key('home_metric_days_without'));
    Finder urges = find.byKey(const Key('home_metric_traversed_urges'));
    await scrollAppPageUntilVisible(tester, urges);

    expect(find.byType(AppEqualHeightRow), findsOneWidget);
    expect(
      tester.getSize(days).height,
      closeTo(tester.getSize(urges).height, 0.01),
    );
  });

  testWidgets('quick actions remain grouped in an FTileGroup', (
    tester,
  ) async {
    await _pumpHome(tester);

    Finder checkIn = find.byKey(const Key('home_quick_check_in'));
    Finder logConsumption = find.byKey(
      const Key('home_quick_log_consumption'),
    );
    Finder reviewPlan = find.byKey(const Key('home_quick_review_plan'));
    await scrollAppPageUntilVisible(tester, reviewPlan);
    Finder group = find.ancestor(
      of: checkIn,
      matching: find.byType(FTileGroup),
    );

    expect(group, findsOneWidget);
    expect(find.descendant(of: group, matching: logConsumption), findsOneWidget);
    expect(find.descendant(of: group, matching: reviewPlan), findsOneWidget);
  });
}

/// Creates an isolated application already routed to the loaded home screen.
Future<void> _pumpHome(WidgetTester tester) async {
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
}

/// Advances enough frames for asynchronous test UI to settle.
Future<void> _pumpFrames(WidgetTester tester) async {
  for (int frame = 0; frame < 12; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
