/// Local calendar days that immediately follow a daylight-saving transition.
///
/// The days are returned for the zone the suite currently runs in, so date
/// arithmetic can be exercised where a day is not twenty-four hours long. The
/// list is empty in a zone without any transition, such as UTC.
List<DateTime> daylightSavingDays(int year) {
  List<DateTime> transitions = [];
  DateTime previous = DateTime(year);
  for (DateTime day = DateTime(year, 1, 2); day.year == year; day = DateTime(day.year, day.month, day.day + 1)) {
    if (day.timeZoneOffset != previous.timeZoneOffset) {
      transitions.add(day);
    }
    previous = day;
  }
  return transitions;
}
