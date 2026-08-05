/// Dimensions and output folders shared by Flutter capture tests and the
/// standalone ImageMagick processor.
final class StoreScreenshotDeviceSpec {
  /// Store platform folder.
  final String platformFolder;

  /// Device form-factor folder.
  final String deviceFolder;

  /// Native store-art width in pixels.
  final double outputWidth;

  /// Native store-art height in pixels.
  final double outputHeight;

  /// Faster software-rendered capture width in pixels.
  final double captureWidth;

  /// Faster software-rendered capture height in pixels.
  final double captureHeight;

  /// Creates one immutable device specification.
  const StoreScreenshotDeviceSpec({
    required this.platformFolder,
    required this.deviceFolder,
    required this.outputWidth,
    required this.outputHeight,
    required this.captureWidth,
    required this.captureHeight,
  });
}

/// Store-native formats and their lossless working resolutions.
abstract final class StoreScreenshotDeviceCatalog {
  /// Scale applied equally to physical resolution and device-pixel ratio.
  static const double captureScale = 0.5;

  /// Android phone capture width.
  static const double androidPhoneCaptureWidth = 640;

  /// Android phone capture height.
  static const double androidPhoneCaptureHeight = 1428;

  /// Android tablet capture width.
  static const double androidTabletCaptureWidth = 720;

  /// Android tablet capture height.
  static const double androidTabletCaptureHeight = 1280;

  /// iPhone capture width.
  static const double iphoneCaptureWidth = 660;

  /// iPhone capture height.
  static const double iphoneCaptureHeight = 1434;

  /// iPad capture width.
  static const double ipadCaptureWidth = 1032;

  /// iPad capture height.
  static const double ipadCaptureHeight = 1376;

  /// Pixel 9 Pro-compatible Android phone artwork.
  static const StoreScreenshotDeviceSpec androidPhone = StoreScreenshotDeviceSpec(
    platformFolder: 'android',
    deviceFolder: 'phone',
    outputWidth: 1280,
    outputHeight: 2856,
    captureWidth: androidPhoneCaptureWidth,
    captureHeight: androidPhoneCaptureHeight,
  );

  /// Portrait Android tablet artwork.
  static const StoreScreenshotDeviceSpec androidTablet = StoreScreenshotDeviceSpec(
    platformFolder: 'android',
    deviceFolder: 'tablet',
    outputWidth: 1440,
    outputHeight: 2560,
    captureWidth: androidTabletCaptureWidth,
    captureHeight: androidTabletCaptureHeight,
  );

  /// iPhone 6.9-inch artwork.
  static const StoreScreenshotDeviceSpec iphone = StoreScreenshotDeviceSpec(
    platformFolder: 'ios',
    deviceFolder: 'iphone',
    outputWidth: 1320,
    outputHeight: 2868,
    captureWidth: iphoneCaptureWidth,
    captureHeight: iphoneCaptureHeight,
  );

  /// iPad 13-inch artwork.
  static const StoreScreenshotDeviceSpec ipad = StoreScreenshotDeviceSpec(
    platformFolder: 'ios',
    deviceFolder: 'ipad',
    outputWidth: 2064,
    outputHeight: 2752,
    captureWidth: ipadCaptureWidth,
    captureHeight: ipadCaptureHeight,
  );

  /// Resolves a specification from its stable output folders.
  static StoreScreenshotDeviceSpec? fromFolders(
    String platform,
    String device,
  ) => switch ('$platform/$device') {
    'android/phone' => androidPhone,
    'android/tablet' => androidTablet,
    'ios/iphone' => iphone,
    'ios/ipad' => ipad,
    _ => null,
  };
}
