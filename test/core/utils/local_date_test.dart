import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/utils/local_date.dart';

import '../../helpers/daylight_saving.dart';

/// Runs local calendar-date helper tests.
void main() {
  test('moves by calendar days rather than twenty-four-hour periods', () {
    DateTime day = DateTime(2026, 3, 30);

    expect(addLocalDays(day, -1), DateTime(2026, 3, 29));
    expect(addLocalDays(day, 1), DateTime(2026, 3, 31));
    expect(addLocalDays(day, -30), DateTime(2026, 2, 28));
    expect(addLocalDays(DateTime(2026, 12, 31), 1), DateTime(2027));
  });

  test('always returns local midnight from any instant', () {
    expect(
      addLocalDays(DateTime(2026, 3, 30, 23, 45, 12), 0),
      DateTime(2026, 3, 30),
    );
  });

  test('counts calendar days between two dates', () {
    expect(localDaysBetween(DateTime(2026, 3, 29), DateTime(2026, 3, 30)), 1);
    expect(localDaysBetween(DateTime(2026, 3, 30), DateTime(2026, 3, 29)), -1);
    expect(localDaysBetween(DateTime(2026, 3, 30), DateTime(2026, 3, 30)), 0);
    expect(localDaysBetween(DateTime(2026), DateTime(2026, 12, 31)), 364);
  });

  test('remains accurate around daylight-saving changes in the current zone', () {
    List<DateTime> transitions = daylightSavingDays(2026);
    if (transitions.isEmpty) {
      // The suite runs in a zone without daylight saving, such as UTC.
      return;
    }
    for (DateTime day in transitions) {
      DateTime previousDay = addLocalDays(day, -1);
      expect(
        localDateKey(previousDay),
        isNot(localDateKey(day)),
        reason: 'The day before $day must be a different calendar day.',
      );
      expect(
        localDaysBetween(previousDay, day),
        1,
        reason: '$day must immediately follow $previousDay.',
      );
      expect(
        addLocalDays(previousDay, 1),
        day,
        reason: 'A round trip around $day must be neutral.',
      );

      // The seven-day harvest window is what a fixed duration used to break:
      // it silently skipped or repeated the transition day.
      List<String> window = [
        for (int offset = 6; offset >= 0; offset--) localDateKey(addLocalDays(day, -offset)),
      ];
      expect(
        window.toSet(),
        hasLength(7),
        reason: 'The seven-day window ending on $day must contain distinct days.',
      );
      for (int index = 1; index < window.length; index++) {
        expect(
          localDaysBetween(
            DateTime.parse(window[index - 1]),
            DateTime.parse(window[index]),
          ),
          1,
          reason: 'The window ending on $day must be contiguous.',
        );
      }
    }
  });
}
