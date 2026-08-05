import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';

/// Displays a full-width primary action followed by an optional ghost action.
final class AppActionButtons extends StatelessWidget {
  /// Optional key assigned to the primary button.
  final Key? primaryButtonKey;

  /// Callback invoked by the primary button, or `null` when it is disabled.
  final VoidCallback? onPrimaryPress;

  /// Label displayed by the primary button.
  final Widget? primaryLabel;

  /// Visual treatment of the primary button.
  final FButtonVariant primaryVariant;

  /// Size of the primary button.
  final FButtonSizeVariant primarySize;

  /// Optional key assigned to the ghost button.
  final Key? secondaryButtonKey;

  /// Callback invoked by the ghost button, or `null` when it is disabled.
  final VoidCallback? onSecondaryPress;

  /// Optional label whose presence displays the ghost button.
  final Widget? secondaryLabel;

  /// Creates a vertically stacked pair of application actions.
  const AppActionButtons({
    super.key,
    this.onPrimaryPress,
    this.primaryLabel,
    this.primaryButtonKey,
    this.primaryVariant = .primary,
    this.primarySize = .md,
    this.secondaryButtonKey,
    this.onSecondaryPress,
    this.secondaryLabel,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    crossAxisAlignment: .stretch,
    children: [
      if (primaryLabel != null)
        AppButton(
          key: primaryButtonKey,
          variant: primaryVariant,
          size: primarySize,
          onPress: onPrimaryPress,
          child: primaryLabel!,
        ),
      if (secondaryLabel != null) ...[
        if (primaryLabel != null) const SizedBox(height: AppSpacing.medium),
        AppButton(
          key: secondaryButtonKey,
          variant: .ghost,
          onPress: onSecondaryPress,
          child: secondaryLabel!,
        ),
      ],
    ],
  );
}
