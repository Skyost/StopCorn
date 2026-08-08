import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/features/project_support/application/project_support_service.dart';

/// Verifies the lazy, platform-specific project-support integration.
void main() {
  test('the test key is used outside release mode and configured only once', () async {
    List<String> configuredKeys = [];
    int presentationCount = 0;
    RevenueCatProjectSupportService service = RevenueCatProjectSupportService(
      platform: TargetPlatform.android,
      releaseMode: false,
      testApiKey: ' test_public_key ',
      androidApiKey: 'android_public_key',
      configureRevenueCat: (apiKey) async => configuredKeys.add(apiKey),
      presentRevenueCatPaywall: (offering) async {
        presentationCount++;
        return .purchased;
      },
    );

    expect(
      await service.presentPaywall(),
      ProjectSupportPaywallResult.purchased,
    );
    expect(
      await service.presentPaywall(),
      ProjectSupportPaywallResult.purchased,
    );
    expect(configuredKeys, ['test_public_key']);
    expect(presentationCount, 2);
  });

  test('an iOS release ignores the test key', () async {
    List<String> configuredKeys = [];
    RevenueCatProjectSupportService service = RevenueCatProjectSupportService(
      platform: TargetPlatform.iOS,
      releaseMode: true,
      testApiKey: 'test_public_key',
      androidApiKey: 'android_public_key',
      iosApiKey: ' ios_public_key ',
      configureRevenueCat: (apiKey) async => configuredKeys.add(apiKey),
      presentRevenueCatPaywall: (offering) async => .restored,
    );

    expect(
      await service.presentPaywall(),
      ProjectSupportPaywallResult.restored,
    );
    expect(configuredKeys, ['ios_public_key']);
  });

  test('support status reads only the expected active entitlement', () async {
    int configurationCount = 0;
    RevenueCatProjectSupportService service = RevenueCatProjectSupportService(
      platform: TargetPlatform.android,
      releaseMode: true,
      androidApiKey: 'android_public_key',
      configureRevenueCat: (_) async => configurationCount++,
      loadSupportStatus: (entitlement) async => true,
    );

    expect(await service.hasSupported(), isTrue);
    expect(await service.hasSupported(), isTrue);
    expect(configurationCount, 1);
  });

  test('the paywall remains unavailable without a platform key', () async {
    int configurationCount = 0;
    int presentationCount = 0;
    RevenueCatProjectSupportService service = RevenueCatProjectSupportService(
      platform: TargetPlatform.linux,
      releaseMode: true,
      androidApiKey: 'android_public_key',
      iosApiKey: 'ios_public_key',
      configureRevenueCat: (_) async => configurationCount++,
      presentRevenueCatPaywall: (offering) async {
        presentationCount++;
        return .purchased;
      },
    );

    expect(
      await service.presentPaywall(),
      ProjectSupportPaywallResult.unavailable,
    );
    expect(configurationCount, 0);
    expect(presentationCount, 0);
  });

  test('public links use the official addresses', () async {
    List<Uri> openedUris = [];
    RevenueCatProjectSupportService service = RevenueCatProjectSupportService(
      launchUri: (uri) async {
        openedUris.add(uri);
        return true;
      },
    );

    expect(await service.openSourceCode(), isTrue);
    expect(await service.openWebsite(), isTrue);
    expect(await service.openPrivacyPolicy(), isTrue);
    expect(openedUris, [
      Uri.parse('https://github.com/Skyost/StopCorn'),
      Uri.parse('https://stopcorn.skyost.eu'),
      Uri.parse('https://stopcorn.skyost.eu/#privacy'),
    ]);
  });

  test('a native error is converted into a recoverable result', () async {
    RevenueCatProjectSupportService service = RevenueCatProjectSupportService(
      platform: TargetPlatform.android,
      releaseMode: true,
      androidApiKey: 'android_public_key',
      configureRevenueCat: (_) async {},
      presentRevenueCatPaywall: (offering) => throw StateError('paywall unavailable'),
      launchUri: (_) => throw StateError('browser unavailable'),
    );

    expect(
      await service.presentPaywall(),
      ProjectSupportPaywallResult.error,
    );
    expect(await service.openWebsite(), isFalse);
  });
}
