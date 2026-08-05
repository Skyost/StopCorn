import 'package:drift/drift.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/database/database_connection.dart';
import 'package:stopcorn/core/database/tables/app_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Goals,
    UrgeSessions,
    ConsumptionEvents,
    DailyCheckIns,
    SelfAssessments,
    CopingStrategies,
    CopingStrategyUses,
    ModuleProgress,
    OnboardingDrafts,
  ],
)
/// Drift database containing all local StopCorn history and relations.
final class AppDatabase extends _$AppDatabase {
  /// Opens the production database or uses an injected [executor] for tests.
  AppDatabase([QueryExecutor? executor]) : super(executor ?? openDatabaseConnection());

  @override
  int get schemaVersion => AppConstants.databaseSchemaVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Runs a minimal query so bootstrap failures surface before routing.
  Future<void> verifyConnection() async {
    await customSelect('SELECT 1').getSingle();
  }

  /// Inserts missing built-in strategies without changing existing records.
  Future<void> seedBuiltInStrategies(DateTime now) async {
    await transaction(() => _seedBuiltInStrategies(now.toUtc()));
  }

  /// Deletes every user-owned record and restores only built-in strategies.
  Future<void> deleteAllUserDataAndReseed(DateTime now) async {
    await transaction(() async {
      await delete(copingStrategyUses).go();
      await delete(urgeSessions).go();
      await delete(consumptionEvents).go();
      await delete(dailyCheckIns).go();
      await delete(selfAssessments).go();
      await delete(moduleProgress).go();
      await delete(onboardingDrafts).go();
      await delete(goals).go();
      await delete(copingStrategies).go();
      await _seedBuiltInStrategies(now.toUtc());
    });
  }

  /// Inserts every missing immutable built-in strategy.
  Future<void> _seedBuiltInStrategies(DateTime now) async {
    for (BuiltInStrategyDefinition strategy in builtInStrategies) {
      await into(copingStrategies).insert(
        CopingStrategiesCompanion.insert(
          id: strategy.id,
          titleKey: strategy.titleKey,
          descriptionKey: strategy.descriptionKey,
          kind: strategy.kind,
          isBuiltIn: true,
          createdAt: now,
        ),
        mode: InsertMode.insertOrIgnore,
      );
    }
  }
}

/// Immutable seed definition for one built-in coping strategy.
final class BuiltInStrategyDefinition {
  /// Stable strategy identifier persisted in relational records.
  final String id;

  /// Slang key used to resolve the localized title.
  final String titleKey;

  /// Slang key used to resolve the localized description.
  final String descriptionKey;

  /// General strategy category.
  final String kind;

  /// Optional suggested timer duration.
  final int? suggestedSeconds;

  /// Creates a strategy seed definition.
  const BuiltInStrategyDefinition({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.kind,
    required this.suggestedSeconds,
  });
}

/// Complete seed list inserted into a new or fully reset database.
const List<BuiltInStrategyDefinition> builtInStrategies = [
  BuiltInStrategyDefinition(
    id: 'put-phone-away',
    titleKey: 'strategy.putPhoneAway.title',
    descriptionKey: 'strategy.putPhoneAway.description',
    kind: 'environment',
    suggestedSeconds: 120,
  ),
  BuiltInStrategyDefinition(
    id: 'leave-room',
    titleKey: 'strategy.leaveRoom.title',
    descriptionKey: 'strategy.leaveRoom.description',
    kind: 'environment',
    suggestedSeconds: 120,
  ),
  BuiltInStrategyDefinition(
    id: 'walk-five-minutes',
    titleKey: 'strategy.walk.title',
    descriptionKey: 'strategy.walk.description',
    kind: 'movement',
    suggestedSeconds: 300,
  ),
  BuiltInStrategyDefinition(
    id: 'slow-breathing',
    titleKey: 'strategy.breathe.title',
    descriptionKey: 'strategy.breathe.description',
    kind: 'breathing',
    suggestedSeconds: 90,
  ),
  BuiltInStrategyDefinition(
    id: 'water-and-switch',
    titleKey: 'strategy.water.title',
    descriptionKey: 'strategy.water.description',
    kind: 'switch',
    suggestedSeconds: 120,
  ),
  BuiltInStrategyDefinition(
    id: 'message-someone',
    titleKey: 'strategy.message.title',
    descriptionKey: 'strategy.message.description',
    kind: 'connection',
    suggestedSeconds: null,
  ),
  BuiltInStrategyDefinition(
    id: 'two-minute-task',
    titleKey: 'strategy.task.title',
    descriptionKey: 'strategy.task.description',
    kind: 'task',
    suggestedSeconds: 120,
  ),
  BuiltInStrategyDefinition(
    id: 'take-shower',
    titleKey: 'strategy.shower.title',
    descriptionKey: 'strategy.shower.description',
    kind: 'environment',
    suggestedSeconds: null,
  ),
  BuiltInStrategyDefinition(
    id: 'wait-ten-minutes',
    titleKey: 'strategy.wait.title',
    descriptionKey: 'strategy.wait.description',
    kind: 'delay',
    suggestedSeconds: 600,
  ),
];
