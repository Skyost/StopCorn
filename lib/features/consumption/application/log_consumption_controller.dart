import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/diagnostics/error_reporter.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/features/consumption/data/consumption_repository.dart';
import 'package:stopcorn/features/consumption/domain/consumption_input.dart';
import 'package:stopcorn/features/consumption/domain/log_consumption_state.dart';
import 'package:stopcorn/features/goals/data/goal_repository.dart';
import 'package:stopcorn/features/journal/data/journal_repository.dart';
import 'package:stopcorn/features/urge/data/urge_repository.dart';
import 'package:stopcorn/i18n/strings.g.dart';

part 'log_consumption_controller.g.dart';

/// Owns and persists a voluntary consumption event form.
///
/// Passing an [eventId] edits that existing event instead of creating one.
@riverpod
final class LogConsumptionController extends _$LogConsumptionController {
  @override
  Future<LogConsumptionState> build(
    String? urgeSessionId,
    String? eventId,
    String? initialLocalDate,
  ) async {
    DateTime now = ref.read(appClockProvider).now().toLocal();
    Goal? activeGoal = await ref.read(goalRepositoryProvider).getActive();
    List<String> activeContextKeys = activeGoal?.type == GoalType.contextual.name ? _decodeStringList(activeGoal?.contextKeysJson) : const [];
    if (eventId != null && eventId.isNotEmpty) {
      ConsumptionEvent? event = await ref.read(consumptionRepositoryProvider).getById(eventId);
      if (event == null) {
        throw StateError(t.consumption.error.missingEvent);
      }
      List<String> selectedContextKeys = _decodeStringList(event.contextKeysJson);
      List<String> availableContextKeys = <String>{
        ...activeContextKeys,
        ...selectedContextKeys,
      }.toList()..sort();
      return LogConsumptionState(
        occurredAt: event.occurredAt.toLocal(),
        triggerType: enumFromStoredValueOrNull(TriggerType.values, event.triggerType),
        emotionType: enumFromStoredValueOrNull(EmotionType.values, event.emotionType),
        perceivedControl: event.perceivedControl,
        contextLabel: event.contextLabel ?? '',
        availableContextKeys: List<String>.unmodifiable(availableContextKeys),
        selectedContextKeys: Set<String>.unmodifiable(selectedContextKeys),
        notes: event.notes ?? '',
        editedEventId: eventId,
      );
    }
    if (urgeSessionId == null || urgeSessionId.isEmpty) {
      return LogConsumptionState(
        occurredAt: _initialOccurredAt(now, initialLocalDate),
        availableContextKeys: activeContextKeys,
      );
    }

    UrgeSession? session = await ref.read(urgeRepositoryProvider).getById(urgeSessionId);
    return LogConsumptionState(
      occurredAt: now,
      triggerType: enumFromStoredValueOrNull(TriggerType.values, session?.triggerType),
      emotionType: enumFromStoredValueOrNull(EmotionType.values, session?.emotionType),
      availableContextKeys: activeContextKeys,
      urgeSessionId: session == null ? null : urgeSessionId,
    );
  }

  /// Places a new event on [initialLocalDate] while preserving the current time.
  DateTime _initialOccurredAt(DateTime now, String? initialLocalDate) {
    if (initialLocalDate == null || initialLocalDate.isEmpty) {
      return now;
    }
    DateTime? date = DateTime.tryParse(initialLocalDate);
    if (date == null) {
      return now;
    }
    return _atMostNow(
      DateTime(
        date.year,
        date.month,
        date.day,
        now.hour,
        now.minute,
      ),
    );
  }

  /// Replaces the calendar date while preserving the selected time.
  void setDate(DateTime value) {
    _update(
      (current) => current.copyWith(
        occurredAt: _atMostNow(
          DateTime(
            value.year,
            value.month,
            value.day,
            current.occurredAt.hour,
            current.occurredAt.minute,
          ),
        ),
        errorMessage: null,
      ),
    );
  }

  /// Replaces the local hour and [minute] while preserving the date.
  void setTime({required int hour, required int minute}) {
    _update(
      (current) => current.copyWith(
        occurredAt: _atMostNow(
          DateTime(
            current.occurredAt.year,
            current.occurredAt.month,
            current.occurredAt.day,
            hour,
            minute,
          ),
        ),
        errorMessage: null,
      ),
    );
  }

  /// Keeps [value] from landing in the future.
  ///
  /// The journal records what already happened, and a future entry would be
  /// silently dropped from every period-bounded statistic.
  DateTime _atMostNow(DateTime value) {
    DateTime now = ref.read(appClockProvider).now().toLocal();
    return value.isAfter(now) ? now : value;
  }

  /// Updates or clears the general trigger marker.
  void setTrigger(TriggerType? value) {
    _update(
      (current) => current.copyWith(triggerType: value, errorMessage: null),
    );
  }

  /// Updates or clears the general emotion marker.
  void setEmotion(EmotionType? value) {
    _update(
      (current) => current.copyWith(emotionType: value, errorMessage: null),
    );
  }

  /// Updates or clears the perceived-control score.
  void setPerceivedControl(int? value) {
    _update(
      (current) => current.copyWith(
        perceivedControl: value?.clamp(0, 10),
        errorMessage: null,
      ),
    );
  }

  /// Updates the optional general context.
  void setContextLabel(String value) {
    _update(
      (current) => current.copyWith(contextLabel: value, errorMessage: null),
    );
  }

  /// Toggles one context from the active contextual goal.
  void toggleContextKey(String key) {
    _update((current) {
      if (!current.availableContextKeys.contains(key)) {
        return current;
      }
      Set<String> selected = current.selectedContextKeys.toSet();
      selected.contains(key) ? selected.remove(key) : selected.add(key);
      return current.copyWith(
        selectedContextKeys: Set<String>.unmodifiable(selected),
        errorMessage: null,
      );
    });
  }

  /// Updates the optional private note.
  void setNotes(String value) {
    _update((current) => current.copyWith(notes: value, errorMessage: null));
  }

  /// Validates and persists the voluntarily entered event.
  Future<bool> save() async {
    LogConsumptionState? current = state.value;
    if (current == null || current.isSaving || current.isSaved) {
      return false;
    }

    state = AsyncData(current.copyWith(isSaving: true, errorMessage: null));
    try {
      DateTime now = ref.read(appClockProvider).now();
      String? edited = current.editedEventId;
      ConsumptionInput input = ConsumptionInput(
        id: edited ?? ref.read(uuidProvider).v4(),
        occurredAt: current.occurredAt,
        createdAt: now,
        triggerType: current.triggerType,
        emotionType: current.emotionType,
        perceivedControl: current.perceivedControl,
        contextLabel: current.contextLabel,
        contextKeys: current.selectedContextKeys.toList(),
        notes: current.notes,
        urgeSessionId: current.urgeSessionId,
      );
      ConsumptionRepository repository = ref.read(consumptionRepositoryProvider);
      if (edited == null) {
        await repository.add(input);
      } else {
        await repository.update(input);
      }
      ref.invalidate(journalDaysProvider);
      state = AsyncData(
        current.copyWith(isSaving: false, isSaved: true, errorMessage: null),
      );
      return true;
    } catch (error, stackTrace) {
      ref.reportFailure(error, stackTrace, operation: 'consumption.save');
      state = AsyncData(
        current.copyWith(
          isSaving: false,
          errorMessage: t.consumption.error.save,
        ),
      );
      return false;
    }
  }

  /// Applies a synchronous form mutation while editing is allowed.
  void _update(LogConsumptionState Function(LogConsumptionState) update) {
    LogConsumptionState? current = state.value;
    if (current != null && !current.isSaving && !current.isSaved) {
      state = AsyncData(update(current));
    }
  }
}

/// Decodes a persisted JSON string array without breaking the event form.
List<String> _decodeStringList(String? encoded) {
  if (encoded == null || encoded.isEmpty) {
    return const [];
  }
  try {
    Object? decoded = jsonDecode(encoded);
    return decoded is List ? decoded.whereType<String>().toSet().toList() : const [];
  } on FormatException {
    return const [];
  }
}
