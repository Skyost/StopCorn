import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/harvest/data/harvest_repository.dart';
import 'package:stopcorn/features/harvest/domain/harvest_reward.dart';
import 'package:stopcorn/features/harvest/domain/harvest_summary.dart';

/// Detects a newly earned harvest reward around a successful local action.
final class HarvestRewardService {
  /// Preferences controlling the optional harvest presentation.
  final AppPreferences _preferences;

  /// Repository deriving Corn points and momentum from persisted actions.
  final HarvestRepository _repository;

  /// Clock anchoring both harvest snapshots to their local calendar day.
  final AppClock _clock;

  /// Creates a reward detector from the harvest dependencies.
  const HarvestRewardService(
    this._preferences,
    this._repository,
    this._clock,
  );

  /// Runs [action] and reports a reward only when it persisted a new day.
  ///
  /// Harvest read failures never prevent the underlying action from running.
  Future<HarvestActionResult> run(
    Future<bool> Function() action, {
    HarvestRewardPolicy policy = .cultivatedDay,
  }) async {
    HarvestSummary? before = await _loadInitialSummary(policy);
    bool succeeded = await action();
    if (!succeeded || before == null) {
      return HarvestActionResult(succeeded: succeeded);
    }

    HarvestSummary? after = await _loadSummary();
    if (after == null || after.grainCount != before.grainCount + 1 || (policy == .cultivatedDay && (before.cultivatedToday || !after.cultivatedToday))) {
      return const HarvestActionResult(succeeded: true);
    }

    return HarvestActionResult(
      succeeded: true,
      reward: HarvestReward(
        pointsBefore: before.grainCount,
        pointsAfter: after.grainCount,
        momentumBefore: before.currentMomentum,
        momentumAfter: after.currentMomentum,
      ),
    );
  }

  /// Loads an initial snapshot using the visibility rule for [policy].
  Future<HarvestSummary?> _loadInitialSummary(
    HarvestRewardPolicy policy,
  ) async {
    try {
      if (policy == .cultivatedDay && !await _preferences.getShowHarvest()) {
        return null;
      }
      return await _repository.loadSummary(_clock.now());
    } catch (_) {
      return null;
    }
  }

  /// Loads a snapshot without allowing an optional celebration to fail a save.
  Future<HarvestSummary?> _loadSummary() async {
    try {
      return await _repository.loadSummary(_clock.now());
    } catch (_) {
      return null;
    }
  }
}
