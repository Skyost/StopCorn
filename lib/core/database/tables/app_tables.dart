import 'package:drift/drift.dart';

/// Goal periods selected by the user, including inactive history.
class Goals extends Table {
  /// Stable UUID of the goal.
  TextColumn get id => text()();

  /// UTC creation timestamp.
  DateTimeColumn get createdAt => dateTime()();

  /// UTC timestamp of the latest update.
  DateTimeColumn get updatedAt => dateTime()();

  /// Persisted [GoalType] name.
  TextColumn get type => text()();

  /// Whether this is the single active goal.
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// Optional maximum events desired per week.
  IntColumn get weeklyLimit => integer().nullable()();

  /// JSON array of contexts covered by a contextual goal.
  TextColumn get contextKeysJson => text().nullable()();

  /// Optional user-written reason for pursuing the goal.
  TextColumn get motivation => text().nullable()();

  /// UTC timestamp at which the goal began.
  DateTimeColumn get startedAt => dateTime()();

  /// UTC timestamp at which the goal stopped being active.
  DateTimeColumn get endedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'urge_sessions_started_at', columns: {#startedAt})
/// Voluntarily recorded urge-support sessions.
class UrgeSessions extends Table {
  /// Stable UUID of the session.
  TextColumn get id => text()();

  /// UTC timestamp at which support began.
  DateTimeColumn get startedAt => dateTime()();

  /// UTC completion timestamp, or `null` for an abandoned session.
  DateTimeColumn get completedAt => dateTime().nullable()();

  /// Initial urge intensity on the zero-to-ten scale.
  IntColumn get initialIntensity => integer()();

  /// Optional intensity recorded at the end of the session.
  IntColumn get finalIntensity => integer().nullable()();

  /// Optional persisted [TriggerType] name.
  TextColumn get triggerType => text().nullable()();

  /// Optional persisted [EmotionType] name.
  TextColumn get emotionType => text().nullable()();

  /// Optional strategy selected during the session.
  TextColumn get copingStrategyId => text().nullable().references(
    CopingStrategies,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// Optional persisted [UrgeOutcome] name.
  TextColumn get outcome => text().nullable()();

  /// Optional free-form reflection entered by the user.
  TextColumn get notes => text().nullable()();

  /// Duration of the guided pause when it was completed.
  IntColumn get pauseDurationSeconds => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'consumption_events_occurred_at',
  columns: {#occurredAt},
)
/// Consumption events that the user explicitly chose to record.
class ConsumptionEvents extends Table {
  /// Stable UUID of the event.
  TextColumn get id => text()();

  /// UTC timestamp supplied for the event.
  DateTimeColumn get occurredAt => dateTime()();

  /// Optional persisted [TriggerType] name.
  TextColumn get triggerType => text().nullable()();

  /// Optional persisted [EmotionType] name.
  TextColumn get emotionType => text().nullable()();

  /// Optional general context written by the user.
  TextColumn get contextLabel => text().nullable()();

  /// JSON array of stable contextual-goal keys selected for this event.
  TextColumn get contextKeysJson => text().nullable()();

  /// Optional perceived-control score from zero to ten.
  IntColumn get perceivedControl => integer().nullable()();

  /// Optional free-form note.
  TextColumn get notes => text().nullable()();

  /// Optional urge session this event was recorded from.
  TextColumn get urgeSessionId => text().nullable().references(
    UrgeSessions,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// UTC timestamp at which the record was created.
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// At most one short self-observation per local calendar date.
class DailyCheckIns extends Table {
  /// Local date encoded as `yyyy-MM-dd`.
  TextColumn get localDate => text()();

  /// UTC creation timestamp.
  DateTimeColumn get createdAt => dateTime()();

  /// UTC timestamp of the latest update.
  DateTimeColumn get updatedAt => dateTime()();

  /// Mood score from zero to ten.
  IntColumn get moodScore => integer()();

  /// Perceived-control score from zero to ten.
  IntColumn get controlScore => integer()();

  /// Optional approximate number of urges that day.
  IntColumn get urgeCountEstimate => integer().nullable()();

  /// Optional sleep-quality score from zero to ten.
  IntColumn get sleepQuality => integer().nullable()();

  /// Optional free-form daily note.
  TextColumn get note => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {localDate};
}

@TableIndex(
  name: 'self_assessments_recorded_at',
  columns: {#recordedAt},
)
/// Periodic self-assessments used to compare broad progress markers.
class SelfAssessments extends Table {
  /// Stable UUID of the assessment.
  TextColumn get id => text()();

  /// UTC timestamp at which the assessment was recorded.
  DateTimeColumn get recordedAt => dateTime()();

  /// Persisted [AssessmentKind] name.
  TextColumn get kind => text()();

  /// Optional reported event frequency over seven days.
  IntColumn get weeklyFrequency => integer().nullable()();

  /// Perceived-control score from zero to ten.
  IntColumn get perceivedControl => integer()();

  /// Perceived negative-impact score from zero to ten.
  IntColumn get negativeImpact => integer()();

  /// Confidence-to-change score from zero to ten.
  IntColumn get confidenceToChange => integer()();

  /// Optional free-form reflection.
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Built-in and future custom strategies available during an urge.
class CopingStrategies extends Table {
  /// Stable strategy identifier.
  TextColumn get id => text()();

  /// Slang translation key for the strategy title.
  TextColumn get titleKey => text()();

  /// Slang translation key for the strategy description.
  TextColumn get descriptionKey => text()();

  /// General strategy category used for presentation and ordering.
  TextColumn get kind => text()();

  /// Whether the strategy ships with StopCorn.
  BoolColumn get isBuiltIn => boolean()();

  /// Whether the strategy may currently be suggested.
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  /// UTC timestamp at which the strategy record was created.
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'coping_strategy_uses_strategy_id',
  columns: {#strategyId},
)
@TableIndex(name: 'coping_strategy_uses_used_at', columns: {#usedAt})
/// Individual strategy uses and their optional perceived effect.
class CopingStrategyUses extends Table {
  /// Stable UUID of the use record.
  TextColumn get id => text()();

  /// Strategy that was used.
  TextColumn get strategyId => text().references(CopingStrategies, #id, onDelete: KeyAction.cascade)();

  /// UTC timestamp at which the strategy was tried.
  DateTimeColumn get usedAt => dateTime()();

  /// Optional urge session during which the strategy was used.
  TextColumn get urgeSessionId => text().nullable().references(
    UrgeSessions,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// Optional perceived effect on the minus-five-to-five scale.
  IntColumn get perceivedEffect => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Local reading and reflection progress for each learning module.
class ModuleProgress extends Table {
  /// Identifier matching a module in the bundled learning catalog.
  TextColumn get moduleId => text()();

  /// UTC timestamp at which the module was first opened.
  DateTimeColumn get startedAt => dateTime().nullable()();

  /// UTC timestamp at which the module was completed.
  DateTimeColumn get completedAt => dateTime().nullable()();

  /// Zero-based last section reached by the user.
  IntColumn get lastSectionIndex => integer().withDefault(const Constant(0))();

  /// Whether a completed module is currently being read again.
  BoolColumn get isReviewing => boolean().withDefault(const Constant(false))();

  /// Optional private reflection saved for the module.
  TextColumn get reflectionText => text().nullable()();

  /// UTC timestamp of the latest progress update.
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {moduleId};
}

@DataClassName('OnboardingDraftRecord')
/// Durable in-progress onboarding answers for interruption-safe setup.
class OnboardingDrafts extends Table {
  /// Singleton draft identifier.
  TextColumn get id => text()();

  /// UUID reserved for the goal created on completion.
  TextColumn get goalId => text()();

  /// UUID reserved for the baseline assessment.
  TextColumn get assessmentId => text()();

  /// Zero-based onboarding step last persisted.
  IntColumn get currentStep => integer().withDefault(const Constant(0))();

  /// Optional persisted [GoalType] name.
  TextColumn get goalType => text().nullable()();

  /// Optional weekly limit for a reduction goal.
  IntColumn get weeklyLimit => integer().nullable()();

  /// JSON array of selected contextual-goal keys.
  TextColumn get contextKeysJson => text().nullable()();

  /// Optional user-written motivation.
  TextColumn get motivation => text().nullable()();

  /// Approximate baseline frequency over seven days.
  IntColumn get baselineFrequency => integer().withDefault(const Constant(0))();

  /// Baseline perceived-control score.
  IntColumn get perceivedControl => integer().withDefault(const Constant(5))();

  /// Baseline negative-impact score.
  IntColumn get negativeImpact => integer().withDefault(const Constant(5))();

  /// Baseline confidence-to-change score.
  IntColumn get confidenceToChange => integer().withDefault(const Constant(5))();

  /// JSON array of selected coping-strategy identifiers.
  TextColumn get strategyIdsJson => text().nullable()();

  /// Whether the user opted into the local daily check-in reminder.
  BoolColumn get dailyCheckInReminderEnabled => boolean().withDefault(const Constant(false))();

  /// UTC timestamp of the latest draft update.
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
