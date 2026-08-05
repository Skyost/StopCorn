import 'package:flutter/widgets.dart';

/// Removes ForUI's one-line overflow treatment from a tile subtitle.
final class AppTileSubtitle extends StatelessWidget {
  /// Subtitle content that may occupy as many lines as necessary.
  final Widget child;

  /// Creates an unrestricted tile subtitle.
  const AppTileSubtitle({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    DefaultTextStyle parent = DefaultTextStyle.of(context);
    return DefaultTextStyle(
      style: parent.style,
      textAlign: parent.textAlign,
      softWrap: true,
      overflow: .visible,
      maxLines: null,
      textWidthBasis: parent.textWidthBasis,
      textHeightBehavior: parent.textHeightBehavior,
      child: child,
    );
  }
}
