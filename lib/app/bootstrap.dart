import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/features/check_in/application/daily_check_in_reminder_service.dart';
import 'package:stopcorn/features/learning/data/learning_repository.dart';
import 'package:stopcorn/features/urge/data/coping_strategy_repository.dart';

part 'bootstrap.g.dart';

/// Minimal persisted state needed before routing can begin.
final class BootstrapData {
  /// Whether the initial setup has been completed.
  final bool onboardingCompleted;

  /// Zero-based onboarding step to restore after an interrupted setup.
  final int onboardingCurrentStep;

  /// Creates the bootstrap routing state.
  const BootstrapData({
    required this.onboardingCompleted,
    required this.onboardingCurrentStep,
  });
}

/// Verifies local resources and prepares seed data before the first route.
@Riverpod(keepAlive: true)
final class BootstrapController extends _$BootstrapController {
  @override
  Future<BootstrapData> build() async {
    AppDatabase database = ref.watch(appDatabaseProvider);
    AppPreferences preferences = ref.watch(appPreferencesProvider);

    await database.verifyConnection();
    await ref.watch(copingStrategyRepositoryProvider).seedBuiltIns(ref.watch(appClockProvider).now());
    await ref.watch(learningRepositoryProvider).loadCatalog();
    await ref.watch(dailyCheckInReminderServiceProvider).synchronize();

    return BootstrapData(
      onboardingCompleted: await preferences.getOnboardingCompleted(),
      onboardingCurrentStep: await preferences.getOnboardingCurrentStep(),
    );
  }

  /// Invalidates a failed bootstrap so it can be attempted again.
  void retry() => ref.invalidateSelf();
}
