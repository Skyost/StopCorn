import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/current_app_day_provider.dart';
import 'package:stopcorn/features/progress/data/progress_repository.dart';
import 'package:stopcorn/features/progress/domain/initial_profile.dart';
import 'package:stopcorn/features/progress/domain/progress_dashboard.dart';
import 'package:stopcorn/features/progress/domain/progress_period.dart';

part 'progress_dashboard_provider.g.dart';

/// Loads and persists the progress period selected by the user.
@riverpod
final class ProgressPeriodController extends _$ProgressPeriodController {
  @override
  Future<ProgressPeriod> build() async {
    String stored = await ref.read(appPreferencesProvider).getProgressPeriod();
    return ProgressPeriod.fromStorage(stored);
  }

  /// Applies [period] optimistically and rolls back if persistence fails.
  Future<void> select(ProgressPeriod period) async {
    if (state.value == period) {
      return;
    }
    AsyncValue<ProgressPeriod> previous = state;
    state = AsyncData(period);
    try {
      await ref.read(appPreferencesProvider).setProgressPeriod(period.storageKey);
    } catch (error, stackTrace) {
      state = previous;
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}

/// Watches the progress dashboard for the selected period.
@riverpod
Stream<ProgressDashboard> progressDashboard(Ref ref) async* {
  ref.watch(currentAppDayProvider);
  Future<ProgressPeriod> periodFuture = ref.watch(progressPeriodControllerProvider.future);
  ProgressRepository repository = ref.watch(progressRepositoryProvider);
  DateTime now = ref.watch(appClockProvider).now();
  ProgressPeriod period = await periodFuture;
  yield* repository.watchDashboard(
    period: period,
    now: now,
  );
}

/// Watches the durable answers recorded at the end of onboarding.
@riverpod
Stream<InitialProfile?> initialProfile(Ref ref) => ref.watch(progressRepositoryProvider).watchInitialProfile();
