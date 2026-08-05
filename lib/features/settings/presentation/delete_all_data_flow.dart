import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_switch_card.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/settings/application/settings_controller.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Runs the two-step confirmation flow before deleting all local user data.
///
/// Deletion cannot be undone and StopCorn keeps no remote copy, so it is never
/// one tap away: the first dialog explains what leaves, and the second asks for
/// an explicit acknowledgement.
Future<void> deleteAllData(BuildContext context, WidgetRef ref) async {
  bool? continueDeletion = await showFDialog<bool>(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    useSafeArea: true,
    builder: (dialogContext, style, animation) => FDialog(
      animation: animation,
      semanticsLabel: context.t.settings.data.delete.semantics,
      builder: (contentContext, style) => SingleChildScrollView(
        padding: const .all(AppSpacing.page),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            Text(
              contentContext.t.settings.data.delete.title,
              style: contentContext.theme.typography.display.lg.copyWith(
                fontWeight: .w700,
              ),
            ),
            const SizedBox(height: AppSpacing.big),
            Text(contentContext.t.settings.data.delete.body),
            const SizedBox(height: AppSpacing.section),
            AppButton(
              variant: .destructive,
              onPress: () => Navigator.of(contentContext).pop(true),
              child: Text(contentContext.t.app.continueLabel),
            ),
            const SizedBox(height: AppSpacing.medium),
            AppButton(
              variant: .outline,
              onPress: () => Navigator.of(contentContext).pop(false),
              child: Text(contentContext.t.app.cancel),
            ),
          ],
        ),
      ),
    ),
  );
  if (continueDeletion != true || !context.mounted) {
    return;
  }

  bool? finalConfirmation = await showFDialog<bool>(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    useSafeArea: true,
    builder: (dialogContext, style, animation) => _FinalDeleteDialog(animation: animation),
  );
  if (finalConfirmation != true || !context.mounted) {
    return;
  }

  bool success = await ref.read(settingsControllerProvider.notifier).deleteAllData();
  if (success && context.mounted) {
    context.go(AppRoutes.splash);
  }
}

/// Requires an explicit acknowledgement before final data deletion.
final class _FinalDeleteDialog extends StatefulWidget {
  /// Dialog entrance and exit animation.
  final Animation<double> animation;

  /// Creates the irreversible deletion confirmation dialog.
  const _FinalDeleteDialog({
    required this.animation,
  });

  @override
  State<_FinalDeleteDialog> createState() => _FinalDeleteDialogState();
}

/// Tracks acknowledgement within the final deletion dialog.
final class _FinalDeleteDialogState extends State<_FinalDeleteDialog> {
  /// Whether the user explicitly confirmed the irreversible action.
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) => FDialog(
    animation: widget.animation,
    semanticsLabel: context.t.settings.data.delete.confirmation.semantics,
    builder: (contentContext, style) => SingleChildScrollView(
      padding: const .all(AppSpacing.page),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          Text(
            contentContext.t.settings.data.delete.confirmation.title,
            style: contentContext.theme.typography.display.lg.copyWith(
              fontWeight: .w700,
            ),
          ),
          const SizedBox(height: AppSpacing.big),
          AppSwitchCard(
            controlKey: const Key('final_delete_confirmation_switch'),
            destructive: true,
            label: Text(contentContext.t.settings.data.delete.confirmation.action),
            value: _confirmed,
            onChange: (value) => setState(() => _confirmed = value),
          ),
          const SizedBox(height: AppSpacing.section),
          AppButton(
            key: const Key('final_delete_button'),
            variant: .destructive,
            onPress: _confirmed ? () => Navigator.of(contentContext).pop(true) : null,
            child: Text(contentContext.t.settings.data.delete.confirmation.action),
          ),
          const SizedBox(height: AppSpacing.medium),
          AppButton(
            variant: .outline,
            onPress: () => Navigator.of(contentContext).pop(false),
            child: Text(contentContext.t.settings.data.delete.confirmation.keep),
          ),
        ],
      ),
    ),
  );
}
