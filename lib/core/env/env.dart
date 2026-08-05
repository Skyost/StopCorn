import 'package:envied/envied.dart';

part 'env.g.dart';

/// Environment variables.
@Envied()
abstract final class Env {
  /// Public RevenueCat key for the Google Play application.
  @EnviedField(varName: 'REVENUECAT_ANDROID_API_KEY')
  static const String revenueCatAndroidApiKey = _Env.revenueCatAndroidApiKey;

  /// Public RevenueCat key for the App Store application.
  @EnviedField(varName: 'REVENUECAT_IOS_API_KEY')
  static const String revenueCatIosApiKey = _Env.revenueCatIosApiKey;

  /// Public RevenueCat Test Store key.
  @EnviedField(varName: 'REVENUECAT_TEST_API_KEY')
  static const String revenueCatTestApiKey = _Env.revenueCatTestApiKey;

  /// The Sentry DSN.
  @EnviedField(varName: 'SENTRY_DSN')
  static const String sentryDsn = _Env.sentryDsn;
}
