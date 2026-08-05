/// Reusable spacing values shared by StopCorn layouts.
abstract final class AppSpacing {
  /// Tight gap between text or metadata that belong together.
  static const double small = 4;

  /// Gap between adjacent controls or an icon and its label.
  static const double medium = 8;

  /// Gap between related content blocks and padding inside cards.
  static const double big = 16;

  /// Gap separating two page sections.
  static const double section = 24;

  /// Inset shared by pages and modal sheets.
  static const double page = 20;
}

/// Reusable icon dimensions shared by StopCorn widgets.
abstract final class AppIconSize {
  /// Brand mark embedded in a line of text.
  static const double inlineBrand = 18;

  /// Standalone icon used as the focal point of a state or message.
  static const double display = 48;

  /// StopCorn brand illustration used in introductory surfaces.
  static const double brand = 96;
}

/// Reusable motion durations shared by StopCorn widgets.
abstract final class AppMotion {
  /// Duration of the one-shot brand-mark sway and falling kernels.
  static const Duration brandEntrance = Duration(milliseconds: 900);

  /// Duration of the Corn-point and momentum counter celebration.
  static const Duration rewardCounter = Duration(milliseconds: 900);
}
