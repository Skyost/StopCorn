import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/diagnostics/error_reporter.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/features/urge/data/urge_repository.dart';
import 'package:stopcorn/features/urge/domain/urge_flow_state.dart';
import 'package:stopcorn/i18n/strings.g.dart';

part 'urge_flow_controller.g.dart';

/// Owns the end-to-end urge pause session.
@Riverpod(keepAlive: true)
final class UrgeFlowController extends _$UrgeFlowController {
  @override
  UrgeFlowState build() => const UrgeFlowState();

  /// Discards in-memory flow state after completion or navigation.
  void reset() => state = const UrgeFlowState();

  /// Updates both starting and provisional final intensity.
  void setInitialIntensity(int value) {
    state = state.copyWith(
      initialIntensity: value.clamp(0, 10),
      finalIntensity: value.clamp(0, 10),
      errorMessage: null,
    );
  }

  /// Updates or clears the optional general trigger.
  void setTrigger(TriggerType? value) {
    state = state.copyWith(triggerType: value, errorMessage: null);
  }

  /// Updates or clears the optional general emotion.
  void setEmotion(EmotionType? value) {
    state = state.copyWith(emotionType: value, errorMessage: null);
  }

  /// Updates the reassessed urge intensity.
  void setFinalIntensity(int value) {
    state = state.copyWith(
      finalIntensity: value.clamp(0, 10),
      errorMessage: null,
    );
  }

  /// Selects a completed, non-judgmental session outcome.
  void setOutcome(UrgeOutcome value) {
    if (value == .abandoned) {
      return;
    }
    state = state.copyWith(outcome: value, errorMessage: null);
  }

  /// Updates perceived strategy usefulness from minus five to five.
  void setStrategyEffect(int value) {
    state = state.copyWith(strategyEffect: value.clamp(-5, 5));
  }

  /// Updates the optional private session note.
  void setNotes(String value) => state = state.copyWith(notes: value);

  /// Persists the initial session before immediate support is chosen.
  Future<bool> startSession() async {
    if (state.sessionId != null) {
      return true;
    }
    state = state.copyWith(isSaving: true, errorMessage: null);
    String id = ref.read(uuidProvider).v4();
    DateTime now = ref.read(appClockProvider).now();
    try {
      await ref
          .read(urgeRepositoryProvider)
          .createSession(
            id: id,
            startedAt: now,
            initialIntensity: state.initialIntensity,
            triggerType: state.triggerType,
            emotionType: state.emotionType,
          );
      state = state.copyWith(
        sessionId: id,
        step: .supportChoice,
        isSaving: false,
      );
      return true;
    } catch (error, stackTrace) {
      ref.reportFailure(error, stackTrace, operation: 'urge.start_session');
      state = state.copyWith(
        isSaving: false,
        errorMessage: t.urge.error.start,
      );
      return false;
    }
  }

  /// Selects [path] and advances to its first interactive step.
  bool chooseSupportPath(UrgeSupportPath path) {
    if (state.sessionId == null) {
      state = state.copyWith(errorMessage: t.urge.error.missingSession);
      return false;
    }
    bool guided = path == UrgeSupportPath.guidedPause;
    state = state.copyWith(
      supportPath: path,
      step: guided ? .pause : .strategy,
      // Changing path must not carry a previous pause into this one.
      pauseStartedAt: guided ? ref.read(appClockProvider).now() : null,
      pauseDurationSeconds: null,
      errorMessage: null,
    );
    return true;
  }

  /// Stores elapsed pause time and advances to the final check-in.
  void finishPause(int elapsedSeconds) {
    state = state.copyWith(
      pauseDurationSeconds: elapsedSeconds.clamp(
        0,
        AppConstants.guidedPauseSeconds,
      ),
      step: .reassessment,
      finalIntensity: state.initialIntensity,
      errorMessage: null,
    );
  }

  /// Preselects [strategyId] before its persistence starts.
  void chooseStrategy(String strategyId) {
    if (state.strategyStartedAt == null) {
      state = state.copyWith(selectedStrategyId: strategyId, errorMessage: null);
    }
  }

  /// Persists a strategy use linked to the active urge session.
  Future<bool> selectStrategy(String strategyId) async {
    String? sessionId = state.sessionId;
    if (sessionId == null) {
      state = state.copyWith(
        errorMessage: t.urge.error.missingSession,
      );
      return false;
    }
    state = state.copyWith(isSaving: true, errorMessage: null);
    String useId = ref.read(uuidProvider).v4();
    DateTime now = ref.read(appClockProvider).now();
    try {
      await ref
          .read(urgeRepositoryProvider)
          .selectStrategy(
            sessionId: sessionId,
            strategyId: strategyId,
            strategyUseId: useId,
            usedAt: now,
          );
      state = state.copyWith(
        selectedStrategyId: strategyId,
        strategyUseId: useId,
        strategyStartedAt: now,
        isSaving: false,
      );
      return true;
    } catch (error, stackTrace) {
      ref.reportFailure(error, stackTrace, operation: 'urge.select_strategy');
      state = state.copyWith(
        isSaving: false,
        errorMessage: t.urge.error.strategySave,
      );
      return false;
    }
  }

  /// Advances to final intensity and outcome reassessment.
  void moveToReassessment() {
    state = state.copyWith(
      step: .reassessment,
      finalIntensity: state.initialIntensity,
      errorMessage: null,
    );
  }

  /// Persists final markers and completes the active session.
  Future<bool> completeSession() async {
    String? sessionId = state.sessionId;
    UrgeOutcome? outcome = state.outcome;
    if (sessionId == null || outcome == null || outcome == .abandoned) {
      state = state.copyWith(
        errorMessage: t.urge.error.outcomeRequired,
      );
      return false;
    }
    state = state.copyWith(isSaving: true, errorMessage: null);
    try {
      await ref
          .read(urgeRepositoryProvider)
          .completeSession(
            sessionId: sessionId,
            completedAt: ref.read(appClockProvider).now(),
            finalIntensity: state.finalIntensity,
            outcome: outcome,
            pauseDurationSeconds: state.pauseDurationSeconds,
            notes: state.notes,
            strategyUseId: state.strategyUseId,
            strategyEffect: state.strategyUseId == null ? null : state.strategyEffect,
          );
      state = state.copyWith(step: .completed, isSaving: false);
      return true;
    } catch (error, stackTrace) {
      ref.reportFailure(error, stackTrace, operation: 'urge.complete_session');
      state = state.copyWith(
        isSaving: false,
        errorMessage: t.urge.error.save,
      );
      return false;
    }
  }

  /// Marks an unfinished persisted session abandoned, then resets the flow.
  Future<void> abandonSession() async {
    String? sessionId = state.sessionId;
    if (sessionId != null && state.step != .completed) {
      await ref
          .read(urgeRepositoryProvider)
          .abandonSession(
            sessionId: sessionId,
            completedAt: ref.read(appClockProvider).now(),
          );
    }
    state = const UrgeFlowState();
  }
}
