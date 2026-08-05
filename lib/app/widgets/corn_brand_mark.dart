import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays the StopCorn cob as a reusable, gently animated illustration.
final class CornBrandMark extends StatelessWidget {
  /// Asset containing the canonical StopCorn cob.
  static const String _assetPath = 'assets/branding/logo.svg';

  /// Width and height reserved for the illustration.
  final double size;

  /// Optional accessible replacement for the visual mark.
  final String? semanticsLabel;

  /// Creates a StopCorn brand illustration.
  const CornBrandMark({
    super.key,
    this.size = AppIconSize.brand,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    image: true,
    label: semanticsLabel ?? context.t.app.logoSemantics,
    child: ExcludeSemantics(child: _illustration()),
  );

  /// Builds the static canonical cob.
  Widget _illustration() => SizedBox.square(
    dimension: size,
    child: SvgPicture.asset(
      _assetPath,
      fit: .contain,
    ),
  );
}

/// Creates an inline StopCorn cob matching the surrounding [style].
WidgetSpan cornBrandSpan(
  BuildContext context, {
  TextStyle? style,
}) {
  TextStyle effectiveStyle = style ?? DefaultTextStyle.of(context).style;
  return WidgetSpan(
    alignment: .middle,
    child: CornBrandMark(
      size: effectiveStyle.fontSize ?? AppIconSize.inlineBrand,
      semanticsLabel: context.t.app.urgeCueSemantics,
    ),
  );
}

/// Displays a filled or outlined kernel as a compact harvest indicator.
final class CornKernelIcon extends StatelessWidget {
  /// Default compact size when the surrounding widget does not constrain it.
  static const double _defaultSize = 18;

  /// Whether the represented kernel has been collected.
  final bool collected;

  /// Width and height reserved for the kernel.
  final double size;

  /// Color of the kernel when it is collected.
  final Color collectedColor;

  /// Creates a harvest kernel indicator.
  const CornKernelIcon({
    super.key,
    this.collected = true,
    this.size = _defaultSize,
    this.collectedColor = const Color(0xffe5b82e),
  });

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox.square(
      dimension: size,
      child: Center(
        child: Transform.rotate(
          angle: 0.36,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: collected ? collectedColor : Colors.black,
              borderRadius: .circular(size),
              border: Border.all(
                color: collected ? collectedColor : context.theme.colors.mutedForeground,
              ),
            ),
            child: SizedBox(
              width: size * 0.62,
              height: size,
            ),
          ),
        ),
      ),
    ),
  );
}
