/// Direction selected for the active behavior-change goal.
enum GoalType {
  /// Stop consumption entirely.
  abstinence,

  /// Reduce consumption toward a weekly limit.
  reduction,

  /// Avoid consumption only in selected contexts.
  contextual,

  /// Observe patterns without setting a reduction target.
  observation,
}

/// General, non-explicit situation associated with an urge or event.
enum TriggerType {
  /// Lack of stimulation or activity.
  boredom,

  /// Pressure or overload.
  stress,

  /// Feeling socially disconnected.
  loneliness,

  /// Physical or mental tiredness.
  fatigue,

  /// Automatic or established routine.
  habit,

  /// General sexual arousal.
  arousal,

  /// Social-media use.
  socialMedia,

  /// Relationship tension or difficulty.
  relationshipDifficulty,

  /// Alcohol or another substance.
  alcoholOrSubstance,

  /// Phone use around bedtime.
  bedtimePhone,

  /// A general trigger not covered by another value.
  other,
}

/// Broad emotion optionally associated with an urge or event.
enum EmotionType {
  /// Calm or neutral.
  calm,

  /// Bored.
  bored,

  /// Stressed.
  stressed,

  /// Lonely.
  lonely,

  /// Sad.
  sad,

  /// Angry.
  angry,

  /// Anxious.
  anxious,

  /// Tired.
  tired,

  /// Excited.
  excited,

  /// Frustrated.
  frustrated,

  /// An emotion not covered by another value.
  other,
}

/// User-reported result at the end of urge support.
enum UrgeOutcome {
  /// The urge passed without consumption.
  passed,

  /// The urge remained but became less intense.
  reduced,

  /// The decision was delayed.
  delayed,

  /// A consumption event occurred.
  consumed,

  /// The support flow was left without a result.
  abandoned,
}

/// Time horizon represented by a self-assessment.
///
/// Only a baseline is recorded for now. Periodic reassessment is on the
/// roadmap, so the kind is persisted rather than assumed.
enum AssessmentKind {
  /// Initial reference assessment, captured during onboarding.
  baseline,
}

/// Resolves an enum from its persisted [storedValue].
///
/// Throws a [FormatException] when the value is unknown. Reserved for the
/// places where an unreadable value really does invalidate the whole record,
/// such as a resumable onboarding draft. Reading history uses
/// [enumFromStoredValueOrNull] instead, so one unexpected row never takes a
/// complete screen down with it.
T enumFromStoredValue<T extends Enum>(List<T> values, String storedValue) => values.firstWhere(
  (value) => value.name == storedValue,
  orElse: () => throw FormatException(
    'Unknown persisted value for $T: $storedValue',
  ),
);

/// Resolves an enum from an optional [storedValue], or `null` when unknown.
T? enumFromStoredValueOrNull<T extends Enum>(List<T> values, String? storedValue) {
  if (storedValue == null) {
    return null;
  }
  for (T value in values) {
    if (value.name == storedValue) {
      return value;
    }
  }
  return null;
}
