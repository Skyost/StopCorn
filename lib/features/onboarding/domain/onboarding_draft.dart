import 'package:stopcorn/core/domain/app_enums.dart';

/// Durable answers collected across the resumable onboarding flow.
final class OnboardingDraft {
  /// UUID reserved for the goal created on completion.
  final String goalId;

  /// UUID reserved for the baseline assessment.
  final String assessmentId;

  /// Zero-based onboarding step to restore.
  final int currentStep;

  /// Selected goal direction.
  final GoalType? goalType;

  /// Optional weekly limit for a reduction goal.
  final int? weeklyLimit;

  /// General contexts selected for a contextual goal.
  final Set<String> contextKeys;

  /// Optional personal motivation.
  final String motivation;

  /// Approximate event frequency over the previous seven days.
  final int baselineFrequency;

  /// Baseline perceived-control score.
  final int perceivedControl;

  /// Baseline perceived negative-impact score.
  final int negativeImpact;

  /// Baseline confidence-to-change score.
  final int confidenceToChange;

  /// Coping-strategy identifiers selected for the backup plan.
  final Set<String> strategyIds;

  /// Whether a local reminder should be sent for an unfinished daily check-in.
  final bool dailyCheckInReminderEnabled;

  /// Creates a complete immutable onboarding draft.
  const OnboardingDraft({
    required this.goalId,
    required this.assessmentId,
    required this.currentStep,
    required this.goalType,
    required this.weeklyLimit,
    required this.contextKeys,
    required this.motivation,
    required this.baselineFrequency,
    required this.perceivedControl,
    required this.negativeImpact,
    required this.confidenceToChange,
    required this.strategyIds,
    required this.dailyCheckInReminderEnabled,
  });

  /// Creates a neutral draft with reserved goal and assessment identifiers.
  factory OnboardingDraft.initial({
    required String goalId,
    required String assessmentId,
    int currentStep = 0,
  }) => OnboardingDraft(
    goalId: goalId,
    assessmentId: assessmentId,
    currentStep: currentStep,
    goalType: null,
    weeklyLimit: null,
    contextKeys: const {},
    motivation: '',
    baselineFrequency: 0,
    perceivedControl: 5,
    negativeImpact: 5,
    confidenceToChange: 5,
    strategyIds: const {},
    dailyCheckInReminderEnabled: false,
  );

  /// Returns a new draft with immutable copies of supplied collections.
  OnboardingDraft copyWith({
    int? currentStep,
    GoalType? goalType,
    bool clearGoalType = false,
    int? weeklyLimit,
    bool clearWeeklyLimit = false,
    Set<String>? contextKeys,
    String? motivation,
    int? baselineFrequency,
    int? perceivedControl,
    int? negativeImpact,
    int? confidenceToChange,
    Set<String>? strategyIds,
    bool? dailyCheckInReminderEnabled,
  }) => OnboardingDraft(
    goalId: goalId,
    assessmentId: assessmentId,
    currentStep: currentStep ?? this.currentStep,
    goalType: clearGoalType ? null : goalType ?? this.goalType,
    weeklyLimit: clearWeeklyLimit ? null : weeklyLimit ?? this.weeklyLimit,
    contextKeys: Set<String>.unmodifiable(contextKeys ?? this.contextKeys),
    motivation: motivation ?? this.motivation,
    baselineFrequency: baselineFrequency ?? this.baselineFrequency,
    perceivedControl: perceivedControl ?? this.perceivedControl,
    negativeImpact: negativeImpact ?? this.negativeImpact,
    confidenceToChange: confidenceToChange ?? this.confidenceToChange,
    strategyIds: Set<String>.unmodifiable(strategyIds ?? this.strategyIds),
    dailyCheckInReminderEnabled: dailyCheckInReminderEnabled ?? this.dailyCheckInReminderEnabled,
  );
}

/// Immutable asynchronous-editing state around an [OnboardingDraft].
final class OnboardingViewState {
  /// Current durable setup answers.
  final OnboardingDraft draft;

  /// Whether a draft or completion write is running.
  final bool isSaving;

  /// Localized recoverable error shown in onboarding.
  final String? errorMessage;

  /// Creates an onboarding view snapshot.
  const OnboardingViewState({
    required this.draft,
    this.isSaving = false,
    this.errorMessage,
  });

  /// Returns a new snapshot with the supplied fields replaced.
  OnboardingViewState copyWith({
    OnboardingDraft? draft,
    bool? isSaving,
    String? errorMessage,
    bool clearError = false,
  }) => OnboardingViewState(
    draft: draft ?? this.draft,
    isSaving: isSaving ?? this.isSaving,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
}
