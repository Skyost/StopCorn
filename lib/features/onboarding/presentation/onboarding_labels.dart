import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Returns the localized title for a goal [type].
String goalTitle(GoalType type) => switch (type) {
  .abstinence => t.goal.abstinence.title,
  .reduction => t.goal.reduction.title,
  .contextual => t.goal.contextual.title,
  .observation => t.goal.observation.title,
};

/// Returns the localized description for a goal [type].
String goalDescription(GoalType type) => switch (type) {
  .abstinence => t.goal.abstinence.description,
  .reduction => t.goal.reduction.description,
  .contextual => t.goal.contextual.description,
  .observation => t.goal.observation.description,
};

/// Returns the localized label for a [trigger].
String triggerLabel(TriggerType trigger) => switch (trigger) {
  .boredom => t.trigger.boredom,
  .stress => t.trigger.stress,
  .loneliness => t.trigger.loneliness,
  .fatigue => t.trigger.fatigue,
  .habit => t.trigger.habit,
  .arousal => t.trigger.arousal,
  .socialMedia => t.trigger.socialMedia,
  .relationshipDifficulty => t.trigger.relationshipDifficulty,
  .alcoholOrSubstance => t.trigger.alcoholOrSubstance,
  .bedtimePhone => t.trigger.bedtimePhone,
  .other => t.trigger.other,
};

/// Returns the localized label for an [emotion].
String emotionLabel(EmotionType emotion) => switch (emotion) {
  .calm => t.emotion.calm,
  .bored => t.emotion.bored,
  .stressed => t.emotion.stressed,
  .lonely => t.emotion.lonely,
  .sad => t.emotion.sad,
  .angry => t.emotion.angry,
  .anxious => t.emotion.anxious,
  .tired => t.emotion.tired,
  .excited => t.emotion.excited,
  .frustrated => t.emotion.frustrated,
  .other => t.emotion.other,
};

/// Returns the localized label for an urge [outcome].
String urgeOutcomeLabel(UrgeOutcome outcome) => switch (outcome) {
  .passed => t.outcome.passed,
  .reduced => t.outcome.reduced,
  .delayed => t.outcome.delayed,
  .consumed => t.outcome.consumed,
  .abandoned => t.outcome.abandoned,
};

/// Returns the localized title for a persisted strategy [id].
String strategyTitle(String id) => switch (id) {
  'put-phone-away' => t.strategy.putPhoneAway,
  'leave-room' => t.strategy.leaveRoom,
  'walk-five-minutes' => t.strategy.walkFiveMinutes,
  'slow-breathing' => t.strategy.slowBreathing,
  'water-and-switch' => t.strategy.waterAndSwitch,
  'message-someone' => t.strategy.messageSomeone,
  'two-minute-task' => t.strategy.twoMinuteTask,
  'take-shower' => t.strategy.takeShower,
  'wait-ten-minutes' => t.strategy.waitTenMinutes,
  _ => t.strategy.personal,
};

/// Returns the localized timer description for a persisted strategy [id].
String strategyDescription(String id) {
  int? seconds = strategySuggestedSeconds(id);
  if (seconds == null) {
    return t.strategy.genericDescription;
  }
  if (seconds < 60) {
    return t.strategy.timerSeconds(count: seconds);
  }
  return t.strategy.timerMinutes(count: seconds ~/ 60);
}

/// Returns the optional indicative countdown duration for strategy [id].
int? strategySuggestedSeconds(String id) => builtInStrategies.where((strategy) => strategy.id == id).firstOrNull?.suggestedSeconds;

/// Localized contextual goal options keyed by their stable storage value.
Map<String, String> get contextualOptions => {
  'late-evening': t.context.lateEvening,
  'bedroom': t.context.bedroom,
  'home-alone': t.context.homeAlone,
  'after-social-media': t.context.afterSocialMedia,
  'during-stress': t.context.duringStress,
};
