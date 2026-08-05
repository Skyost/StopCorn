import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/consumption/data/consumption_repository.dart';
import 'package:stopcorn/features/consumption/domain/consumption_input.dart';
import 'package:stopcorn/features/urge/data/urge_repository.dart';

import '../../helpers/test_database.dart';

/// Runs urge repository tests.
void main() {
  setUpAll(configureTestSqlite);

  late AppDatabase database;
  late UrgeRepository repository;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    repository = UrgeRepository(database);
    await database.seedBuiltInStrategies(DateTime.utc(2026, 7, 28, 12));
  });

  tearDown(() => database.close());

  test(
    'a session and its strategy use are added to history',
    () async {
      DateTime startedAt = DateTime.utc(2026, 7, 28, 12);
      await repository.createSession(
        id: 'urge-1',
        startedAt: startedAt,
        initialIntensity: 8,
        triggerType: TriggerType.stress,
      );
      await repository.selectStrategy(
        sessionId: 'urge-1',
        strategyId: 'walk-five-minutes',
        strategyUseId: 'use-1',
        usedAt: startedAt.add(const Duration(minutes: 2)),
      );
      await repository.completeSession(
        sessionId: 'urge-1',
        completedAt: startedAt.add(const Duration(minutes: 8)),
        finalIntensity: 4,
        outcome: UrgeOutcome.reduced,
        pauseDurationSeconds: 90,
        strategyUseId: 'use-1',
        strategyEffect: 3,
      );

      UrgeSession? session = await repository.getById('urge-1');
      List<CopingStrategyUse> uses = await database.select(database.copingStrategyUses).get();
      expect(session?.initialIntensity, 8);
      expect(session?.finalIntensity, 4);
      expect(session?.outcome, UrgeOutcome.reduced.name);
      expect(session?.copingStrategyId, 'walk-five-minutes');
      expect(uses, hasLength(1));
      expect(uses.single.perceivedEffect, 3);
    },
  );

  test('an exited session remains recorded as abandoned', () async {
    DateTime now = DateTime.utc(2026, 7, 28, 12);
    await repository.createSession(
      id: 'urge-2',
      startedAt: now,
      initialIntensity: 6,
    );

    await repository.abandonSession(
      sessionId: 'urge-2',
      completedAt: now.add(const Duration(seconds: 20)),
    );

    UrgeSession? session = await repository.getById('urge-2');
    expect(session?.outcome, UrgeOutcome.abandoned.name);
    expect(session?.completedAt, isNotNull);
  });

  test('every user-selectable outcome can complete a session', () async {
    DateTime now = DateTime.utc(2026, 7, 28, 12);

    Iterable<UrgeOutcome> outcomes = UrgeOutcome.values.where(
      (outcome) => outcome != .abandoned,
    );
    for (var (int index, UrgeOutcome outcome) in outcomes.indexed) {
      String id = 'outcome-$index';
      await repository.createSession(
        id: id,
        startedAt: now.add(Duration(minutes: index)),
        initialIntensity: 6,
      );
      await repository.completeSession(
        sessionId: id,
        completedAt: now.add(Duration(minutes: index + 1)),
        finalIntensity: 5,
        outcome: outcome,
        pauseDurationSeconds: 30,
      );

      expect((await repository.getById(id))?.outcome, outcome.name);
    }
  });

  test('deleting a session removes the strategy uses it owns', () async {
    DateTime now = DateTime.utc(2026, 7, 28, 12);
    await repository.createSession(
      id: 'urge-delete',
      startedAt: now,
      initialIntensity: 7,
    );
    await repository.selectStrategy(
      sessionId: 'urge-delete',
      strategyId: 'walk-five-minutes',
      strategyUseId: 'use-delete',
      usedAt: now.add(const Duration(minutes: 1)),
    );
    await repository.completeSession(
      sessionId: 'urge-delete',
      completedAt: now.add(const Duration(minutes: 5)),
      finalIntensity: 3,
      outcome: UrgeOutcome.reduced,
      strategyUseId: 'use-delete',
      strategyEffect: 4,
    );

    await repository.remove('urge-delete');

    expect(await repository.getById('urge-delete'), isNull);
    expect(await database.select(database.copingStrategyUses).get(), isEmpty);
  });

  test('deleting a session keeps the consumption recorded from it', () async {
    DateTime now = DateTime.utc(2026, 7, 28, 12);
    await repository.createSession(
      id: 'urge-linked',
      startedAt: now,
      initialIntensity: 9,
    );
    await ConsumptionRepository(database).add(
      ConsumptionInput(
        id: 'event-linked',
        occurredAt: now.add(const Duration(minutes: 10)),
        createdAt: now.add(const Duration(minutes: 10)),
        urgeSessionId: 'urge-linked',
      ),
    );

    await repository.remove('urge-linked');

    ConsumptionEvent? event = await ConsumptionRepository(database).getById('event-linked');
    expect(event, isNotNull);
    expect(event?.urgeSessionId, isNull);
  });

  test('deleting an unknown session reports a failure', () async {
    expect(repository.remove('missing-session'), throwsStateError);
  });

  test('abandoned cannot be used as a completed outcome', () async {
    DateTime now = DateTime.utc(2026, 7, 28, 12);
    await repository.createSession(
      id: 'invalid-outcome',
      startedAt: now,
      initialIntensity: 6,
    );

    expect(
      () => repository.completeSession(
        sessionId: 'invalid-outcome',
        completedAt: now.add(const Duration(minutes: 1)),
        finalIntensity: 5,
        outcome: UrgeOutcome.abandoned,
      ),
      throwsFormatException,
    );
    expect(
      (await repository.getById('invalid-outcome'))?.completedAt,
      isNull,
    );
  });
}
