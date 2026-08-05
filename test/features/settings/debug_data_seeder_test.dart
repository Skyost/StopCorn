import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/utils/local_date.dart';
import 'package:stopcorn/features/settings/data/debug_data_seeder.dart';

import '../../helpers/test_database.dart';

/// Runs debug sample-data seeder tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  test('loading is idempotent and preserves existing data', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    DateTime now = DateTime.utc(2026, 7, 30, 12);
    DateTime userCheckInAt = DateTime.utc(2026, 7, 30, 8);
    await database
        .into(database.consumptionEvents)
        .insert(
          ConsumptionEventsCompanion.insert(
            id: 'user-event',
            occurredAt: now,
            createdAt: now,
          ),
        );
    await database
        .into(database.dailyCheckIns)
        .insert(
          DailyCheckInsCompanion.insert(
            localDate: localDateKey(userCheckInAt.toLocal()),
            createdAt: userCheckInAt,
            updatedAt: userCheckInAt,
            moodScore: 9,
            controlScore: 8,
            note: const Value('Personal data'),
          ),
        );
    await database
        .into(database.moduleProgress)
        .insert(
          ModuleProgressCompanion.insert(
            moduleId: 'why-change',
            startedAt: Value(now),
            completedAt: Value(now),
            lastSectionIndex: const Value(2),
            reflectionText: const Value('Personal reflection'),
            updatedAt: now,
          ),
        );

    DebugDataSeeder seeder = DebugDataSeeder(database);
    await seeder.seed(now);

    List<ConsumptionEvent> events = await database.select(database.consumptionEvents).get();
    List<UrgeSession> urges = await database.select(database.urgeSessions).get();
    List<CopingStrategyUse> strategyUses = await database.select(database.copingStrategyUses).get();
    List<DailyCheckIn> checkIns = await database.select(database.dailyCheckIns).get();
    List<SelfAssessment> assessments = await database.select(database.selfAssessments).get();
    List<ModuleProgressData> modules = await database.select(database.moduleProgress).get();
    expect(events.where((event) => event.id == 'user-event'), hasLength(1));
    expect(
      events.where((event) => event.id.startsWith('debug-sample-')),
      hasLength(15),
    );
    ConsumptionEvent sampleEvent = events.firstWhere(
      (event) => event.id.startsWith('debug-sample-'),
    );
    expect(sampleEvent.contextLabel, isNotEmpty);
    expect(sampleEvent.notes, isNotEmpty);
    expect(urges, hasLength(12));
    expect(strategyUses, hasLength(12));
    expect(checkIns, hasLength(12));
    // Only a baseline: the application never records follow-up assessments,
    // so the sample data must not invent any either.
    expect(assessments, hasLength(1));
    expect(assessments.single.kind, AssessmentKind.baseline.name);
    expect(modules, hasLength(3));
    expect(
      checkIns
          .singleWhere(
            (checkIn) => checkIn.localDate == localDateKey(userCheckInAt.toLocal()),
          )
          .note,
      'Personal data',
    );
    expect(
      modules.singleWhere((module) => module.moduleId == 'why-change').reflectionText,
      'Personal reflection',
    );
    Goal debugGoal = await (database.select(
      database.goals,
    )..where((goal) => goal.id.equals('debug-sample-goal'))).getSingle();
    expect(debugGoal.isActive, isFalse);

    await seeder.seed(now);

    expect(
      await database.select(database.consumptionEvents).get(),
      hasLength(events.length),
    );
    expect(
      await database.select(database.urgeSessions).get(),
      hasLength(urges.length),
    );
    expect(
      await database.select(database.copingStrategyUses).get(),
      hasLength(strategyUses.length),
    );
    expect(
      await database.select(database.dailyCheckIns).get(),
      hasLength(checkIns.length),
    );
    expect(
      await database.select(database.selfAssessments).get(),
      hasLength(assessments.length),
    );
    expect(
      await database.select(database.moduleProgress).get(),
      hasLength(modules.length),
    );
  });
}
