/// Centralizes every application route and builds parameterized locations.
abstract final class AppRoutes {
  /// Bootstrap loading screen.
  static const String splash = '/splash';

  /// First onboarding screen.
  static const String onboardingWelcome = '/onboarding/welcome';

  /// Goal onboarding screen.
  static const String onboardingGoal = '/onboarding/goal';

  /// Baseline onboarding screen.
  static const String onboardingBaseline = '/onboarding/baseline';

  /// Strategy onboarding screen.
  static const String onboardingStrategies = '/onboarding/strategies';

  /// Privacy onboarding screen.
  static const String onboardingPrivacy = '/onboarding/privacy';

  /// Legacy trigger onboarding location retained as a redirect.
  static const String onboardingTriggers = '/onboarding/triggers';

  /// Prefix shared by every onboarding location.
  static const String onboardingPrefix = '/onboarding/';

  /// Ordered onboarding locations matching persisted step indices.
  static const List<String> onboarding = [
    onboardingWelcome,
    onboardingGoal,
    onboardingBaseline,
    onboardingStrategies,
    onboardingPrivacy,
  ];

  /// Home destination.
  static const String home = '/home';

  /// Progress destination.
  static const String progress = '/progress';

  /// Initial onboarding profile displayed from the progress dashboard.
  static const String initialProfile = '/progress/initial-profile';

  /// Learning-library destination.
  static const String learn = '/learn';

  /// Settings destination.
  static const String settings = '/settings';

  /// Ordered locations displayed by the bottom navigation bar.
  static const List<String> primaryDestinations = [
    home,
    progress,
    learn,
    settings,
  ];

  /// Initial impulse-support screen.
  static const String urge = '/urge';

  /// Support-path choice screen.
  static const String urgeOptions = '/urge/options';

  /// Guided-pause screen.
  static const String urgePause = '/urge/pause';

  /// Backup-plan strategy screen.
  static const String urgePlan = '/urge/plan';

  /// Alternative-strategy screen.
  static const String urgeIdeas = '/urge/ideas';

  /// Legacy strategy location retained as a redirect.
  static const String urgeStrategy = '/urge/strategy';

  /// Impulse reassessment screen.
  static const String urgeResult = '/urge/result';

  /// Combined consumption and check-in journal.
  static const String journal = '/journal';

  /// Consumption recording screen.
  static const String logConsumption = '/log-consumption';

  /// Query parameter linking a consumption event to a support session.
  static const String urgeSessionIdParameter = 'urgeSessionId';

  /// Query parameter selecting the consumption event being corrected.
  static const String eventIdParameter = 'eventId';

  /// Daily check-in screen.
  static const String checkIn = '/check-in';

  /// Query parameter selecting the local date of an edited check-in.
  static const String checkInDateParameter = 'date';

  /// Goal history screen.
  static const String goalHistory = '/settings/goals';

  /// Data-export screen.
  static const String dataExport = '/data/export';

  /// Open-source license screen.
  static const String licenses = '/licenses';

  /// Learning-module route pattern used by GoRouter.
  static const String modulePattern = '/module/:moduleId';

  /// Builds the location for the learning module identified by [moduleId].
  static String module(String moduleId) => '/module/${Uri.encodeComponent(moduleId)}';

  /// Builds a consumption location optionally linked to [urgeSessionId].
  static String logConsumptionFor(String? urgeSessionId) => urgeSessionId == null || urgeSessionId.isEmpty
      ? logConsumption
      : Uri(
          path: logConsumption,
          queryParameters: {
            urgeSessionIdParameter: urgeSessionId,
          },
        ).toString();

  /// Builds the location correcting the consumption event [eventId].
  static String editConsumption(String eventId) => Uri(
    path: logConsumption,
    queryParameters: {eventIdParameter: eventId},
  ).toString();

  /// Builds the location editing the check-in recorded on [localDate].
  static String checkInOn(String localDate) => Uri(
    path: checkIn,
    queryParameters: {checkInDateParameter: localDate},
  ).toString();
}
