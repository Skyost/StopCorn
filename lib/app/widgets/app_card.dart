import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// Card with the shared StopCorn content padding.
final class AppCard extends StatelessWidget {
  /// Card content.
  final Widget child;

  /// Optional padding.
  final EdgeInsetsGeometry? padding;

  /// Creates a card around [child].
  const AppCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) => FCard(
    child: child,
    builder: (context, style, child) => Padding(
      padding: padding ?? style.padding,
      child: child,
    ),
  );
}
