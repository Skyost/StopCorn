import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/data_export/data/data_export_service.dart';

import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';

/// Runs local data export service tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  test(
    'creates a versioned JSON export and then only invokes sharing',
    () async {
      AppDatabase database = AppDatabase(NativeDatabase.memory());
      AppPreferences preferences = AppPreferences(
        createTestPreferences(
          initialValues: {
            'onboarding_completed': true,
            'selected_strategy_ids': ['walk-five-minutes'],
          },
        ),
      );
      Directory directory = await Directory.systemTemp.createTemp(
        'stopcorn_export_test_',
      );
      File? sharedFile;
      addTearDown(() async {
        await preferences.dispose();
        await database.close();
        if (await directory.exists()) {
          await directory.delete(recursive: true);
        }
      });
      DateTime now = DateTime.utc(2026, 7, 28, 12, 34);
      await database
          .into(database.goals)
          .insert(
            GoalsCompanion.insert(
              id: 'goal-1',
              createdAt: now,
              updatedAt: now,
              type: GoalType.observation.name,
              startedAt: now,
            ),
          );
      await database
          .into(database.consumptionEvents)
          .insert(
            ConsumptionEventsCompanion.insert(
              id: 'event-1',
              occurredAt: now,
              triggerType: Value<String?>(TriggerType.stress.name),
              contextKeysJson: Value<String?>(jsonEncode(['home-alone'])),
              notes: const Value<String?>('Private marker'),
              createdAt: now,
            ),
          );
      DataExportService service = DataExportService(
        database,
        preferences,
        FixedAppClock(now),
        () async => directory,
        (file) async => sharedFile = file,
      );

      File file = await service.createAndShareExport();
      Map<String, Object?> decoded = jsonDecode(await file.readAsString()) as Map<String, Object?>;

      String localHour = now.toLocal().hour.toString().padLeft(2, '0');
      expect(
        file.path,
        contains('stopcorn-export-2026-07-28-${localHour}34.json'),
      );
      expect(sharedFile?.path, file.path);
      expect(decoded['exportVersion'], 1);
      expect(decoded['app'], 'StopCorn');
      expect(decoded['exportedAt'], '2026-07-28T12:34:00.000Z');
      expect(decoded['goals'], hasLength(1));
      expect(decoded['consumptionEvents'], hasLength(1));
      List<Object?> exportedEvents = decoded['consumptionEvents']! as List<Object?>;
      Map<String, Object?> exportedEvent = exportedEvents.single! as Map<String, Object?>;
      expect(exportedEvent['contextKeys'], ['home-alone']);
      expect(decoded['preferences'], isA<Map<String, Object?>>());
      String encoded = jsonEncode(decoded).toLowerCase();
      expect(encoded, isNot(contains('"url"')));
      expect(encoded, isNot(contains('browserhistory')));
      expect(encoded, isNot(contains('searchterms')));
    },
  );

  test('does not leave a plaintext export in the cache', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(createTestPreferences());
    Directory directory = await Directory.systemTemp.createTemp(
      'stopcorn_export_purge_',
    );
    addTearDown(() async {
      await preferences.dispose();
      await database.close();
      if (await directory.exists()) {
        await directory.delete(recursive: true);
      }
    });
    DataExportService service = DataExportService(
      database,
      preferences,
      FixedAppClock(DateTime.utc(2026, 7, 28, 12, 34)),
      () async => directory,
      (file) async {},
    );

    File first = await service.createAndShareExport();
    expect(await first.exists(), isTrue);

    // A later launch, or a later export, must clear the previous one.
    await service.purgeExports();
    expect(await first.exists(), isFalse);
  });
}
