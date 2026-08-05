import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/current_app_day_provider.dart';
import 'package:stopcorn/features/harvest/application/harvest_reward_service.dart';
import 'package:stopcorn/features/harvest/data/harvest_repository.dart';
import 'package:stopcorn/features/harvest/domain/harvest_summary.dart';

part 'harvest_providers.g.dart';

/// Watches the locally derived harvest for the current calendar day.
@riverpod
Stream<HarvestSummary> harvestSummary(Ref ref) {
  ref.watch(currentAppDayProvider);
  return ref.watch(harvestRepositoryProvider).watchSummary(ref.watch(appClockProvider).now());
}

/// Watches whether the optional harvest presentation is enabled.
@riverpod
Stream<bool> harvestVisibility(Ref ref) async* {
  AppPreferences preferences = ref.watch(appPreferencesProvider);
  yield await preferences.getShowHarvest();
  await for (void _ in preferences.changes) {
    yield await preferences.getShowHarvest();
  }
}

/// Provides reward detection around actions that may cultivate today.
@Riverpod(keepAlive: true)
HarvestRewardService harvestRewardService(Ref ref) => HarvestRewardService(
  ref.watch(appPreferencesProvider),
  ref.watch(harvestRepositoryProvider),
  ref.watch(appClockProvider),
);
