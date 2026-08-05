import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';

part 'coping_strategy_repository.g.dart';

/// Reads and seeds general coping strategies stored in Drift.
final class CopingStrategyRepository {
  /// Database used to query and seed strategies.
  final AppDatabase _database;

  /// Creates a repository backed by [database].
  const CopingStrategyRepository(this._database);

  /// Inserts missing built-in strategies.
  Future<void> seedBuiltIns(DateTime now) => _database.seedBuiltInStrategies(now);

  /// Loads enabled strategies in deterministic creation order.
  Future<List<CopingStrategy>> getEnabled() {
    SimpleSelectStatement<$CopingStrategiesTable, CopingStrategy> query = _database.select(_database.copingStrategies)
      ..where((strategy) => strategy.isEnabled.equals(true))
      ..orderBy(<OrderClauseGenerator<$CopingStrategiesTable>>[($CopingStrategiesTable strategy) => OrderingTerm.asc(strategy.createdAt)]);
    return query.get();
  }

  /// Watches enabled strategies in deterministic creation order.
  Stream<List<CopingStrategy>> watchEnabled() {
    SimpleSelectStatement<$CopingStrategiesTable, CopingStrategy> query = _database.select(_database.copingStrategies)
      ..where((strategy) => strategy.isEnabled.equals(true))
      ..orderBy(<OrderClauseGenerator<$CopingStrategiesTable>>[($CopingStrategiesTable strategy) => OrderingTerm.asc(strategy.createdAt)]);
    return query.watch();
  }
}

/// Provides the database-backed coping-strategy repository.
@Riverpod(keepAlive: true)
CopingStrategyRepository copingStrategyRepository(Ref ref) => CopingStrategyRepository(ref.watch(appDatabaseProvider));
