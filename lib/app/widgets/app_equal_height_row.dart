import 'package:flutter/widgets.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';

/// Displays equally wide children stretched to the tallest child in the row.
///
/// This widget is intended for short card rows whose height must remain
/// content-driven for localization and enlarged text.
final class AppEqualHeightRow extends StatelessWidget {
  /// Widgets displayed from left to right with equal widths.
  final List<Widget> children;

  /// Horizontal distance between adjacent children.
  final double spacing;

  /// Creates one content-driven row with equal child heights.
  const AppEqualHeightRow({
    super.key,
    required this.children,
    this.spacing = AppSpacing.medium,
  }) : assert(children.length > 0),
       assert(spacing >= 0);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      crossAxisAlignment: .stretch,
      children: [
        for (int index = 0; index < children.length; index++) ...[
          if (index > 0) SizedBox(width: spacing),
          Expanded(child: children[index]),
        ],
      ],
    ),
  );
}
