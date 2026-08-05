import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/consumption/application/log_consumption_controller.dart';
import 'package:stopcorn/features/consumption/data/consumption_repository.dart';
import 'package:stopcorn/features/consumption/domain/consumption_input.dart';
import 'package:stopcorn/features/consumption/domain/log_consumption_state.dart';
import 'package:stopcorn/features/urge/data/urge_repository.dart';

import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';

/// Runs consumption logging controller tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  test('prevents dating an event in the future', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    DateTime now = DateTime(2026, 7, 28, 14, 30);
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appClockProvider.overrideWithValue(FixedAppClock(now)),
      ],
    );
    addTearDown(container.dispose);

    LogConsumptionControllerProvider provider = logConsumptionControllerProvider(
      null,
      null,
      null,
    );
    await container.read(provider.future);

    container.read(provider.notifier).setDate(DateTime(2026, 8, 4));
    expect(container.read(provider).requireValue.occurredAt, now);

    container.read(provider.notifier).setTime(hour: 23, minute: 59);
    expect(container.read(provider).requireValue.occurredAt, now);

    // A past instant on the same day stays untouched.
    container.read(provider.notifier).setTime(hour: 9, minute: 15);
    expect(
      container.read(provider).requireValue.occurredAt,
      DateTime(2026, 7, 28, 9, 15),
    );
  });

  test('preselects the daily check-in date', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    DateTime now = DateTime(2026, 7, 28, 14, 30);
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appClockProvider.overrideWithValue(FixedAppClock(now)),
      ],
    );
    addTearDown(container.dispose);

    LogConsumptionState state = await container.read(
      logConsumptionControllerProvider(
        null,
        null,
        '2026-07-20',
      ).future,
    );

    expect(state.occurredAt, DateTime(2026, 7, 20, 14, 30));
  });

  test('updates an existing event without creating a second one', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await ConsumptionRepository(database).add(
      ConsumptionInput(
        id: 'event-1',
        occurredAt: DateTime.utc(2026, 7, 28, 9),
        createdAt: DateTime.utc(2026, 7, 28, 9, 5),
        contextKeys: const ['home-alone'],
        notes: 'Initial note.',
      ),
    );
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appClockProvider.overrideWithValue(
          FixedAppClock(DateTime.utc(2026, 7, 29, 10)),
        ),
      ],
    );
    addTearDown(container.dispose);

    LogConsumptionControllerProvider provider = logConsumptionControllerProvider(
      null,
      'event-1',
      null,
    );
    LogConsumptionState loaded = await container.read(provider.future);
    expect(loaded.isEditing, isTrue);
    expect(loaded.notes, 'Initial note.');
    expect(loaded.availableContextKeys, ['home-alone']);
    expect(loaded.selectedContextKeys, {'home-alone'});

    container.read(provider.notifier).setNotes('Corrected note.');
    expect(await container.read(provider.notifier).save(), isTrue);

    List<ConsumptionEvent> events = await ConsumptionRepository(database).getAll();
    expect(events, hasLength(1));
    expect(events.single.id, 'event-1');
    expect(events.single.notes, 'Corrected note.');
    expect(jsonDecode(events.single.contextKeysJson!), ['home-alone']);
    // The recording day must not move when the entry is only corrected.
    expect(events.single.createdAt.toUtc(), DateTime.utc(2026, 7, 28, 9, 5));
  });

  test('records contexts from the active contextual goal', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    DateTime now = DateTime.utc(2026, 7, 28, 12);
    await database
        .into(database.goals)
        .insert(
          GoalsCompanion.insert(
            id: 'contextual-goal',
            createdAt: now,
            updatedAt: now,
            type: GoalType.contextual.name,
            contextKeysJson: Value<String?>(
              jsonEncode(['late-evening', 'home-alone']),
            ),
            startedAt: now,
          ),
        );
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appClockProvider.overrideWithValue(FixedAppClock(now)),
      ],
    );
    addTearDown(container.dispose);
    LogConsumptionControllerProvider provider = logConsumptionControllerProvider(null, null, null);

    LogConsumptionState loaded = await container.read(provider.future);
    expect(loaded.availableContextKeys, [
      'late-evening',
      'home-alone',
    ]);
    container.read(provider.notifier).toggleContextKey('home-alone');
    expect(await container.read(provider.notifier).save(), isTrue);

    ConsumptionEvent event =
        (await database
                .select(
                  database.consumptionEvents,
                )
                .get())
            .single;
    expect(jsonDecode(event.contextKeysJson!), ['home-alone']);
  });

  test('records a consumption prefilled from an urge', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(createTestPreferences());
    DateTime now = DateTime.utc(2026, 7, 28, 19, 30);
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(FixedAppClock(now)),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await preferences.dispose();
      await database.close();
    });
    await UrgeRepository(database).createSession(
      id: 'urge-1',
      startedAt: now,
      initialIntensity: 8,
      triggerType: TriggerType.stress,
      emotionType: EmotionType.anxious,
    );

    LogConsumptionControllerProvider provider = logConsumptionControllerProvider(
      'urge-1',
      null,
      null,
    );
    LogConsumptionState initial = await container.read(provider.future);
    expect(initial.triggerType, TriggerType.stress);
    expect(initial.emotionType, EmotionType.anxious);

    LogConsumptionController controller = container.read(provider.notifier);
    controller.setPerceivedControl(2);
    controller.setContextLabel('Difficult evening');
    expect(await controller.save(), isTrue);

    List<ConsumptionEvent> events = await database.select(database.consumptionEvents).get();
    expect(events, hasLength(1));
    expect(events.single.perceivedControl, 2);
    expect(container.read(provider).value?.isSaved, isTrue);
  });

  test('exposes a clear error when the repository fails', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(createTestPreferences());
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        consumptionRepositoryProvider.overrideWithValue(
          _FailingConsumptionRepository(database),
        ),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await preferences.dispose();
      await database.close();
    });

    LogConsumptionControllerProvider provider = logConsumptionControllerProvider(
      null,
      null,
      null,
    );
    await container.read(provider.future);

    expect(await container.read(provider.notifier).save(), isFalse);
    expect(container.read(provider).value?.isSaving, isFalse);
    expect(
      container.read(provider).value?.errorMessage,
      contains("Impossible d'enregistrer"),
    );
  });

  test('remains busy while the repository mutation is pending', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(createTestPreferences());
    _DelayedConsumptionRepository repository = _DelayedConsumptionRepository(database);
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        consumptionRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await preferences.dispose();
      await database.close();
    });

    LogConsumptionControllerProvider provider = logConsumptionControllerProvider(
      null,
      null,
      null,
    );
    await container.read(provider.future);
    Future<bool> saveFuture = container.read(provider.notifier).save();
    await repository.started.future;

    expect(container.read(provider).value?.isSaving, isTrue);
    expect(container.read(provider).value?.isSaved, isFalse);

    repository.release.complete();
    expect(await saveFuture, isTrue);
    expect(container.read(provider).value?.isSaving, isFalse);
    expect(container.read(provider).value?.isSaved, isTrue);
  });
}

/// Repository double that always rejects consumption persistence.
final class _FailingConsumptionRepository extends ConsumptionRepository {
  /// Creates the failing double over an otherwise valid test database.
  _FailingConsumptionRepository(super.database);

  @override
  Future<void> add(ConsumptionInput input) => Future<void>.error(StateError('Simulated storage failure'));
}

/// Repository double that exposes controls around delayed persistence.
final class _DelayedConsumptionRepository extends ConsumptionRepository {
  /// Completes when persistence begins.
  final Completer<void> started = Completer<void>();

  /// Completes when the test allows persistence to finish.
  final Completer<void> release = Completer<void>();

  /// Creates the delayed double over an otherwise valid test database.
  _DelayedConsumptionRepository(super.database);

  @override
  Future<void> add(ConsumptionInput input) async {
    started.complete();
    await release.future;
  }
}
