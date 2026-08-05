import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/src/shared_preferences_async.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';

import '../../helpers/test_preferences.dart';

/// Runs application preference tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('the default values follow the product contract', () async {
    AppPreferences preferences = AppPreferences(createTestPreferences(locale: null));
    addTearDown(preferences.dispose);

    expect(await preferences.getOnboardingCompleted(), isFalse);
    expect(await preferences.getOnboardingCurrentStep(), 0);
    expect(await preferences.getThemeMode(), AppThemeMode.system);
    expect(await preferences.getLocale(), isNull);
    expect(await preferences.getShowHarvest(), isTrue);
    expect(await preferences.getDebugHarvestBonusPoints(), 0);
    expect(await preferences.getDebugShowSupportThanks(), isFalse);
    expect(await preferences.getSelectedStrategyIds(), isEmpty);
    expect(await preferences.getDailyCheckInReminderEnabled(), isFalse);
    expect(await preferences.getProgressPeriod(), '30d');
  });

  test('resetting does not touch foreign keys', () async {
    SharedPreferencesAsync store = createTestPreferences(
      initialValues: {'foreign_key': 'keep me'},
    );
    AppPreferences preferences = AppPreferences(store);
    addTearDown(preferences.dispose);

    await preferences.setOnboardingCompleted(true);
    await preferences.setThemeMode(AppThemeMode.dark);
    await preferences.setDebugHarvestBonusPoints(3);
    await preferences.setDebugShowSupportThanks(true);
    await preferences.clearStopCornData();

    expect(await preferences.getOnboardingCompleted(), isFalse);
    expect(await preferences.getThemeMode(), AppThemeMode.system);
    expect(await preferences.getDebugHarvestBonusPoints(), 0);
    expect(await preferences.getDebugShowSupportThanks(), isFalse);
    expect(await store.getString('foreign_key'), 'keep me');
  });

  test('persists the flow, theme, and backup plan', () async {
    AppPreferences preferences = AppPreferences(createTestPreferences());
    addTearDown(preferences.dispose);

    await preferences.setOnboardingCompleted(true);
    await preferences.setOnboardingCurrentStep(4);
    await preferences.setThemeMode(AppThemeMode.dark);
    await preferences.setDailyCheckInReminderEnabled(true);
    await preferences.setSelectedStrategyIds([
      'walk-five-minutes',
      'put-phone-away',
    ]);

    expect(await preferences.getOnboardingCompleted(), isTrue);
    expect(await preferences.getOnboardingCurrentStep(), 4);
    expect(await preferences.getThemeMode(), AppThemeMode.dark);
    expect(await preferences.getDailyCheckInReminderEnabled(), isTrue);
    expect(await preferences.getSelectedStrategyIds(), [
      'walk-five-minutes',
      'put-phone-away',
    ]);
  });
}
