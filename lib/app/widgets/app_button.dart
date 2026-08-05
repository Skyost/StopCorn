import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// A ForUI button whose label can wrap and whose width can shrink to fit.
///
/// ForUI deliberately lays button slots out in a row. Making the central slot
/// flexible preserves that layout while giving long French labels a bounded
/// width instead of letting them overflow on narrow screens. When
/// [mainAxisSize] is [MainAxisSize.min], the central slot also shrink-wraps so
/// a parent [Align] can position the button.
final class AppButton extends StatelessWidget {
  /// Callback invoked when the button is activated, or `null` when disabled.
  final VoidCallback? onPress;

  /// The button style.
  final FButtonStyleDelta style;

  /// Primary button label.
  final Widget child;

  /// Visual importance and color treatment.
  final FButtonVariant variant;

  /// Button density and minimum tap-target size.
  final FButtonSizeVariant size;

  /// Optional widget rendered before [child].
  final Widget? prefix;

  /// Optional widget rendered after [child].
  final Widget? suffix;

  /// Optional accessible label when [child] contains non-textual content.
  final String? semanticsLabel;

  /// Determines whether the button fills or shrink-wraps the available width.
  final MainAxisSize mainAxisSize;

  /// Creates a wrapping ForUI button.
  const AppButton({
    super.key,
    this.onPress,
    this.style = const .context(),
    required this.child,
    this.variant = .primary,
    this.size = .md,
    this.prefix,
    this.suffix,
    this.semanticsLabel,
    this.mainAxisSize = .max,
  });

  @override
  Widget build(BuildContext context) => FButton(
    variant: variant,
    size: size,
    style: style,
    onPress: onPress,
    semanticsLabel: semanticsLabel,
    prefix: prefix,
    suffix: suffix,
    builder: (context, style, textStyle, iconStyle, progressStyle, child) => Flexible(
      child: Center(
        widthFactor: mainAxisSize == .min ? 1 : null,
        child: DefaultTextStyle.merge(
          style: textStyle,
          textAlign: .center,
          child: child!,
        ),
      ),
    ),
    mainAxisSize: mainAxisSize,
    child: child,
  );
}
