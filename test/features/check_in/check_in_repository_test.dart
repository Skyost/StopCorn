import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/features/check_in/data/check_in_repository.dart';
import 'package:stopcorn/features/check_in/domain/daily_check_in_input.dart';

import '../../helpers/test_database.dart';

/// Runs daily check-in repository tests.
void main() {
  setUpAll(configureTestSqlite);

  test('a daily check-in is created and then updated without duplication', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    CheckInRepository repository = CheckInRepository(database);
    DateTime createdAt = DateTime.utc(2026, 7, 28, 8);
    DateTime updatedAt = DateTime.utc(2026, 7, 28, 20);

    await repository.save(
      DailyCheckInInput(
        localDate: '2026-07-28',
        recordedAt: createdAt,
        moodScore: 5,
        controlScore: 4,
        urgeCountEstimate: 3,
      ),
    );
    await repository.save(
      DailyCheckInInput(
        localDate: '2026-07-28',
        recordedAt: updatedAt,
        moodScore: 8,
        controlScore: 7,
        urgeCountEstimate: 1,
        sleepQuality: 6,
        note: 'A different day.',
      ),
    );

    List<DailyCheckIn> rows = await database.select(database.dailyCheckIns).get();
    expect(rows, hasLength(1));
    expect(rows.single.createdAt.toUtc(), createdAt);
    expect(rows.single.updatedAt.toUtc(), updatedAt);
    expect(rows.single.moodScore, 8);
    expect(rows.single.controlScore, 7);
    expect(rows.single.urgeCountEstimate, 1);
    expect(rows.single.sleepQuality, 6);
  });
}
