import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/urge/application/urge_flow_controller.dart';
import 'package:stopcorn/features/urge/domain/urge_flow_state.dart';

import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';

/// Runs urge flow controller tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  late AppDatabase database;
  late AppPreferences preferences;
  late ProviderContainer container;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    preferences = AppPreferences(createTestPreferences());
    await database.seedBuiltInStrategies(DateTime.utc(2026, 7, 28, 12));
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(
          FixedAppClock(DateTime.utc(2026, 7, 28, 12)),
        ),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await preferences.dispose();
    await database.close();
  });

  test('the complete flow persists a decrease', () async {
    UrgeFlowController controller = container.read(
      urgeFlowControllerProvider.notifier,
    );

    controller.setInitialIntensity(8);
    controller.setTrigger(TriggerType.stress);
    expect(await controller.startSession(), isTrue);
    expect(
      container.read(urgeFlowControllerProvider).step,
      UrgeFlowStep.supportChoice,
    );
    expect(controller.chooseSupportPath(.backupPlan), isTrue);
    controller.chooseStrategy('walk-five-minutes');
    expect(await controller.selectStrategy('walk-five-minutes'), isTrue);
    controller.moveToReassessment();
    controller.setFinalIntensity(3);
    controller.setOutcome(UrgeOutcome.reduced);
    controller.setStrategyEffect(4);
    expect(await controller.completeSession(), isTrue);

    expect(
      container.read(urgeFlowControllerProvider).step,
      UrgeFlowStep.completed,
    );
    List<UrgeSession> sessions = await database.select(database.urgeSessions).get();
    expect(sessions, hasLength(1));
    expect(sessions.single.finalIntensity, 3);
    expect(sessions.single.outcome, UrgeOutcome.reduced.name);
  });

  test('the guided pause leads directly to the outcome', () async {
    UrgeFlowController controller = container.read(
      urgeFlowControllerProvider.notifier,
    );

    expect(await controller.startSession(), isTrue);
    expect(controller.chooseSupportPath(.guidedPause), isTrue);
    expect(
      container.read(urgeFlowControllerProvider).step,
      UrgeFlowStep.pause,
    );

    controller.finishPause(42);

    UrgeFlowState state = container.read(urgeFlowControllerProvider);
    expect(state.step, UrgeFlowStep.reassessment);
    expect(state.pauseDurationSeconds, 42);
    expect(state.strategyUseId, isNull);
  });
}
