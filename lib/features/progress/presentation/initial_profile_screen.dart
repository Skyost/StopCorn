import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_page.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/features/progress/application/progress_dashboard_provider.dart';
import 'package:stopcorn/features/progress/domain/initial_profile.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays the immutable answers captured during initial setup.
final class InitialProfileScreen extends ConsumerWidget {
  /// Creates the initial-profile detail screen.
  const InitialProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<InitialProfile?> profile = ref.watch(initialProfileProvider);
    return AppPage(
      title: Text(context.t.progress.startingPoint.screenTitle),
      showBackButton: true,
      backFallbackLocation: AppRoutes.progress,
      child: profile.when(
        loading: () => const AsyncStatePanel(child: LoadingState()),
        error: (error, _) => AsyncStatePanel(
          child: ErrorState(
            message: context.t.progress.startingPoint.error,
            error: error,
            onRetry: () => ref.invalidate(initialProfileProvider),
          ),
        ),
        data: (value) => value == null
            ? _EmptyInitialProfile(
                message: context.t.progress.startingPoint.empty,
              )
            : _InitialProfileContent(profile: value),
      ),
    );
  }
}

/// Presents all available parts of one initial profile.
final class _InitialProfileContent extends StatelessWidget {
  /// Persisted initial answers and goal context.
  final InitialProfile profile;

  /// Creates loaded initial-profile content.
  const _InitialProfileContent({
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.yMMMMd(
      LocaleSettings.currentLocale.languageCode,
    ).format(profile.recordedAt.toLocal());
    String motivation = profile.motivation?.trim() ?? '';
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        AppSubtitle(text: context.t.progress.startingPoint.intro),
        const SizedBox(height: AppSpacing.big),
        AppCard(
          child: Row(
            crossAxisAlignment: .start,
            children: [
              const Icon(FLucideIcons.clipboardCheck),
              const SizedBox(width: AppSpacing.medium),
              Expanded(
                child: Text(
                  context.t.progress.startingPoint.recordedOn(date: date),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          title: Text(context.t.progress.startingPoint.goalTitle),
        ),
        _InitialGoalCard(profile: profile),
        if (motivation.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.big),
          AppCard(
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  context.t.progress.startingPoint.motivationTitle,
                  style: context.theme.typography.body.lg.copyWith(
                    fontWeight: .w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                Text(motivation),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          title: Text(context.t.progress.startingPoint.markersTitle),
        ),
        FTileGroup(
          children: [
            FTile(
              key: const Key('initial_profile_frequency'),
              prefix: const Icon(FLucideIcons.activity),
              title: Text(context.t.progress.startingPoint.frequency),
              suffix: Text(
                profile.weeklyFrequency == null
                    ? context.t.app.unknown
                    : context.t.progress.startingPoint.frequencyValue(
                        count: profile.weeklyFrequency!,
                      ),
              ),
            ),
            _scoreTile(
              context,
              key: const Key('initial_profile_control'),
              label: context.t.progress.startingPoint.control,
              value: profile.perceivedControl,
            ),
            _scoreTile(
              context,
              key: const Key('initial_profile_impact'),
              label: context.t.progress.startingPoint.impact,
              value: profile.negativeImpact,
            ),
            _scoreTile(
              context,
              key: const Key('initial_profile_confidence'),
              label: context.t.progress.startingPoint.confidence,
              value: profile.confidenceToChange,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.big),
        AppSubtitle(text: context.t.progress.startingPoint.disclaimer),
      ],
    );
  }

  /// Builds one consistently formatted zero-to-ten marker tile.
  FTile _scoreTile(
    BuildContext context, {
    required Key key,
    required String label,
    required int value,
  }) => FTile(
    key: key,
    prefix: const Icon(FLucideIcons.circleGauge),
    title: Text(label),
    suffix: Text(
      context.t.progress.startingPoint.score(value: value),
    ),
  );
}

/// Summarizes the goal that accompanied the baseline assessment.
final class _InitialGoalCard extends StatelessWidget {
  /// Initial profile containing the optional historical goal.
  final InitialProfile profile;

  /// Creates the initial-goal summary.
  const _InitialGoalCard({
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    GoalType? type = profile.goalType;
    if (type == null) {
      return AppCard(
        child: Text(context.t.progress.startingPoint.goalUnavailable),
      );
    }
    List<String> details = [];
    if (type == .reduction && profile.weeklyLimit != null) {
      details.add(
        context.t.progress.startingPoint.weeklyLimit(
          count: profile.weeklyLimit!,
        ),
      );
    }
    if (type == .contextual && profile.contextKeys.isNotEmpty) {
      String contexts = profile.contextKeys.map((key) => contextualOptions[key] ?? key).join(', ');
      details.add(
        context.t.progress.startingPoint.contexts(contexts: contexts),
      );
    }
    return FTileGroup(
      children: [
        FTile(
          key: const Key('initial_profile_goal'),
          prefix: const Icon(FLucideIcons.target),
          title: Text(goalTitle(type)),
          subtitle: AppTileSubtitle(
            child: Text(
              [goalDescription(type), ...details].join('\n'),
            ),
          ),
        ),
      ],
    );
  }
}

/// Displays a centered absence state for legacy or incomplete local data.
final class _EmptyInitialProfile extends StatelessWidget {
  /// User-facing explanation.
  final String message;

  /// Creates an empty initial-profile state.
  const _EmptyInitialProfile({
    required this.message,
  });

  @override
  Widget build(BuildContext context) => AsyncStatePanel(
    child: Center(
      child: Column(
        mainAxisSize: .min,
        children: [
          const Icon(FLucideIcons.clipboardCheck, size: AppIconSize.display),
          const SizedBox(height: AppSpacing.big),
          Text(message, textAlign: .center),
        ],
      ),
    ),
  );
}
