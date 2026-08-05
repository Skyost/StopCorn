import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// Displays supporting or introductory copy with the shared muted treatment.
final class AppSubtitle extends StatelessWidget {
  /// Supporting text to display.
  final Widget child;

  /// Horizontal alignment of [text].
  final TextAlign? textAlign;

  /// Creates an app subtitle.
  AppSubtitle({
    Key? key,
    required String text,
    TextAlign? textAlign,
  }) : this.raw(
         key: key,
         child: Text(
           text,
         ),
         textAlign: textAlign,
       );

  /// Creates an app subtitle from a raw widget.
  const AppSubtitle.raw({
    super.key,
    required this.child,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) => DefaultTextStyle.merge(
    child: child,
    textAlign: textAlign,
    style: context.theme.typography.body.sm.copyWith(
      color: context.theme.colors.mutedForeground,
    ),
  );
}
