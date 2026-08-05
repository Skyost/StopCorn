import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/app/presentation/splash_screen.dart';
import 'package:stopcorn/app/widgets/main_shell.dart';
import 'package:stopcorn/features/check_in/presentation/daily_check_in_screen.dart';
import 'package:stopcorn/features/consumption/presentation/log_consumption_screen.dart';
import 'package:stopcorn/features/data_export/presentation/data_export_screen.dart';
import 'package:stopcorn/features/goals/presentation/goal_history_screen.dart';
import 'package:stopcorn/features/home/presentation/home_screen.dart';
import 'package:stopcorn/features/journal/presentation/journal_screen.dart';
import 'package:stopcorn/features/learning/presentation/learning_screen.dart';
import 'package:stopcorn/features/learning/presentation/module_screen.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_screen.dart';
import 'package:stopcorn/features/progress/presentation/initial_profile_screen.dart';
import 'package:stopcorn/features/progress/presentation/progress_screen.dart';
import 'package:stopcorn/features/settings/presentation/licenses_screen.dart';
import 'package:stopcorn/features/settings/presentation/settings_screen.dart';
import 'package:stopcorn/features/urge/presentation/urge_intensity_screen.dart';
import 'package:stopcorn/features/urge/presentation/urge_pause_screen.dart';
import 'package:stopcorn/features/urge/presentation/urge_result_screen.dart';
import 'package:stopcorn/features/urge/presentation/urge_strategy_screen.dart';
import 'package:stopcorn/features/urge/presentation/urge_support_choice_screen.dart';

part 'router.g.dart';

/// Stable page identity that preserves onboarding progress animations.
const ValueKey<String> _onboardingPageKey = ValueKey<String>('onboarding');

/// Creates the application router and enforces onboarding redirects.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  AsyncValue<BootstrapData> bootstrap = ref.watch(bootstrapControllerProvider);
  GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) {
      String location = state.uri.path;
      BootstrapData? data = switch (bootstrap) {
        AsyncData<BootstrapData>(:BootstrapData value) => value,
        _ => null,
      };

      if (data == null) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }

      bool onboardingRoute = location.startsWith(AppRoutes.onboardingPrefix);
      if (!data.onboardingCompleted) {
        if (onboardingRoute) {
          return null;
        }
        int step = data.onboardingCurrentStep.clamp(
          0,
          AppRoutes.onboarding.length - 1,
        );
        String expected = AppRoutes.onboarding[step];
        return location == expected ? null : expected;
      }

      if (location == AppRoutes.splash || onboardingRoute) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      for (final (int index, String route) in AppRoutes.onboarding.indexed)
        GoRoute(
          path: route,
          pageBuilder: (context, state) => NoTransitionPage(
            key: _onboardingPageKey,
            child: OnboardingScreen(step: index),
          ),
        ),
      GoRoute(
        path: AppRoutes.onboardingTriggers,
        redirect: (context, state) => AppRoutes.onboardingStrategies,
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(
          location: state.uri.path,
          child: child,
        ),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.progress,
            builder: (context, state) => const ProgressScreen(),
          ),
          GoRoute(
            path: AppRoutes.learn,
            builder: (context, state) => const LearningScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.urge,
        builder: (context, state) => const UrgeIntensityScreen(),
      ),
      GoRoute(
        path: AppRoutes.urgeOptions,
        builder: (context, state) => const UrgeSupportChoiceScreen(),
      ),
      GoRoute(
        path: AppRoutes.urgePause,
        builder: (context, state) => const UrgePauseScreen(),
      ),
      GoRoute(
        path: AppRoutes.urgePlan,
        builder: (context, state) => const UrgeStrategyScreen(
          path: .backupPlan,
        ),
      ),
      GoRoute(
        path: AppRoutes.urgeIdeas,
        builder: (context, state) => const UrgeStrategyScreen(
          path: .otherIdeas,
        ),
      ),
      GoRoute(
        path: AppRoutes.urgeStrategy,
        redirect: (context, state) => AppRoutes.urgeOptions,
      ),
      GoRoute(
        path: AppRoutes.urgeResult,
        builder: (context, state) => const UrgeResultScreen(),
      ),
      GoRoute(
        path: AppRoutes.journal,
        builder: (context, state) => const JournalScreen(),
      ),
      GoRoute(
        path: AppRoutes.logConsumption,
        builder: (context, state) => LogConsumptionScreen(
          urgeSessionId: state.uri.queryParameters[AppRoutes.urgeSessionIdParameter],
          eventId: state.uri.queryParameters[AppRoutes.eventIdParameter],
        ),
      ),
      GoRoute(
        path: AppRoutes.checkIn,
        builder: (context, state) => DailyCheckInScreen(
          requestedDate: state.uri.queryParameters[AppRoutes.checkInDateParameter],
        ),
      ),
      GoRoute(
        path: AppRoutes.initialProfile,
        builder: (context, state) => const InitialProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.goalHistory,
        builder: (context, state) => const GoalHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.dataExport,
        builder: (context, state) => const DataExportScreen(),
      ),
      GoRoute(
        path: AppRoutes.licenses,
        builder: (context, state) => const LicensesScreen(),
      ),
      GoRoute(
        path: AppRoutes.modulePattern,
        builder: (context, state) => ModuleScreen(moduleId: state.pathParameters['moduleId']!),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}
