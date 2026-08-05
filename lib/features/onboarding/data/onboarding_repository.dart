import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/onboarding/domain/onboarding_draft.dart';
import 'package:stopcorn/i18n/strings.g.dart';
import 'package:uuid/uuid.dart';

part 'onboarding_repository.g.dart';

/// Persists the interruption-safe draft and stages onboarding completion.
final class OnboardingRepository {
  /// Singleton key used for the sole in-progress draft.
  static const String _draftId = 'current';

  /// Local relational store for the draft and initial records.
  final AppDatabase _database;

  /// Simple durable setup flags and selections.
  final AppPreferences _preferences;

  /// Injectable clock used for deterministic timestamps.
  final AppClock _clock;

  /// Injectable source of local record identifiers.
  final Uuid _uuid;

  /// Creates a repository with deterministic clock and identifier sources.
  const OnboardingRepository(
    this._database,
    this._preferences,
    this._clock,
    this._uuid,
  );

  /// Restores the singleton draft or creates and persists a fresh one.
  Future<OnboardingDraft> loadOrCreateDraft() async {
    OnboardingDraftRecord? record = await (_database.select(
      _database.onboardingDrafts,
    )..where((draft) => draft.id.equals(_draftId))).getSingleOrNull();
    if (record != null) {
      return _fromRecord(record);
    }

    OnboardingDraft draft = OnboardingDraft.initial(
      goalId: _uuid.v4(),
      assessmentId: _uuid.v4(),
      currentStep: await _preferences.getOnboardingCurrentStep(),
    );
    await saveDraft(draft);
    return draft;
  }

  /// Upserts [draft] and its resumable step.
  Future<void> saveDraft(OnboardingDraft draft) async {
    await _database
        .into(_database.onboardingDrafts)
        .insertOnConflictUpdate(
          OnboardingDraftsCompanion.insert(
            id: _draftId,
            goalId: draft.goalId,
            assessmentId: draft.assessmentId,
            currentStep: Value<int>(draft.currentStep),
            goalType: Value<String?>(draft.goalType?.name),
            weeklyLimit: Value<int?>(draft.weeklyLimit),
            contextKeysJson: Value<String?>(
              draft.contextKeys.isEmpty ? null : jsonEncode(draft.contextKeys.toList()),
            ),
            motivation: Value<String?>(
              draft.motivation.trim().isEmpty ? null : draft.motivation.trim(),
            ),
            baselineFrequency: Value<int>(draft.baselineFrequency),
            perceivedControl: Value<int>(draft.perceivedControl),
            negativeImpact: Value<int>(draft.negativeImpact),
            confidenceToChange: Value<int>(draft.confidenceToChange),
            strategyIdsJson: Value<String?>(
              draft.strategyIds.isEmpty ? null : jsonEncode(draft.strategyIds.toList()),
            ),
            dailyCheckInReminderEnabled: Value<bool>(
              draft.dailyCheckInReminderEnabled,
            ),
            updatedAt: _clock.now().toUtc(),
          ),
        );
    await _preferences.setOnboardingCurrentStep(draft.currentStep);
  }

  /// Validates [draft] and idempotently writes its initial local data.
  ///
  /// The draft deliberately remains available and onboarding remains incomplete
  /// until external setup, such as reminder scheduling, has succeeded.
  Future<void> prepareCompletion(OnboardingDraft draft) async {
    _validate(draft);
    DateTime now = _clock.now().toUtc();

    await _preferences.setSelectedStrategyIds(draft.strategyIds.toList());
    await _preferences.setDailyCheckInReminderEnabled(
      draft.dailyCheckInReminderEnabled,
    );

    await _database.transaction(() async {
      await (_database.update(
        _database.goals,
      )..where((goal) => goal.isActive.equals(true))).write(
        GoalsCompanion(
          isActive: const Value<bool>(false),
          endedAt: Value<DateTime?>(now),
          updatedAt: Value<DateTime>(now),
        ),
      );

      await _database
          .into(_database.goals)
          .insertOnConflictUpdate(
            GoalsCompanion.insert(
              id: draft.goalId,
              createdAt: now,
              updatedAt: now,
              type: draft.goalType!.name,
              isActive: const Value<bool>(true),
              weeklyLimit: Value<int?>(
                draft.goalType == .reduction ? draft.weeklyLimit : null,
              ),
              contextKeysJson: Value<String?>(
                draft.goalType == .contextual ? jsonEncode(draft.contextKeys.toList()) : null,
              ),
              motivation: Value<String?>(
                draft.motivation.trim().isEmpty ? null : draft.motivation.trim(),
              ),
              startedAt: now,
              endedAt: const Value<DateTime?>(null),
            ),
          );

      await _database
          .into(_database.selfAssessments)
          .insertOnConflictUpdate(
            SelfAssessmentsCompanion.insert(
              id: draft.assessmentId,
              recordedAt: now,
              kind: AssessmentKind.baseline.name,
              weeklyFrequency: Value<int?>(draft.baselineFrequency),
              perceivedControl: draft.perceivedControl,
              negativeImpact: draft.negativeImpact,
              confidenceToChange: draft.confidenceToChange,
            ),
          );
    });
  }

  /// Marks a successfully prepared onboarding as complete and cleans its draft.
  Future<void> finishCompletion() async {
    await _preferences.setOnboardingCurrentStep(
      AppRoutes.onboarding.length - 1,
    );
    await _preferences.setOnboardingCompleted(true);
    try {
      await (_database.delete(
        _database.onboardingDrafts,
      )..where((record) => record.id.equals(_draftId))).go();
    } catch (_) {
      // Completion is the durable commit. A stale, now-unused draft must not
      // turn a successful setup into an error after external setup succeeded.
    }
  }

  /// Maps the Drift [record] into the domain draft.
  OnboardingDraft _fromRecord(OnboardingDraftRecord record) => OnboardingDraft(
    goalId: record.goalId,
    assessmentId: record.assessmentId,
    currentStep: record.currentStep,
    goalType: record.goalType == null ? null : enumFromStoredValue(GoalType.values, record.goalType!),
    weeklyLimit: record.weeklyLimit,
    contextKeys: _decodeStrings(record.contextKeysJson).toSet(),
    motivation: record.motivation ?? '',
    baselineFrequency: record.baselineFrequency,
    perceivedControl: record.perceivedControl,
    negativeImpact: record.negativeImpact,
    confidenceToChange: record.confidenceToChange,
    strategyIds: _decodeStrings(record.strategyIdsJson).toSet(),
    dailyCheckInReminderEnabled: record.dailyCheckInReminderEnabled,
  );

  /// Decodes a nullable JSON string array from the durable draft.
  List<String> _decodeStrings(String? value) {
    if (value == null) {
      return [];
    }
    Object? decoded = jsonDecode(value);
    if (decoded is! List<Object?>) {
      throw FormatException(t.onboarding.error.invalidDraft);
    }
    return decoded.map((item) {
      if (item is! String) {
        throw FormatException(t.onboarding.error.invalidDraft);
      }
      return item;
    }).toList();
  }

  /// Enforces all fields required before onboarding completion.
  void _validate(OnboardingDraft draft) {
    if (draft.goalType == null) {
      throw FormatException(t.onboarding.validation.goal);
    }
    if (draft.goalType == .reduction && (draft.weeklyLimit == null || draft.weeklyLimit! <= 0)) {
      throw FormatException(t.onboarding.validation.weeklyLimit);
    }
    if (draft.goalType == .contextual && draft.contextKeys.isEmpty) {
      throw FormatException(t.onboarding.validation.context);
    }
    if (draft.strategyIds.isEmpty) {
      throw FormatException(t.onboarding.validation.strategy);
    }
    for (int score in [
      draft.perceivedControl,
      draft.negativeImpact,
      draft.confidenceToChange,
    ]) {
      if (score < 0 || score > 10) {
        throw FormatException(t.onboarding.validation.scoreRange);
      }
    }
  }
}

/// Provides the database-backed onboarding repository.
@Riverpod(keepAlive: true)
OnboardingRepository onboardingRepository(Ref ref) => OnboardingRepository(
  ref.watch(appDatabaseProvider),
  ref.watch(appPreferencesProvider),
  ref.watch(appClockProvider),
  ref.watch(uuidProvider),
);
