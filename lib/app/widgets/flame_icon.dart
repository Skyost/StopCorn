import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// Displays a compact corn-colored flame representing the current momentum.
final class FlameIcon extends StatelessWidget {
  /// Default compact size when the surrounding widget does not constrain it.
  static const double _defaultSize = 18;

  /// Width and height reserved for the flame.
  final double size;

  /// Optional flame color overriding the theme-aware corn color.
  final Color? color;

  /// Creates a decorative momentum flame.
  const FlameIcon({
    super.key,
    this.size = _defaultSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Color resolvedColor = color ?? context.theme.colors.destructive;
    return ExcludeSemantics(
      child: CustomPaint(
        size: .square(size),
        painter: _FlamePainter(resolvedColor),
      ),
    );
  }
}

/// Paints the normalized outer flame and its transparent inner flicker.
final class _FlamePainter extends CustomPainter {
  /// Fill color applied to the flame.
  final Color color;

  /// Creates a flame painter using [color].
  const _FlamePainter(
    this.color,
  );

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    Path outerFlame = Path()
      ..moveTo(width * 0.5, height)
      ..cubicTo(
        width * 0.25,
        height,
        width * 0.08,
        height * 0.84,
        width * 0.1,
        height * 0.61,
      )
      ..cubicTo(
        width * 0.12,
        height * 0.4,
        width * 0.32,
        height * 0.27,
        width * 0.47,
        0,
      )
      ..cubicTo(
        width * 0.68,
        height * 0.2,
        width * 0.72,
        height * 0.36,
        width * 0.68,
        height * 0.49,
      )
      ..cubicTo(
        width * 0.79,
        height * 0.41,
        width * 0.84,
        height * 0.3,
        width * 0.83,
        height * 0.2,
      )
      ..cubicTo(
        width * 0.99,
        height * 0.4,
        width,
        height * 0.63,
        width * 0.9,
        height * 0.8,
      )
      ..cubicTo(
        width * 0.82,
        height * 0.94,
        width * 0.66,
        height,
        width * 0.5,
        height,
      )
      ..close();
    Path innerFlicker = Path()
      ..moveTo(width * 0.51, height * 0.86)
      ..cubicTo(
        width * 0.39,
        height * 0.84,
        width * 0.33,
        height * 0.74,
        width * 0.37,
        height * 0.64,
      )
      ..cubicTo(
        width * 0.4,
        height * 0.56,
        width * 0.49,
        height * 0.49,
        width * 0.54,
        height * 0.4,
      )
      ..cubicTo(
        width * 0.66,
        height * 0.54,
        width * 0.71,
        height * 0.66,
        width * 0.66,
        height * 0.76,
      )
      ..cubicTo(
        width * 0.63,
        height * 0.83,
        width * 0.57,
        height * 0.86,
        width * 0.51,
        height * 0.86,
      )
      ..close();
    Path flame = Path.combine(
      PathOperation.difference,
      outerFlame,
      innerFlicker,
    );
    Paint paint = Paint()
      ..color = color
      ..style = .fill
      ..isAntiAlias = true;
    canvas.drawPath(flame, paint);
  }

  @override
  bool shouldRepaint(_FlamePainter oldDelegate) => oldDelegate.color != color;
}
