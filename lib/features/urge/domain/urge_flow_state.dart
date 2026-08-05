import 'package:stopcorn/core/domain/app_enums.dart';

/// Screens traversed by one urge-support session.
enum UrgeFlowStep {
  /// Initial intensity and optional general markers.
  intensity,

  /// Choice between the available forms of immediate support.
  supportChoice,

  /// Guided pause.
  pause,

  /// Coping-strategy selection and use.
  strategy,

  /// Final intensity and outcome.
  reassessment,

  /// Supportive completion summary.
  completed,
}

/// Forms of support that can follow the initial urge marker.
enum UrgeSupportPath {
  /// Short guided grounding pause.
  guidedPause,

  /// Actions prepared in the personal backup plan.
  backupPlan,

  /// Enabled actions that are not part of the personal backup plan.
  otherIdeas,
}

/// Immutable in-memory state of the end-to-end urge flow.
final class UrgeFlowState {
  /// Current screen in the flow.
  final UrgeFlowStep step;

  /// Persisted urge-session identifier after the flow starts.
  final String? sessionId;

  /// Persisted strategy-use identifier after strategy selection.
  final String? strategyUseId;

  /// Initial urge intensity from zero to ten.
  final int initialIntensity;

  /// Reassessed urge intensity from zero to ten.
  final int finalIntensity;

  /// Optional general trigger marker.
  final TriggerType? triggerType;

  /// Optional general emotion marker.
  final EmotionType? emotionType;

  /// Form of support chosen for the active session.
  final UrgeSupportPath? supportPath;

  /// Selected coping-strategy identifier.
  final String? selectedStrategyId;

  /// Instant at which the guided pause began.
  final DateTime? pauseStartedAt;

  /// Instant at which the selected strategy began.
  final DateTime? strategyStartedAt;

  /// Recorded guided-pause duration.
  final int? pauseDurationSeconds;

  /// Optional final session outcome.
  final UrgeOutcome? outcome;

  /// Perceived strategy effect from minus five to five.
  final int strategyEffect;

  /// Optional private reflection.
  final String notes;

  /// Whether a persistence operation is running.
  final bool isSaving;

  /// Localized recoverable flow error.
  final String? errorMessage;

  /// Creates an urge-flow snapshot.
  const UrgeFlowState({
    this.step = .intensity,
    this.sessionId,
    this.strategyUseId,
    this.initialIntensity = 5,
    this.finalIntensity = 5,
    this.triggerType,
    this.emotionType,
    this.supportPath,
    this.selectedStrategyId,
    this.pauseStartedAt,
    this.strategyStartedAt,
    this.pauseDurationSeconds,
    this.outcome,
    this.strategyEffect = 0,
    this.notes = '',
    this.isSaving = false,
    this.errorMessage,
  });

  /// Returns a new snapshot with the supplied fields replaced.
  ///
  /// Nullable fields use the shared `_unchanged` sentinel, so passing an
  /// explicit `null` clears them instead of silently keeping the old value.
  UrgeFlowState copyWith({
    UrgeFlowStep? step,
    String? sessionId,
    String? strategyUseId,
    int? initialIntensity,
    int? finalIntensity,
    Object? triggerType = _unchanged,
    Object? emotionType = _unchanged,
    Object? supportPath = _unchanged,
    Object? selectedStrategyId = _unchanged,
    Object? pauseStartedAt = _unchanged,
    Object? strategyStartedAt = _unchanged,
    Object? pauseDurationSeconds = _unchanged,
    Object? outcome = _unchanged,
    int? strategyEffect,
    String? notes,
    bool? isSaving,
    Object? errorMessage = _unchanged,
  }) => UrgeFlowState(
    step: step ?? this.step,
    sessionId: sessionId ?? this.sessionId,
    strategyUseId: strategyUseId ?? this.strategyUseId,
    initialIntensity: initialIntensity ?? this.initialIntensity,
    finalIntensity: finalIntensity ?? this.finalIntensity,
    triggerType: identical(triggerType, _unchanged) ? this.triggerType : triggerType as TriggerType?,
    emotionType: identical(emotionType, _unchanged) ? this.emotionType : emotionType as EmotionType?,
    supportPath: identical(supportPath, _unchanged) ? this.supportPath : supportPath as UrgeSupportPath?,
    selectedStrategyId: identical(selectedStrategyId, _unchanged) ? this.selectedStrategyId : selectedStrategyId as String?,
    pauseStartedAt: identical(pauseStartedAt, _unchanged) ? this.pauseStartedAt : pauseStartedAt as DateTime?,
    strategyStartedAt: identical(strategyStartedAt, _unchanged) ? this.strategyStartedAt : strategyStartedAt as DateTime?,
    pauseDurationSeconds: identical(pauseDurationSeconds, _unchanged) ? this.pauseDurationSeconds : pauseDurationSeconds as int?,
    outcome: identical(outcome, _unchanged) ? this.outcome : outcome as UrgeOutcome?,
    strategyEffect: strategyEffect ?? this.strategyEffect,
    notes: notes ?? this.notes,
    isSaving: isSaving ?? this.isSaving,
    errorMessage: identical(errorMessage, _unchanged) ? this.errorMessage : errorMessage as String?,
  );
}

/// Sentinel distinguishing an omitted nullable value from an explicit `null`.
const Object _unchanged = Object();
