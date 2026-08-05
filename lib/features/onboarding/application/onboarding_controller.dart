import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/core/diagnostics/error_reporter.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/check_in/application/daily_check_in_reminder_service.dart';
import 'package:stopcorn/features/onboarding/data/onboarding_repository.dart';
import 'package:stopcorn/features/onboarding/domain/onboarding_draft.dart';
import 'package:stopcorn/i18n/strings.g.dart';

part 'onboarding_controller.g.dart';

/// Owns the resumable onboarding draft and its persistence.
@Riverpod(keepAlive: true)
final class OnboardingController extends _$OnboardingController {
  @override
  Future<OnboardingViewState> build() async {
    OnboardingDraft draft = await ref.watch(onboardingRepositoryProvider).loadOrCreateDraft();
    return OnboardingViewState(draft: draft);
  }

  /// Selects [type] and clears fields that do not apply to it.
  void selectGoal(GoalType type) {
    _update(
      (draft) => draft.copyWith(
        goalType: type,
        clearWeeklyLimit: type != .reduction,
        contextKeys: type == .contextual ? draft.contextKeys : const {},
      ),
    );
  }

  /// Updates or clears the optional weekly limit.
  void setWeeklyLimit(int? value) {
    _update(
      (draft) => value == null ? draft.copyWith(clearWeeklyLimit: true) : draft.copyWith(weeklyLimit: value),
    );
  }

  /// Updates the optional personal motivation.
  void setMotivation(String value) {
    _update((draft) => draft.copyWith(motivation: value));
  }

  /// Toggles a general contextual-goal [key].
  void toggleContext(String key) {
    _update((draft) {
      Set<String> values = draft.contextKeys.toSet();
      values.contains(key) ? values.remove(key) : values.add(key);
      return draft.copyWith(contextKeys: values);
    });
  }

  /// Updates the approximate seven-day baseline frequency.
  void setBaselineFrequency(int value) {
    _update((draft) => draft.copyWith(baselineFrequency: value.clamp(0, 99)));
  }

  /// Updates the baseline perceived-control score.
  void setPerceivedControl(int value) {
    _update((draft) => draft.copyWith(perceivedControl: value.clamp(0, 10)));
  }

  /// Updates the baseline perceived-impact score.
  void setNegativeImpact(int value) {
    _update((draft) => draft.copyWith(negativeImpact: value.clamp(0, 10)));
  }

  /// Updates the baseline confidence-to-change score.
  void setConfidenceToChange(int value) {
    _update((draft) => draft.copyWith(confidenceToChange: value.clamp(0, 10)));
  }

  /// Toggles the coping strategy identified by [id].
  void toggleStrategy(String id) {
    _update((draft) {
      Set<String> values = draft.strategyIds.toSet();
      values.contains(id) ? values.remove(id) : values.add(id);
      return draft.copyWith(strategyIds: values);
    });
  }

  /// Updates the opt-in daily check-in reminder preference in the draft.
  void setDailyCheckInReminderEnabled(bool value) {
    _update(
      (draft) => draft.copyWith(dailyCheckInReminderEnabled: value),
    );
  }

  /// Persists the draft at [step] before navigation continues.
  Future<bool> saveAndMoveTo(int step) async {
    OnboardingViewState current = _current;
    OnboardingDraft draft = current.draft.copyWith(currentStep: step);
    state = AsyncData<OnboardingViewState>(
      current.copyWith(draft: draft, isSaving: true, clearError: true),
    );
    try {
      await ref.read(onboardingRepositoryProvider).saveDraft(draft);
      state = AsyncData<OnboardingViewState>(OnboardingViewState(draft: draft));
      return true;
    } catch (error, stackTrace) {
      ref.reportFailure(error, stackTrace, operation: 'onboarding.save_draft');
      state = AsyncData<OnboardingViewState>(
        current.copyWith(
          isSaving: false,
          errorMessage: t.onboarding.error.save,
        ),
      );
      return false;
    }
  }

  /// Validates the draft and completes every required setup step.
  Future<bool> complete() async {
    OnboardingViewState current = _current;
    state = AsyncData<OnboardingViewState>(
      current.copyWith(isSaving: true, clearError: true),
    );
    try {
      if (current.draft.dailyCheckInReminderEnabled) {
        DailyCheckInReminderResult permission = await ref.read(dailyCheckInReminderServiceProvider).requestPermission();
        if (permission != .enabled) {
          state = AsyncData<OnboardingViewState>(
            current.copyWith(
              isSaving: false,
              errorMessage: _reminderError(permission),
            ),
          );
          return false;
        }
      }
      OnboardingRepository repository = ref.read(
        onboardingRepositoryProvider,
      );
      await repository.prepareCompletion(current.draft);
      DailyCheckInReminderResult reminder = await ref.read(dailyCheckInReminderServiceProvider).synchronize();
      if (current.draft.dailyCheckInReminderEnabled && reminder != .enabled) {
        await ref.read(dailyCheckInReminderServiceProvider).setEnabled(false);
        state = AsyncData<OnboardingViewState>(
          current.copyWith(
            isSaving: false,
            errorMessage: _reminderError(reminder),
          ),
        );
        return false;
      }
      await repository.finishCompletion();
      ref.invalidate(bootstrapControllerProvider);
      state = AsyncData<OnboardingViewState>(
        current.copyWith(isSaving: false, clearError: true),
      );
      return true;
    } on FormatException catch (error) {
      state = AsyncData<OnboardingViewState>(
        current.copyWith(isSaving: false, errorMessage: error.message),
      );
      return false;
    } catch (error, stackTrace) {
      ref.reportFailure(error, stackTrace, operation: 'onboarding.complete');
      state = AsyncData<OnboardingViewState>(
        current.copyWith(
          isSaving: false,
          errorMessage: t.onboarding.error.complete,
        ),
      );
      return false;
    }
  }

  /// Returns the loaded view state or reports premature access.
  OnboardingViewState get _current => switch (state) {
    AsyncData<OnboardingViewState>(:OnboardingViewState value) => value,
    _ => throw StateError(t.onboarding.error.notReady),
  };

  /// Maps a reminder result to actionable onboarding feedback.
  String _reminderError(DailyCheckInReminderResult result) => switch (result) {
    .permissionDenied => t.onboarding.privacy.reminderPermissionDenied,
    .unsupported => t.onboarding.privacy.reminderUnavailable,
    _ => t.onboarding.privacy.reminderError,
  };

  /// Applies a synchronous mutation to the loaded draft.
  void _update(OnboardingDraft Function(OnboardingDraft) update) {
    OnboardingViewState current = _current;
    state = AsyncData<OnboardingViewState>(
      current.copyWith(draft: update(current.draft), clearError: true),
    );
  }
}
