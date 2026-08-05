import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Provides the common presentation used by settings selection sheets.
final class SettingsSelectionSheet extends StatelessWidget {
  /// Sheet title.
  final String title;

  /// Selection guidance.
  final String description;

  /// Whether persistence is in progress.
  final bool saving;

  /// Selection widget.
  final Widget selection;

  /// Save callback.
  final VoidCallback onSave;

  /// Creates a shared settings selection sheet.
  const SettingsSelectionSheet({
    super.key,
    required this.title,
    required this.description,
    required this.saving,
    required this.selection,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    crossAxisAlignment: .stretch,
    children: [
      Text(
        title,
        style: context.theme.typography.display.lg.copyWith(
          fontWeight: .w700,
        ),
      ),
      const SizedBox(height: AppSpacing.small),
      Text(description),
      const SizedBox(height: AppSpacing.big),
      selection,
      const SizedBox(height: AppSpacing.section),
      AppButton(
        onPress: saving ? null : onSave,
        child: Text(
          saving ? context.t.app.saving : context.t.app.save,
        ),
      ),
    ],
  );
}
