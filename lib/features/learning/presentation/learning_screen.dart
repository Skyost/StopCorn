import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_page_viewport.dart';
import 'package:stopcorn/app/widgets/app_selection_checkbox.dart';
import 'package:stopcorn/app/widgets/app_sheet.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/utils/app_number.dart';
import 'package:stopcorn/features/learning/application/module_controller.dart';
import 'package:stopcorn/features/learning/domain/learning_library_item.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays the offline learning module library.
final class LearningScreen extends ConsumerWidget {
  /// Creates the learning library.
  const LearningScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<LearningLibraryItem>> library = ref.watch(
      learningLibraryProvider,
    );
    return AppPageList(
      children: [
        AppSubtitle(text: context.t.learning.subtitle),
        const SizedBox(height: AppSpacing.section),
        library.when(
          loading: () => const AsyncStatePanel(child: LoadingState()),
          error: (error, _) => AsyncStatePanel(
            child: ErrorState(
              message: context.t.learning.error.load,
              error: error,
              onRetry: () => ref.invalidate(learningLibraryProvider),
            ),
          ),
          data: (items) => Column(
            crossAxisAlignment: .stretch,
            children: [
              _ModuleList(items: items),
              const SizedBox(height: AppSpacing.big),
              Align(
                alignment: .bottomRight,
                child: AppButton(
                  key: const Key('learning_evidence_button'),
                  size: .xs,
                  variant: .ghost,
                  mainAxisSize: .min,
                  onPress: () => _showEvidenceInformation(context),
                  child: Text(context.t.learning.evidence.title),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Explains the scientific scope and limitations of the learning content.
Future<void> _showEvidenceInformation(BuildContext context) => showAppSheet<void>(
  context: context,
  builder: (sheetContext) => Column(
    crossAxisAlignment: .stretch,
    children: [
      Text(
        sheetContext.t.learning.evidence.sheetTitle,
        style: sheetContext.theme.typography.display.lg.copyWith(
          fontWeight: .w700,
        ),
      ),
      const SizedBox(height: AppSpacing.small),
      Text(sheetContext.t.learning.evidence.principles),
      const SizedBox(height: AppSpacing.big),
      Text(sheetContext.t.learning.evidence.limitations),
      const SizedBox(height: AppSpacing.section),
      AppButton(
        variant: .outline,
        onPress: () => Navigator.of(sheetContext).pop(),
        child: Text(sheetContext.t.app.close),
      ),
    ],
  ),
);

/// Renders the ordered offline learning library.
final class _ModuleList extends StatelessWidget {
  /// Modules with their persisted progress.
  final List<LearningLibraryItem> items;

  /// Creates a module list from [items].
  const _ModuleList({
    required this.items,
  });

  @override
  Widget build(BuildContext context) => FTileGroup(
    semanticsLabel: context.t.learning.semantics,
    children: [
      for (final LearningLibraryItem item in items)
        FTile(
          key: Key('learning_module_${item.module.id}'),
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: context.t.app.moduleNumber(
                    order: formatCount(item.module.order),
                  ),
                  style: TextStyle(
                    fontWeight: .bold,
                    color: context.theme.colors.primary,
                  ),
                ),
                TextSpan(
                  text: ' · ${item.module.title}',
                ),
              ],
            ),
          ),
          subtitle: AppTileSubtitle(
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                Text(item.module.summary),
                const SizedBox(height: AppSpacing.small),
                Text(
                  context.t.learning.module.line(
                    minutes: item.module.estimatedMinutes,
                    status: _status(item),
                  ),
                  style: context.theme.typography.body.xs.copyWith(
                    color: context.theme.colors.mutedForeground,
                  ),
                ),
                if (item.isStarted && !item.isCompleted) ...[
                  const SizedBox(height: AppSpacing.medium),
                  FDeterminateProgress(
                    value: item.completion,
                    semanticsLabel: context.t.learning.module.progress(
                      title: item.module.title,
                    ),
                  ),
                ],
              ],
            ),
          ),
          suffix: item.isCompleted
              ? const AppSelectionCheckbox(
                  value: true,
                  circular: true,
                )
              : const Icon(FLucideIcons.chevronRight),
          onPress: () => context.push(AppRoutes.module(item.module.id)),
        ),
    ],
  );

  /// Returns the localized completion status for [item].
  String _status(LearningLibraryItem item) {
    if (item.isCompleted) {
      return t.learning.status.completed;
    }
    if (item.isReviewing) {
      return t.learning.status.reviewing;
    }
    if (item.isStarted) {
      return t.learning.status.resume;
    }
    return t.learning.status.discover;
  }
}
