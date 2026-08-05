import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';

/// The light and dark variants of the app theme.
({FPlatformThemeData light, FPlatformThemeData dark}) get appTheme {
  FColors lightColors = FColors(
    brightness: .light,
    systemOverlayStyle: .dark,
    barrier: const Color(0x33000000),
    background: const Color(0xFFFFFCF2),
    foreground: const Color(0xFF172019),
    primary: const Color(0xFF24543B),
    primaryForeground: const Color(0xFFFFFFFF),
    secondary: const Color(0xFFF4D978),
    secondaryForeground: const Color(0xFF273A2C),
    muted: const Color(0xFFF5F0E4),
    mutedForeground: const Color(0xFF69645B),
    destructive: const Color(0xFFAD5149),
    destructiveForeground: const Color(0xFFFFFFFF),
    error: const Color(0xFFAD5149),
    errorForeground: const Color(0xFFFFFFFF),
    card: const Color(0xFFFFFEFA),
    border: const Color(0xFFE3DAC8),
  );
  FColors darkColors = FColors(
    brightness: .dark,
    systemOverlayStyle: .light,
    barrier: const Color(0x7A000000),
    background: const Color(0xFF0E1712),
    foreground: const Color(0xFFF6F1E6),
    primary: const Color(0xFFF2CB55),
    primaryForeground: const Color(0xFF142219),
    secondary: const Color(0xFF274633),
    secondaryForeground: const Color(0xFFF6F1E6),
    muted: const Color(0xFF18231C),
    mutedForeground: const Color(0xFFB7B2A7),
    destructive: const Color(0xFFD27870),
    destructiveForeground: const Color(0xFF1E0B09),
    error: const Color(0xFFD27870),
    errorForeground: const Color(0xFF1E0B09),
    card: const Color(0xFF18231C),
    border: const Color(0xFF35463A),
  );
  return (
    light: FPlatformThemeData(
      desktop: () => _adaptLightTheme(
        _appThemeData(
          touch: false,
          debugLabel: 'App Light Theme Desktop',
          colors: lightColors,
          generalStyle: _adaptGeneralStyle(),
        ),
        touch: false,
      ),
      touch: () => _adaptLightTheme(
        _appThemeData(
          touch: true,
          debugLabel: 'App Light Theme Touch',
          colors: lightColors,
          generalStyle: _adaptGeneralStyle(),
        ),
        touch: true,
      ),
    ),
    dark: FPlatformThemeData(
      desktop: () => _adaptDarkTheme(
        _appThemeData(
          touch: false,
          debugLabel: 'App Dark Theme Desktop',
          colors: darkColors,
          generalStyle: _adaptGeneralStyle(),
        ),
        touch: false,
      ),
      touch: () => _adaptDarkTheme(
        _appThemeData(
          touch: true,
          debugLabel: 'App Dark Theme Touch',
          colors: darkColors,
          generalStyle: _adaptGeneralStyle(),
        ),
        touch: true,
      ),
    ),
  );
}

/// Creates a green theme using the newer ForUI constructor-level general style.
FThemeData _appThemeData({
  required bool touch,
  required String debugLabel,
  required FColors colors,
  required FStyleDelta generalStyle,
}) {
  FTypography typography = FTypography.inherit(colors: colors, touch: touch);
  FStyle style = FStyle.inherit(colors: colors, typography: typography, touch: touch);
  return FThemeData(
    touch: touch,
    debugLabel: debugLabel,
    colors: colors,
    typography: typography.copyWith(
      display: typography.display.copyWith(
        lg: typography.display.lg.copyWith(
          height: 1.25,
        ),
        xl: typography.display.xl.copyWith(
          height: 1.25,
        ),
      ),
    ),
    style: generalStyle(style),
  );
}

/// Adapts the light theme.
FThemeData _adaptLightTheme(FThemeData light, {required bool touch}) => light.copyWith(
  tileGroupStyle: .delta(
    tileStyles: _adaptTileStyles(light.colors),
  ),
  tileStyles: _adaptTileStyles(light.colors),
  cardStyle: _adaptCardStyle(),
  buttonStyles: _adaptButtonStyles(light.colors.foreground),
);

/// Adapts the dark theme.
FThemeData _adaptDarkTheme(FThemeData dark, {required bool touch}) => dark.copyWith(
  tileGroupStyle: .delta(
    tileStyles: _adaptTileStyles(dark.colors),
  ),
  tileStyles: _adaptTileStyles(dark.colors),
  cardStyle: _adaptCardStyle(),
  buttonStyles: _adaptButtonStyles(dark.colors.foreground),
);

/// Adapts the card style.
FCardStyleDelta _adaptCardStyle() => const .delta(
  padding: .value(
    .all(
      AppSpacing.big,
    ),
  ),
);

/// Adapts the tile style.
FVariantsDelta<FItemVariantConstraint, FItemVariant, FTileStyle, FTileStyleDelta>? _adaptTileStyles(FColors colors) => .delta(
  [
    .all(
      .delta(
        backgroundColor: .delta(
          [
            .base(null),
          ],
        ),
        contentStyle: .delta(
          subtitleTextStyle: .delta(
            [
              .base(
                const .delta(
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
        contentDecoration: .delta(
          [
            .match(
              {.hovered, .pressed},
              .boxDelta(
                color: colors.hover(colors.background),
              ),
            ),
          ],
        ),
      ),
    ),
  ],
);

/// Adapts the button styles.
FVariantsDelta<FButtonVariantConstraint, FButtonVariant, FButtonSizeStyles, FButtonSizesDelta> _adaptButtonStyles(Color foreground) => .delta(
  [
    .match(
      {.ghost},
      .delta(
        [
          .all(
            .delta(
              decoration: .delta(
                [
                  .all(
                    const .shapeDelta(color: Color(0x00000000)),
                  ),
                ],
              ),
              contentStyle: .delta(
                textStyle: .delta(
                  [
                    .exact(
                      {.hovered, .pressed},
                      .delta(color: foreground),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ],
);

/// Adapts the general styles.
FStyleDelta _adaptGeneralStyle() => .delta(
  pagePadding: const .value(
    .all(AppSpacing.page),
  ),
  tappableStyle: .delta(
    cursor: .delta(
      [
        .exact(
          {.hovered, .pressed},
          SystemMouseCursors.click,
        ),
      ],
    ),
  ),
);
