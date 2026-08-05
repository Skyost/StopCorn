import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/utils/local_date.dart';
import 'package:stopcorn/features/harvest/domain/harvest_summary.dart';

part 'harvest_repository.g.dart';

/// Derives a non-punitive harvest from actions already persisted locally.
final class HarvestRepository {
  /// Local relational store containing the constructive actions.
  final AppDatabase _database;

  /// Optional preferences containing points granted by debug tooling.
  final AppPreferences? _preferences;

  /// Creates a harvest repository backed by [database].
  const HarvestRepository(
    this._database, [
    this._preferences,
  ]);

  /// Watches harvest changes while anchoring calendar calculations to [now].
  Stream<HarvestSummary> watchSummary(DateTime now) => _database
      .customSelect(
        'SELECT 1 AS revision',
        readsFrom: {
          _database.goals,
          _database.urgeSessions,
          _database.consumptionEvents,
          _database.dailyCheckIns,
          _database.moduleProgress,
        },
      )
      .watch()
      .asyncMap((_) => loadSummary(now));

  /// Computes grains and momentum from unique constructive local days.
  Future<HarvestSummary> loadSummary(DateTime now) async {
    DateTime today = startOfLocalDay(now.toLocal());
    List<Goal> goals = await _database.select(_database.goals).get();
    List<UrgeSession> urges = await _database.select(_database.urgeSessions).get();
    List<ConsumptionEvent> events = await _database.select(_database.consumptionEvents).get();
    List<DailyCheckIn> checkIns = await _database.select(_database.dailyCheckIns).get();
    List<ModuleProgressData> modules = await _database.select(_database.moduleProgress).get();
    int bonusPoints = await _preferences?.getDebugHarvestBonusPoints() ?? 0;
    Set<String> cultivatedKeys = {};

    for (Goal goal in goals) {
      _addDay(cultivatedKeys, goal.createdAt, today);
    }
    for (UrgeSession urge in urges) {
      if (urge.outcome != null && urge.outcome != UrgeOutcome.abandoned.name) {
        _addDay(cultivatedKeys, urge.completedAt, today);
      }
    }
    for (ConsumptionEvent event in events) {
      _addDay(cultivatedKeys, event.createdAt, today);
    }
    for (DailyCheckIn checkIn in checkIns) {
      _addDay(cultivatedKeys, checkIn.createdAt, today);
    }
    for (ModuleProgressData module in modules) {
      _addDay(cultivatedKeys, module.completedAt, today);
    }

    List<DateTime> cultivatedDays = cultivatedKeys.map(DateTime.parse).toList()..sort();
    List<HarvestDay> recentDays = [];
    for (int offset = 6; offset >= 0; offset--) {
      DateTime day = addLocalDays(today, -offset);
      recentDays.add(
        HarvestDay(
          date: day,
          cultivated: cultivatedKeys.contains(localDateKey(day)),
        ),
      );
    }
    return HarvestSummary(
      grainCount: cultivatedKeys.length + bonusPoints,
      currentMomentum: _currentMomentum(cultivatedKeys, today),
      bestMomentum: _bestMomentum(cultivatedDays),
      recentDays: List<HarvestDay>.unmodifiable(recentDays),
    );
  }

  /// Adds [timestamp] as a cultivated local day when it is valid and not future.
  void _addDay(
    Set<String> target,
    DateTime? timestamp,
    DateTime today,
  ) {
    if (timestamp == null) {
      return;
    }
    DateTime day = startOfLocalDay(timestamp.toLocal());
    if (!day.isAfter(today)) {
      target.add(localDateKey(day));
    }
  }

  /// Counts momentum ending today, with the current day left as a grace period.
  int _currentMomentum(Set<String> cultivatedKeys, DateTime today) {
    DateTime cursor = today;
    if (!cultivatedKeys.contains(localDateKey(cursor))) {
      cursor = addLocalDays(cursor, -1);
    }
    int momentum = 0;
    while (cultivatedKeys.contains(localDateKey(cursor))) {
      momentum++;
      cursor = addLocalDays(cursor, -1);
    }
    return momentum;
  }

  /// Finds the longest consecutive run in sorted [cultivatedDays].
  int _bestMomentum(List<DateTime> cultivatedDays) {
    int best = 0;
    int running = 0;
    DateTime? previous;
    for (DateTime day in cultivatedDays) {
      running = previous != null && localDaysBetween(previous, day) == 1 ? running + 1 : 1;
      if (running > best) {
        best = running;
      }
      previous = day;
    }
    return best;
  }
}

/// Provides the database-backed harvest repository.
@Riverpod(keepAlive: true)
HarvestRepository harvestRepository(Ref ref) => HarvestRepository(
  ref.watch(appDatabaseProvider),
  ref.watch(appPreferencesProvider),
);
