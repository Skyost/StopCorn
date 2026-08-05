import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/consumption/data/consumption_repository.dart';
import 'package:stopcorn/features/consumption/domain/consumption_input.dart';

import '../../helpers/test_database.dart';

/// Runs consumption repository tests.
void main() {
  setUpAll(configureTestSqlite);

  test('adds a consumption without explicit data', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    ConsumptionRepository repository = ConsumptionRepository(database);
    DateTime occurredAt = DateTime.utc(2026, 7, 27, 21, 30);

    await repository.add(
      ConsumptionInput(
        id: 'event-1',
        occurredAt: occurredAt,
        createdAt: DateTime.utc(2026, 7, 28),
        triggerType: TriggerType.stress,
        emotionType: EmotionType.anxious,
        contextLabel: '  Alone in the evening  ',
        perceivedControl: 3,
        notes: 'A general marker.',
      ),
    );

    List<ConsumptionEvent> events = await repository.getAll();
    expect(events, hasLength(1));
    expect(events.single.occurredAt.toUtc(), occurredAt);
    expect(events.single.contextLabel, 'Alone in the evening');
    expect(events.single.triggerType, TriggerType.stress.name);
    expect(events.single.perceivedControl, 3);
  });

  test('rejects a perceived-control score outside the scale', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    ConsumptionRepository repository = ConsumptionRepository(database);

    expect(
      () => repository.add(
        ConsumptionInput(
          id: 'invalid',
          occurredAt: DateTime.utc(2026, 7, 28),
          createdAt: DateTime.utc(2026, 7, 28),
          perceivedControl: 11,
        ),
      ),
      throwsFormatException,
    );
  });
}
