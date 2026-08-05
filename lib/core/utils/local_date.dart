/// Encodes the local calendar date of [dateTime] as `yyyy-MM-dd`.
String localDateKey(DateTime dateTime) {
  DateTime local = dateTime.toLocal();
  String month = local.month.toString().padLeft(2, '0');
  String day = local.day.toString().padLeft(2, '0');
  return '${local.year}-$month-$day';
}

/// Returns local midnight at the start of [dateTime]'s calendar day.
DateTime startOfLocalDay(DateTime dateTime) {
  DateTime local = dateTime.toLocal();
  return DateTime(local.year, local.month, local.day);
}

/// Returns local midnight [days] calendar days after [dateTime]'s own day.
///
/// Calendar arithmetic is used instead of [Duration] because a day is not
/// always twenty-four hours: around a daylight-saving transition, shifting by
/// a fixed duration skips or repeats a local calendar day.
DateTime addLocalDays(DateTime dateTime, int days) {
  DateTime local = dateTime.toLocal();
  return DateTime(local.year, local.month, local.day + days);
}

/// Returns the number of local calendar days from [from] to [to].
///
/// The comparison runs in UTC, which has no daylight-saving transition, so
/// two consecutive local days are always exactly one day apart.
int localDaysBetween(DateTime from, DateTime to) {
  DateTime start = from.toLocal();
  DateTime end = to.toLocal();
  return DateTime.utc(end.year, end.month, end.day).difference(DateTime.utc(start.year, start.month, start.day)).inDays;
}
