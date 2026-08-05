import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_page.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/harvest/presentation/harvest_reward_dialog.dart';
import 'package:stopcorn/features/learning/application/module_controller.dart';
import 'package:stopcorn/features/learning/domain/module_view_state.dart';
import 'package:stopcorn/features/learning/presentation/module_steps.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays one resumable offline learning module.
final class ModuleScreen extends ConsumerWidget {
  /// Stable module identifier from the local catalog.
  final String moduleId;

  /// Creates a screen for [moduleId].
  const ModuleScreen({
    super.key,
    required this.moduleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ModuleControllerProvider provider = moduleControllerProvider(moduleId);
    AsyncValue<ModuleViewState> state = ref.watch(provider);
    return AppPage(
      title: Text(
        switch (state) {
          AsyncData<ModuleViewState>() => state.value.module.title,
          _ => context.t.learning.module.pageTitle,
        },
      ),
      showBackButton: true,
      backFallbackLocation: AppRoutes.learn,
      child: state.when(
        loading: () => const AsyncStatePanel(child: LoadingState()),
        error: (error, _) => AsyncStatePanel(
          child: ErrorState(
            message: context.t.learning.module.loadError,
            error: error,
            onRetry: () => ref.invalidate(provider),
          ),
        ),
        data: (value) => _ModuleContent(
          state: value,
          controller: ref.read(provider.notifier),
          onComplete: () => runWithHarvestReward(
            context,
            ref,
            ref.read(provider.notifier).complete,
          ),
        ),
      ),
    );
  }
}

/// Chooses the reading, reflection, or completion view for a module.
final class _ModuleContent extends StatelessWidget {
  /// Current reading position and reflection.
  final ModuleViewState state;

  /// Controller receiving navigation and reflection actions.
  final ModuleController controller;

  /// Completes the module and presents any newly earned harvest reward.
  final Future<bool> Function() onComplete;

  /// Creates module content controlled by [controller].
  const _ModuleContent({
    required this.state,
    required this.controller,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isCompleted) {
      return CompletedModule(
        state: state,
        controller: controller,
      );
    }
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        AppSubtitle(text: state.module.summary),
        const SizedBox(height: AppSpacing.big),
        FTileGroup(
          children: [
            FTile(
              key: const Key('module_sources_tile'),
              prefix: const Icon(FLucideIcons.bookOpenCheck),
              title: Text(
                context.t.learning.sources.title(
                  count: state.module.references.length,
                ),
              ),
              subtitle: AppTileSubtitle(
                child: Text(context.t.learning.sources.shortDescription),
              ),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => showModuleSources(context, state.module),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.big),
        FDeterminateProgress(
          value: state.completion,
          semanticsLabel: context.t.learning.reading.progress,
        ),
        const SizedBox(height: AppSpacing.medium),
        Text(
          state.isReflectionStep
              ? context.t.learning.reflection.optional
              : context.t.learning.reading.part(
                  current: state.sectionIndex + 1,
                  total: state.module.sections.length,
                ),
          textAlign: .center,
          style: context.theme.typography.body.sm,
        ),
        const SizedBox(height: AppSpacing.section),
        if (state.isReflectionStep) ModuleReflectionStep(state: state, controller: controller) else ModuleReadingStep(state: state),
        if (state.errorMessage != null) ...[
          const SizedBox(height: AppSpacing.big),
          AppCard(
            child: Row(
              crossAxisAlignment: .start,
              children: [
                const Icon(FLucideIcons.circleAlert),
                const SizedBox(width: AppSpacing.medium),
                Expanded(child: Text(state.errorMessage!)),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.section),
        AppButton(
          key: const Key('module_primary_button'),
          onPress: state.isSaving
              ? null
              : state.isReflectionStep
              ? onComplete
              : controller.next,
          child: Text(
            state.isSaving
                ? context.t.app.saving
                : state.isReflectionStep
                ? context.t.learning.completion.finish
                : state.sectionIndex == state.module.sections.length - 1
                ? context.t.learning.reflection.continueAction
                : context.t.app.continueLabel,
          ),
        ),
        if (state.sectionIndex > 0) ...[
          const SizedBox(height: AppSpacing.medium),
          AppButton(
            variant: .outline,
            onPress: state.isSaving ? null : controller.previous,
            child: Text(context.t.learning.reading.previous),
          ),
        ],
      ],
    );
  }
}
