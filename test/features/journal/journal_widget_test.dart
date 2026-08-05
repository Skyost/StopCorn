import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/app/app.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/check_in/data/check_in_repository.dart';
import 'package:stopcorn/features/check_in/domain/daily_check_in_input.dart';
import 'package:stopcorn/features/consumption/data/consumption_repository.dart';
import 'package:stopcorn/features/consumption/domain/consumption_input.dart';
import 'package:stopcorn/features/urge/data/urge_repository.dart';

import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';
import '../../helpers/widget_scrolling.dart';

/// Runs combined journal widget tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  testWidgets('shows contexts and notes recorded from the home screen', (
    tester,
  ) async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(
      createTestPreferences(
        initialValues: {'onboarding_completed': true},
      ),
    );
    await ConsumptionRepository(database).add(
      ConsumptionInput(
        id: 'event-1',
        occurredAt: DateTime.utc(2026, 7, 28, 9),
        createdAt: DateTime.utc(2026, 7, 28, 9, 5),
        contextLabel: 'After a busy day',
        notes: 'A private, general note.',
      ),
    );
    await CheckInRepository(database).save(
      DailyCheckInInput(
        localDate: '2026-07-28',
        recordedAt: DateTime.utc(2026, 7, 28, 18),
        moodScore: 7,
        controlScore: 6,
        note: 'My private check-in.',
      ),
    );
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(
          FixedAppClock(DateTime.utc(2026, 7, 28, 20)),
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

    Finder openJournal = find.byKey(const Key('home_quick_journal'));
    await scrollAppPageUntilVisible(tester, openJournal);
    await tester.tap(openJournal);
    await _pumpFrames(tester);

    expect(find.text('Journal'), findsOneWidget);
    expect(
      find.text('After a busy day\nA private, general note.'),
      findsOneWidget,
    );
    expect(find.text('My private check-in.'), findsOneWidget);

    await tester.tap(find.byKey(const Key('journal_consumption_event-1')));
    await tester.pumpAndSettle();

    expect(find.text('After a busy day'), findsOneWidget);
    expect(find.text('A private, general note.'), findsOneWidget);
  });

  testWidgets('an incorrect entry can be deleted from the journal', (
    tester,
  ) async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(
      createTestPreferences(
        initialValues: {'onboarding_completed': true},
      ),
    );
    await ConsumptionRepository(database).add(
      ConsumptionInput(
        id: 'event-1',
        occurredAt: DateTime.utc(2026, 7, 28, 9),
        createdAt: DateTime.utc(2026, 7, 28, 9, 5),
        notes: 'A duplicate entry.',
      ),
    );
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(
          FixedAppClock(DateTime.utc(2026, 7, 28, 20)),
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

    Finder openJournal = find.byKey(const Key('home_quick_journal'));
    await scrollAppPageUntilVisible(tester, openJournal);
    await tester.tap(openJournal);
    await _pumpFrames(tester);

    await tester.tap(find.byKey(const Key('journal_consumption_event-1')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('journal_delete_consumption')));
    await tester.pumpAndSettle();

    // Deleting is irreversible, so it must never happen on a single tap.
    expect(
      await ConsumptionRepository(database).getById('event-1'),
      isNotNull,
    );

    await tester.tap(find.byKey(const Key('journal_confirm_delete')));
    await _pumpFrames(tester);
    await tester.pumpAndSettle();
    await _pumpFrames(tester);

    expect(await ConsumptionRepository(database).getById('event-1'), isNull);
    expect(find.text('A duplicate entry.'), findsNothing);
  });

  testWidgets('a support session recorded by mistake can be deleted', (
    tester,
  ) async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(
      createTestPreferences(
        initialValues: {'onboarding_completed': true},
      ),
    );
    UrgeRepository urges = UrgeRepository(database);
    await urges.createSession(
      id: 'urge-1',
      startedAt: DateTime.utc(2026, 7, 28, 10),
      initialIntensity: 8,
    );
    await urges.completeSession(
      sessionId: 'urge-1',
      completedAt: DateTime.utc(2026, 7, 28, 10, 10),
      finalIntensity: 3,
      outcome: UrgeOutcome.reduced,
      notes: 'A session started by mistake.',
    );
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(
          FixedAppClock(DateTime.utc(2026, 7, 28, 20)),
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

    Finder openJournal = find.byKey(const Key('home_quick_journal'));
    await scrollAppPageUntilVisible(tester, openJournal);
    await tester.tap(openJournal);
    await _pumpFrames(tester);

    await tester.tap(find.byKey(const Key('journal_urge_urge-1')));
    await tester.pumpAndSettle();

    // A finished session has no form to reopen, so only deletion is offered.
    expect(find.byKey(const Key('journal_edit_consumption')), findsNothing);

    await tester.tap(find.byKey(const Key('journal_delete_urge')));
    await tester.pumpAndSettle();

    expect(await urges.getById('urge-1'), isNotNull);

    await tester.tap(find.byKey(const Key('journal_confirm_delete')));
    await _pumpFrames(tester);
    await tester.pumpAndSettle();
    await _pumpFrames(tester);

    expect(await urges.getById('urge-1'), isNull);
    expect(find.text('A session started by mistake.'), findsNothing);
  });
}

/// Advances enough frames for asynchronous test UI to settle.
Future<void> _pumpFrames(WidgetTester tester) async {
  for (int frame = 0; frame < 12; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
