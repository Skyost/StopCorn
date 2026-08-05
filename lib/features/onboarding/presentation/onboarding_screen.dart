import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_page.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/check_in/application/daily_check_in_reminder_service.dart';
import 'package:stopcorn/features/onboarding/application/onboarding_controller.dart';
import 'package:stopcorn/features/onboarding/domain/onboarding_draft.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_steps.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays one persisted step of the first-run setup.
final class OnboardingScreen extends ConsumerWidget {
  /// Zero-based step displayed by this route.
  final int step;

  /// Creates the onboarding screen for [step].
  const OnboardingScreen({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<OnboardingViewState> state = ref.watch(
      onboardingControllerProvider,
    );
    return state.when(
      loading: () => AppPage(
        title: Text(context.t.onboarding.pageTitle),
        child: const AsyncStatePanel(child: LoadingState()),
      ),
      error: (error, _) => AppPage(
        title: Text(context.t.onboarding.pageTitle),
        child: AsyncStatePanel(
          child: ErrorState(
            message: context.t.onboarding.error.load,
            error: error,
            onRetry: () => ref.invalidate(onboardingControllerProvider),
          ),
        ),
      ),
      data: (viewState) => _buildReady(context, ref, viewState),
    );
  }

  /// Builds the loaded step with its shared heading and navigation.
  Widget _buildReady(
    BuildContext context,
    WidgetRef ref,
    OnboardingViewState viewState,
  ) {
    OnboardingController controller = ref.read(
      onboardingControllerProvider.notifier,
    );
    OnboardingDraft draft = viewState.draft;
    return AppPage(
      title: Text(context.t.onboarding.pageTitle),
      footer: SafeArea(
        top: false,
        child: Padding(
          padding: const .fromLTRB(
            AppSpacing.page,
            AppSpacing.medium,
            AppSpacing.page,
            AppSpacing.page,
          ),
          child: IntrinsicHeight(
            child: _navigation(context, controller, viewState),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Semantics(
            label: context.t.onboarding.step(
              current: step + 1,
              total: AppRoutes.onboarding.length,
            ),
            child: FDeterminateProgress(
              value: (step + 1) / AppRoutes.onboarding.length,
            ),
          ),
          const SizedBox(height: AppSpacing.medium),
          AppSubtitle(
            text: context.t.onboarding.step(
              current: step + 1,
              total: AppRoutes.onboarding.length,
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          _stepBody(
            context,
            controller,
            draft,
            reminderSupported: ref
                .watch(
                  dailyCheckInReminderServiceProvider,
                )
                .isSupported,
          ),
          if (viewState.errorMessage != null) ...[
            const SizedBox(height: AppSpacing.big),
            Row(
              crossAxisAlignment: .start,
              children: [
                const Icon(FLucideIcons.circleAlert),
                const SizedBox(width: AppSpacing.medium),
                Expanded(child: Text(viewState.errorMessage!)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// Selects the body corresponding to the requested onboarding step.
  Widget _stepBody(
    BuildContext context,
    OnboardingController controller,
    OnboardingDraft draft, {
    required bool reminderSupported,
  }) => switch (step) {
    0 => const OnboardingWelcomeStep(),
    1 => OnboardingGoalStep(controller: controller, draft: draft),
    2 => OnboardingBaselineStep(controller: controller, draft: draft),
    3 => OnboardingStrategiesStep(controller: controller, draft: draft),
    _ => OnboardingPrivacyStep(
      controller: controller,
      draft: draft,
      reminderSupported: reminderSupported,
    ),
  };

  /// Builds step-aware back and continue actions.
  Widget _navigation(
    BuildContext context,
    OnboardingController controller,
    OnboardingViewState state,
  ) {
    bool canContinue = _canContinue(state.draft);
    return Row(
      children: [
        if (step > 0)
          Expanded(
            child: AppButton(
              variant: .outline,
              onPress: state.isSaving ? null : () => _move(context, controller, step - 1),
              child: Text(t.app.back),
            ),
          ),
        if (step > 0) const SizedBox(width: AppSpacing.medium),
        Expanded(
          flex: 2,
          child: AppButton(
            key: const Key('onboarding_primary_action'),
            onPress: state.isSaving || !canContinue ? null : () => step == AppRoutes.onboarding.length - 1 ? _complete(context, controller) : _move(context, controller, step + 1),
            child: Text(
              state.isSaving
                  ? t.app.saving
                  : step == 0
                  ? t.onboarding.start
                  : step == AppRoutes.onboarding.length - 1
                  ? t.onboarding.finish
                  : t.app.continueLabel,
            ),
          ),
        ),
      ],
    );
  }

  /// Reports whether the current step contains its required answer.
  bool _canContinue(OnboardingDraft draft) {
    if (step == 1) {
      if (draft.goalType == null) {
        return false;
      }
      if (draft.goalType == .reduction) {
        return (draft.weeklyLimit ?? 0) > 0;
      }
      if (draft.goalType == .contextual) {
        return draft.contextKeys.isNotEmpty;
      }
    }
    if (step == 3) {
      return draft.strategyIds.isNotEmpty;
    }
    return true;
  }

  /// Persists [targetStep] before routing to it.
  Future<void> _move(
    BuildContext context,
    OnboardingController controller,
    int destination,
  ) async {
    bool saved = await controller.saveAndMoveTo(destination);
    if (saved && context.mounted) {
      context.go(AppRoutes.onboarding[destination]);
    }
  }

  /// Completes setup and lets the router enter the home screen.
  Future<void> _complete(
    BuildContext context,
    OnboardingController controller,
  ) async {
    bool completed = await controller.complete();
    if (completed && context.mounted) {
      context.go(AppRoutes.home);
    }
  }
}
