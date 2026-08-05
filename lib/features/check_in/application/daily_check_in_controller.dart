import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/diagnostics/error_reporter.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/utils/local_date.dart';
import 'package:stopcorn/features/check_in/application/daily_check_in_reminder_service.dart';
import 'package:stopcorn/features/check_in/data/check_in_repository.dart';
import 'package:stopcorn/features/check_in/domain/daily_check_in_input.dart';
import 'package:stopcorn/features/check_in/domain/daily_check_in_state.dart';
import 'package:stopcorn/features/consumption/data/consumption_repository.dart';
import 'package:stopcorn/features/journal/data/journal_repository.dart';
import 'package:stopcorn/i18n/strings.g.dart';

part 'daily_check_in_controller.g.dart';

/// Owns and persists the daily check-in form.
///
/// Passing a [requestedDate] edits the check-in of that local calendar day
/// instead of today's, which is how a past entry is corrected.
@riverpod
final class DailyCheckInController extends _$DailyCheckInController {
  @override
  Future<DailyCheckInState> build(String? requestedDate) async {
    String localDate = requestedDate == null || requestedDate.isEmpty ? localDateKey(ref.read(appClockProvider).now()) : requestedDate;
    DailyCheckIn? existing = await ref.read(checkInRepositoryProvider).getByLocalDate(localDate);
    int recorded = await ref.read(consumptionRepositoryProvider).countOnLocalDate(localDate);
    if (existing == null) {
      return DailyCheckInState(
        localDate: localDate,
        moodScore: 5,
        controlScore: 5,
        recordedConsumptionCount: recorded,
      );
    }
    return DailyCheckInState(
      localDate: localDate,
      moodScore: existing.moodScore,
      controlScore: existing.controlScore,
      urgeCountInput: existing.urgeCountEstimate?.toString() ?? '',
      recordedConsumptionCount: recorded,
      sleepQuality: existing.sleepQuality,
      note: existing.note ?? '',
      wasExisting: true,
    );
  }

  /// Updates the mood score, clamped to the supported scale.
  void setMoodScore(int value) {
    _update(
      (current) => current.copyWith(moodScore: value.clamp(0, 10), errorMessage: null),
    );
  }

  /// Updates the perceived-control score.
  void setControlScore(int value) {
    _update(
      (current) => current.copyWith(
        controlScore: value.clamp(0, 10),
        errorMessage: null,
      ),
    );
  }

  /// Updates the unparsed optional urge-count field.
  void setUrgeCountInput(String value) {
    _update(
      (current) => current.copyWith(urgeCountInput: value, errorMessage: null),
    );
  }

  /// Updates or clears the optional sleep-quality score.
  void setSleepQuality(int? value) {
    _update(
      (current) => current.copyWith(
        sleepQuality: value?.clamp(0, 10),
        errorMessage: null,
      ),
    );
  }

  /// Updates the optional private note.
  void setNote(String value) {
    _update((current) => current.copyWith(note: value, errorMessage: null));
  }

  /// Reloads the event count without discarding the rest of the draft.
  Future<void> refreshRecordedConsumptionCount() async {
    DailyCheckInState? current = state.value;
    if (current == null || current.isSaving || current.isSaved) {
      return;
    }
    int recorded = await ref.read(consumptionRepositoryProvider).countOnLocalDate(current.localDate);
    _update(
      (latest) => latest.copyWith(recordedConsumptionCount: recorded),
    );
  }

  /// Validates and persists the form, returning whether it succeeded.
  Future<bool> save() async {
    DailyCheckInState? current = state.value;
    if (current == null || current.isSaving || current.isSaved) {
      return false;
    }
    int? urgeCount = _parseCount(current.urgeCountInput);
    if (current.urgeCountInput.trim().isNotEmpty && urgeCount == null) {
      state = AsyncData(
        current.copyWith(
          errorMessage: t.checkIn.urge.negative,
        ),
      );
      return false;
    }
    state = AsyncData(current.copyWith(isSaving: true, errorMessage: null));
    try {
      await ref
          .read(checkInRepositoryProvider)
          .save(
            DailyCheckInInput(
              localDate: current.localDate,
              recordedAt: ref.read(appClockProvider).now(),
              moodScore: current.moodScore,
              controlScore: current.controlScore,
              urgeCountEstimate: urgeCount,
              sleepQuality: current.sleepQuality,
              note: current.note,
            ),
          );
      await ref.read(dailyCheckInReminderServiceProvider).synchronize();
      ref.invalidate(journalDaysProvider);
      state = AsyncData(
        current.copyWith(
          wasExisting: true,
          isSaving: false,
          isSaved: true,
          errorMessage: null,
        ),
      );
      return true;
    } catch (error, stackTrace) {
      ref.reportFailure(error, stackTrace, operation: 'check_in.save');
      state = AsyncData(
        current.copyWith(
          isSaving: false,
          errorMessage: t.checkIn.error.save,
        ),
      );
      return false;
    }
  }

  /// Parses an optional non-negative count, or `null` when it is unusable.
  int? _parseCount(String raw) {
    String trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    int? value = int.tryParse(trimmed);
    return value == null || value < 0 ? null : value;
  }

  /// Applies a synchronous form mutation while editing is allowed.
  void _update(DailyCheckInState Function(DailyCheckInState) update) {
    DailyCheckInState? current = state.value;
    if (current != null && !current.isSaving && !current.isSaved) {
      state = AsyncData(update(current));
    }
  }
}
