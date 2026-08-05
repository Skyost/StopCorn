import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/utils/local_date.dart';

/// Tracks the current local calendar day for date-based application views.
///
/// The value changes when the application resumes or reaches local midnight.
final currentAppDayProvider = NotifierProvider<CurrentAppDay, DateTime>(
  CurrentAppDay.new,
);

/// Refreshes the date anchor consumed by daily summaries.
final class CurrentAppDay extends Notifier<DateTime> {
  @override
  DateTime build() => startOfLocalDay(ref.read(appClockProvider).now().toLocal());

  /// Updates the state only when the local calendar day changed.
  void refresh() {
    DateTime currentDay = startOfLocalDay(ref.read(appClockProvider).now().toLocal());
    if (currentDay != state) {
      state = currentDay;
    }
  }
}
