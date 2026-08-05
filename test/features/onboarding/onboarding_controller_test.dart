import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/check_in/data/daily_check_in_notification_gateway.dart';
import 'package:stopcorn/features/onboarding/application/onboarding_controller.dart';
import 'package:stopcorn/features/onboarding/domain/onboarding_draft.dart';

import '../../helpers/fake_daily_check_in_notification_gateway.dart';
import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';

/// Runs onboarding controller tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  late AppDatabase database;
  late AppPreferences preferences;
  late ProviderContainer container;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    preferences = AppPreferences(createTestPreferences());
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

  test('completion creates the goal and initial assessment', () async {
    await container.read(onboardingControllerProvider.future);
    OnboardingController controller = container.read(onboardingControllerProvider.notifier);

    controller.selectGoal(GoalType.observation);
    controller.setBaselineFrequency(4);
    controller.setPerceivedControl(3);
    controller.setNegativeImpact(6);
    controller.setConfidenceToChange(7);
    controller.toggleStrategy('walk-five-minutes');

    expect(await controller.complete(), isTrue);
    expect(await preferences.getOnboardingCompleted(), isTrue);
    expect(await preferences.getSelectedStrategyIds(), [
      'walk-five-minutes',
    ]);

    List<Goal> goals = await database.select(database.goals).get();
    List<SelfAssessment> assessments = await database.select(database.selfAssessments).get();
    expect(goals, hasLength(1));
    expect(goals.single.type, GoalType.observation.name);
    expect(goals.single.isActive, isTrue);
    expect(assessments, hasLength(1));
    expect(assessments.single.kind, AssessmentKind.baseline.name);
    expect(assessments.single.weeklyFrequency, 4);
  });

  test('a draft resumes at the persisted step', () async {
    await container.read(onboardingControllerProvider.future);
    OnboardingController first = container.read(onboardingControllerProvider.notifier);
    first.selectGoal(GoalType.abstinence);
    expect(await first.saveAndMoveTo(3), isTrue);

    container.dispose();
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(
          FixedAppClock(DateTime.utc(2026, 7, 28, 12)),
        ),
      ],
    );

    OnboardingViewState resumed = await container.read(onboardingControllerProvider.future);
    expect(resumed.draft.currentStep, 3);
    expect(resumed.draft.goalType, GoalType.abstinence);
  });

  test('completion waits for reminder scheduling and can be retried', () async {
    FakeDailyCheckInNotificationGateway notificationGateway = FakeDailyCheckInNotificationGateway(failScheduling: true);
    container.dispose();
    container = ProviderContainer(
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
    await container.read(onboardingControllerProvider.future);
    OnboardingController controller = container.read(
      onboardingControllerProvider.notifier,
    );
    controller
      ..selectGoal(GoalType.observation)
      ..toggleStrategy('walk-five-minutes')
      ..setDailyCheckInReminderEnabled(true);

    expect(await controller.complete(), isFalse);
    expect(await preferences.getOnboardingCompleted(), isFalse);
    expect(await database.select(database.onboardingDrafts).get(), hasLength(1));
    expect(await database.select(database.goals).get(), hasLength(1));
    expect(await database.select(database.selfAssessments).get(), hasLength(1));

    notificationGateway.failScheduling = false;
    expect(await controller.complete(), isTrue);
    expect(await preferences.getOnboardingCompleted(), isTrue);
    expect(await database.select(database.onboardingDrafts).get(), isEmpty);
    expect(await database.select(database.goals).get(), hasLength(1));
    expect(notificationGateway.scheduledRequests, hasLength(1));
  });
}
