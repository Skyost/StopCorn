import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/check_in/data/check_in_repository.dart';
import 'package:stopcorn/features/check_in/domain/daily_check_in_input.dart';
import 'package:stopcorn/features/consumption/data/consumption_repository.dart';
import 'package:stopcorn/features/consumption/domain/consumption_input.dart';
import 'package:stopcorn/features/journal/data/journal_repository.dart';
import 'package:stopcorn/features/journal/domain/journal_day.dart';
import 'package:stopcorn/features/urge/data/urge_repository.dart';

import '../../helpers/test_database.dart';

/// Runs combined journal repository tests.
void main() {
  setUpAll(configureTestSqlite);

  test('makes completed sessions and their reflections available', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    UrgeRepository urges = UrgeRepository(database);
    JournalRepository journal = JournalRepository(
      ConsumptionRepository(database),
      CheckInRepository(database),
      urges,
    );

    await urges.createSession(
      id: 'finished',
      startedAt: DateTime(2026, 7, 28, 21),
      initialIntensity: 8,
      triggerType: .stress,
    );
    await urges.completeSession(
      sessionId: 'finished',
      completedAt: DateTime(2026, 7, 28, 21, 10),
      finalIntensity: 3,
      outcome: .passed,
      notes: 'What I noticed.',
    );
    await urges.createSession(
      id: 'abandoned',
      startedAt: DateTime(2026, 7, 28, 22),
      initialIntensity: 6,
    );
    await urges.abandonSession(
      sessionId: 'abandoned',
      completedAt: DateTime(2026, 7, 28, 22, 1),
    );

    List<JournalDay> days = await journal.getDays();
    List<UrgeJournalEntry> entries = days.expand((day) => day.entries).whereType<UrgeJournalEntry>().toList();

    // An interrupted session carries no reassessment, so it stays out.
    expect(entries, hasLength(1));
    expect(entries.single.id, 'finished');
    expect(entries.single.initialIntensity, 8);
    expect(entries.single.finalIntensity, 3);
    expect(entries.single.outcome, UrgeOutcome.passed);
    expect(entries.single.triggerType, TriggerType.stress);
    expect(entries.single.notes, 'What I noticed.');
    // A session without a guided pause must not report a zero-second one.
    expect(entries.single.pauseDurationSeconds, isNull);
  });

  test('groups consumption events and check-ins by local date', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    ConsumptionRepository consumptions = ConsumptionRepository(database);
    CheckInRepository checkIns = CheckInRepository(database);
    JournalRepository journal = JournalRepository(
      consumptions,
      checkIns,
      UrgeRepository(database),
    );

    await consumptions.add(
      ConsumptionInput(
        id: 'recent-event',
        occurredAt: DateTime(2026, 7, 28, 20, 30),
        createdAt: DateTime(2026, 7, 28, 20, 35),
        triggerType: .stress,
        emotionType: .anxious,
        contextLabel: 'After a busy day',
        notes: 'A general context to revisit.',
      ),
    );
    await consumptions.add(
      ConsumptionInput(
        id: 'older-event',
        occurredAt: DateTime(2026, 7, 27, 21),
        createdAt: DateTime(2026, 7, 27, 21, 5),
      ),
    );
    await checkIns.save(
      DailyCheckInInput(
        localDate: '2026-07-28',
        recordedAt: DateTime(2026, 7, 28, 22),
        moodScore: 7,
        controlScore: 6,
        urgeCountEstimate: 2,
        note: 'Private daily check-in.',
      ),
    );

    List<JournalDay> days = await journal.getDays();

    expect(days.map((day) => day.date), [
      DateTime(2026, 7, 28),
      DateTime(2026, 7, 27),
    ]);
    expect(days.first.entries, hasLength(2));
    expect(days.first.entries.first, isA<CheckInJournalEntry>());
    ConsumptionJournalEntry consumption = days.first.entries.whereType<ConsumptionJournalEntry>().single;
    expect(consumption.contextLabel, 'After a busy day');
    expect(consumption.notes, 'A general context to revisit.');
    expect(consumption.triggerType, TriggerType.stress);
    CheckInJournalEntry checkIn = days.first.entries.whereType<CheckInJournalEntry>().single;
    expect(checkIn.note, 'Private daily check-in.');
  });
}
