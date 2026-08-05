import 'package:flutter/foundation.dart';

/// An extension on [TargetPlatform] that returns true if the platform is a desktop platform.
extension IsDesktop on TargetPlatform {
  /// Returns true if the platform is a desktop platform.
  bool get isDesktop => this == TargetPlatform.fuchsia || this == TargetPlatform.linux || this == TargetPlatform.windows;
}
