import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/features/check_in/application/daily_check_in_reminder_service.dart';
import 'package:stopcorn/features/check_in/data/check_in_repository.dart';
import 'package:stopcorn/features/consumption/data/consumption_repository.dart';
import 'package:stopcorn/features/journal/data/journal_repository.dart';
import 'package:stopcorn/features/urge/data/urge_repository.dart';

part 'journal_entry_controller.g.dart';

/// Removes journal entries the user no longer considers accurate.
///
/// Deleting is deliberately narrow: it removes one record and refreshes the
/// journal, without touching anything the entry does not own.
///
/// The controller outlives the sheet that triggers it: an auto-disposed one
/// would be discarded while the deletion is still running, and refreshing the
/// journal afterwards would then fail even though the record is gone.
@Riverpod(keepAlive: true)
final class JournalEntryController extends _$JournalEntryController {
  @override
  void build() {}

  /// Deletes the consumption event identified by [id].
  Future<bool> removeConsumption(String id) async {
    try {
      await ref.read(consumptionRepositoryProvider).remove(id);
      ref.invalidate(journalDaysProvider);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Deletes the urge-support session identified by [id].
  Future<bool> removeUrgeSession(String id) async {
    try {
      await ref.read(urgeRepositoryProvider).remove(id);
      ref.invalidate(journalDaysProvider);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Deletes the check-in recorded on [localDate].
  Future<bool> removeCheckIn(String localDate) async {
    try {
      await ref.read(checkInRepositoryProvider).remove(localDate);
      ref.invalidate(journalDaysProvider);
      // Removing today's check-in makes the evening reminder relevant again.
      await ref.read(dailyCheckInReminderServiceProvider).synchronize();
      return true;
    } catch (_) {
      return false;
    }
  }
}
