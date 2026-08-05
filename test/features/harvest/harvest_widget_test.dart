import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/app.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_sheet.dart';
import 'package:stopcorn/app/widgets/corn_brand_mark.dart';
import 'package:stopcorn/app/widgets/flame_icon.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/harvest/presentation/harvest_tile.dart';

import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';
import '../../helpers/widget_scrolling.dart';

/// Runs optional harvest presentation tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  testWidgets(
    'harvest displays its momentum, week, and rules',
    (tester) async {
      DateTime now = DateTime.utc(2026, 7, 29, 12);
      AppDatabase database = AppDatabase(NativeDatabase.memory());
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
          appClockProvider.overrideWithValue(FixedAppClock(now)),
        ],
      );
      addTearDown(() async {
        container.dispose();
        await preferences.dispose();
        await database.close();
      });
      await database
          .into(database.goals)
          .insert(
            GoalsCompanion.insert(
              id: 'goal',
              createdAt: now,
              updatedAt: now,
              type: GoalType.observation.name,
              startedAt: now,
            ),
          );
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

      Finder harvest = find.byType(HarvestTile);
      expect(harvest, findsOneWidget);
      Finder flame = find.descendant(
        of: harvest,
        matching: find.byType(FlameIcon),
      );
      Finder kernel = find.descendant(
        of: harvest,
        matching: find.byType(CornKernelIcon),
      );
      expect(flame, findsOneWidget);
      expect(kernel, findsOneWidget);
      expect(tester.getSize(flame).width, tester.getSize(kernel).width);
      expect(find.text('Corn points'), findsOneWidget);
      expect(find.text('Le corn point du jour a été collecté.'), findsOneWidget);
      Finder information = find.text("C'est quoi ?");
      Finder informationButton = find.ancestor(
        of: information,
        matching: find.byType(AppButton),
      );
      expect(
        tester.getSize(informationButton).width,
        lessThan(tester.getSize(harvest).width),
      );
      expect(
        tester.getTopRight(informationButton).dx,
        closeTo(tester.getTopRight(harvest).dx, 0.01),
      );

      Finder headerButton = find.byKey(const Key('harvest_header_button'));
      expect(headerButton, findsOneWidget);
      expect(
        find.descendant(
          of: headerButton,
          matching: find.byType(CornKernelIcon),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: headerButton,
          matching: find.byType(FlameIcon),
        ),
        findsOneWidget,
      );
      await tester.tap(headerButton);
      await tester.pumpAndSettle();

      Finder summaryDialog = find.byKey(const Key('harvest_summary_dialog'));
      expect(summaryDialog, findsOneWidget);
      expect(
        find.descendant(
          of: summaryDialog,
          matching: find.byKey(const Key('harvest_tile_corn_points')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: summaryDialog,
          matching: find.text("C'est quoi ?"),
        ),
        findsOneWidget,
      );
      await tester.tap(
        find.byKey(const Key('harvest_summary_information_button')),
      );
      await tester.pumpAndSettle();
      expect(summaryDialog, findsNothing);

      Finder headerSheet = find.byType(AppSheet);
      expect(headerSheet, findsOneWidget);
      Finder headerSheetClose = find.text('Fermer');
      await tester.ensureVisible(headerSheetClose);
      await tester.tap(headerSheetClose);
      await tester.pumpAndSettle();
      expect(headerSheet, findsNothing);

      await scrollAppPageUntilVisible(tester, information);
      await tester.tap(information);
      await tester.pumpAndSettle();

      Finder sheet = find.byType(AppSheet);
      Finder barrier = find.byType(FModalBarrier);
      Size screenSize = tester.view.physicalSize / tester.view.devicePixelRatio;
      expect(sheet, findsOneWidget);
      expect(barrier, findsOneWidget);
      expect(tester.getTopLeft(barrier), Offset.zero);
      expect(tester.getSize(barrier), screenSize);
      expect(
        find.text('Comment fonctionne la récolte ?'),
        findsOneWidget,
      );
      expect(
        find.textContaining("la sincérité n'est jamais pénalisée"),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: sheet,
          matching: find.byType(SingleChildScrollView),
        ),
        findsOneWidget,
      );

      Finder close = find.text('Fermer');
      await tester.ensureVisible(close);
      await tester.tap(close);
      await tester.pumpAndSettle();
      expect(sheet, findsNothing);

      await tester.tap(find.text('Progression'));
      await _pumpFrames(tester);
      await scrollAppPageUntilVisible(
        tester,
        find.byKey(const Key('harvest_week_day_7')),
      );

      List<double> weekdayPositions = [
        for (int weekday = DateTime.monday; weekday <= DateTime.sunday; weekday++)
          tester
              .getCenter(
                find.byKey(Key('harvest_week_day_$weekday')),
              )
              .dx,
      ];
      List<double> sortedPositions = weekdayPositions.toList()..sort();
      expect(weekdayPositions, orderedEquals(sortedPositions));
      Semantics upcomingThursday = tester.widget<Semantics>(
        find.byKey(
          const Key('harvest_week_day_4'),
        ),
      );
      expect(upcomingThursday.properties.label, 'Journée à venir');
    },
  );
}

/// Advances enough frames for asynchronous UI providers to settle.
Future<void> _pumpFrames(WidgetTester tester) async {
  for (int frame = 0; frame < 14; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
