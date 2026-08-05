import 'package:flutter/material.dart' show SelectionArea;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_sheet.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/learning/application/module_controller.dart';
import 'package:stopcorn/features/learning/domain/learning_catalog.dart';
import 'package:stopcorn/features/learning/domain/module_view_state.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Renders one localized reading section.
final class ModuleReadingStep extends StatelessWidget {
  /// Current module state.
  final ModuleViewState state;

  /// Creates the current reading section.
  const ModuleReadingStep({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    LearningSection section = state.module.sections[state.sectionIndex];
    return AppCard(
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Text(
            section.title,
            style: context.theme.typography.display.lg.copyWith(
              fontWeight: .w700,
            ),
          ),
          for (final String paragraph in section.paragraphs) ...[
            const SizedBox(height: AppSpacing.big),
            Text(paragraph, style: context.theme.typography.body.lg),
          ],
        ],
      ),
    );
  }
}

/// Collects the optional device-only module reflection.
final class ModuleReflectionStep extends StatelessWidget {
  /// Current module state.
  final ModuleViewState state;

  /// Controller receiving reflection changes.
  final ModuleController controller;

  /// Creates the optional reflection editor.
  const ModuleReflectionStep({
    super.key,
    required this.state,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        Text(
          state.module.reflectionPrompt,
          style: context.theme.typography.body.lg.copyWith(
            fontWeight: .w600,
          ),
        ),
        const SizedBox(height: AppSpacing.big),
        FTextField(
          control: FTextFieldControl.managed(
            initial: TextEditingValue(text: state.reflectionText),
            onChange: (value) => controller.setReflection(value.text),
          ),
          label: Text(context.t.learning.reflection.label),
          hint: context.t.learning.reflection.hint,
          minLines: 3,
          maxLines: 6,
          maxLength: AppConstants.noteMaxLength,
          maxLengthEnforcement: .enforced,
          textCapitalization: .sentences,
        ),
        const SizedBox(height: AppSpacing.medium),
        Text(
          context.t.learning.reflection.localNote,
          style: context.theme.typography.body.xs.copyWith(
            color: context.theme.colors.mutedForeground,
          ),
        ),
      ],
    ),
  );
}

/// Opens the scrollable bibliography for [module].
Future<void> showModuleSources(
  BuildContext context,
  LearningModule module,
) => showAppSheet<void>(
  context: context,
  builder: (sheetContext) => Column(
    crossAxisAlignment: .stretch,
    children: [
      Text(
        sheetContext.t.learning.sources.sheetTitle,
        style: sheetContext.theme.typography.display.lg.copyWith(
          fontWeight: .w700,
        ),
      ),
      const SizedBox(height: AppSpacing.small),
      Text(sheetContext.t.learning.sources.scope),
      const SizedBox(height: AppSpacing.big),
      SelectionArea(
        child: FTileGroup(
          children: [
            for (LearningReference reference in module.references)
              FTile(
                title: Text(reference.citation),
                subtitle: AppTileSubtitle(
                  child: Text(reference.url),
                ),
              ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.section),
      AppButton(
        variant: .outline,
        onPress: () => Navigator.of(sheetContext).pop(),
        child: Text(sheetContext.t.app.close),
      ),
    ],
  ),
);

/// Displays the supportive module-completion summary.
final class CompletedModule extends StatelessWidget {
  /// Completed module state.
  final ModuleViewState state;

  /// Controller used to restart the completed module.
  final ModuleController controller;

  /// Creates the completion summary for [state] controlled by [controller].
  const CompletedModule({
    super.key,
    required this.state,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        const SizedBox(height: AppSpacing.section),
        const Icon(
          FLucideIcons.bookCheck,
          size: AppIconSize.display,
        ),
        const SizedBox(height: AppSpacing.big),
        Text(
          context.t.learning.completion.title,
          textAlign: .center,
          style: context.theme.typography.display.xl.copyWith(
            fontWeight: .w700,
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        Text(
          state.module.title,
          textAlign: .center,
          style: context.theme.typography.body.lg,
        ),
        if (state.reflectionText.trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.section),
          AppCard(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  context.t.learning.reflection.yours,
                  style: context.theme.typography.body.lg.copyWith(
                    fontWeight: .w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.medium),
                Text(state.reflectionText),
              ],
            ),
          ),
        ],
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
          key: const Key('module_restart_button'),
          variant: .outline,
          onPress: state.isSaving ? null : controller.restart,
          child: Text(
            state.isSaving ? context.t.app.saving : context.t.learning.completion.restart,
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        AppButton(
          onPress: () => context.go(AppRoutes.learn),
          child: Text(context.t.learning.completion.back),
        ),
      ],
    ),
  );
}
