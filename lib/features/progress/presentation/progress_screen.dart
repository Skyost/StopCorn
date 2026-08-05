import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_page_viewport.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/harvest/application/harvest_providers.dart';
import 'package:stopcorn/features/harvest/domain/harvest_summary.dart';
import 'package:stopcorn/features/progress/application/progress_dashboard_provider.dart';
import 'package:stopcorn/features/progress/domain/progress_dashboard.dart';
import 'package:stopcorn/features/progress/domain/progress_period.dart';
import 'package:stopcorn/features/progress/presentation/progress_dashboard_sections.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays descriptive progress aggregates from voluntary local records.
final class ProgressScreen extends ConsumerWidget {
  /// Creates the progress dashboard.
  const ProgressScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProgressPeriod selectedPeriod = ref.watch(progressPeriodControllerProvider).value ?? .thirtyDays;
    AsyncValue<ProgressDashboard> dashboard = ref.watch(
      progressDashboardProvider,
    );
    bool showHarvest = ref.watch(harvestVisibilityProvider).value ?? false;
    HarvestSummary? harvest = showHarvest ? ref.watch(harvestSummaryProvider).value : null;

    return AppPageList(
      children: [
        AppSubtitle(text: context.t.progress.subtitle),
        const SizedBox(height: AppSpacing.section),
        Wrap(
          spacing: AppSpacing.medium,
          runSpacing: AppSpacing.medium,
          children: [
            for (final ProgressPeriod period in ProgressPeriod.values)
              AppButton(
                key: Key('progress_period_${period.storageKey}'),
                size: .sm,
                variant: selectedPeriod == period ? .primary : .outline,
                onPress: () => ref.read(progressPeriodControllerProvider.notifier).select(period),
                child: Text(period.label),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        ...dashboard.when(
          loading: () => const [AsyncStatePanel(child: LoadingState())],
          error: (error, _) => [
            AsyncStatePanel(
              child: ErrorState(
                message: context.t.progress.error.load,
                error: error,
                onRetry: () => ref.invalidate(progressDashboardProvider),
              ),
            ),
          ],
          data: (value) => progressDashboardSections(context, value, harvest),
        ),
      ],
    );
  }
}
