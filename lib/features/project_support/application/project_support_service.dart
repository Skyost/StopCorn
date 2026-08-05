import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/env/env.dart';
import 'package:url_launcher/url_launcher.dart';

part 'project_support_service.g.dart';

/// Result returned after the optional RevenueCat support paywall closes.
enum ProjectSupportPaywallResult {
  /// A support purchase completed successfully.
  purchased,

  /// A previous support purchase was restored.
  restored,

  /// The user closed the paywall without purchasing.
  cancelled,

  /// The current build or platform cannot present the paywall.
  unavailable,

  /// RevenueCat reported or threw an error.
  error,
}

/// Opens public project links and the optional support paywall.
abstract interface class ProjectSupportService {
  /// RevenueCat entitlement granted after a StopCorn support purchase.
  static const String supporterEntitlementId = 'entlad1165a313';

  /// Public repository containing the StopCorn source code.
  static final Uri sourceCodeUri = Uri.parse(
    'https://github.com/Skyost/StopCorn',
  );

  /// Public website presenting the StopCorn project.
  static final Uri websiteUri = Uri.parse('https://stopcorn.skyost.eu');

  /// Public privacy policy, kept here so a future URL change is centralized.
  static final Uri privacyPolicyUri = Uri.parse(
    'https://stopcorn.skyost.eu/#privacy',
  );

  /// Opens the source-code repository outside the application.
  Future<bool> openSourceCode();

  /// Opens the project website outside the application.
  Future<bool> openWebsite();

  /// Opens the public privacy policy outside the application.
  Future<bool> openPrivacyPolicy();

  /// Configures RevenueCat on demand and presents the current paywall.
  Future<ProjectSupportPaywallResult> presentPaywall();

  /// Whether the current RevenueCat customer has supported StopCorn.
  Future<bool> hasSupported();
}

/// Configures the native RevenueCat SDK with one public API key.
typedef RevenueCatConfigurator = Future<void> Function(String apiKey);

/// Presents the remotely configured RevenueCat paywall.
typedef RevenueCatPaywallPresenter = Future<ProjectSupportPaywallResult> Function();

/// Reads whether the current customer has the supporter entitlement.
typedef RevenueCatSupportStatusLoader = Future<bool> Function();

/// Opens one URI using the host platform.
typedef ProjectUriLauncher = Future<bool> Function(Uri uri);

/// RevenueCat and URL-launcher implementation of [ProjectSupportService].
final class RevenueCatProjectSupportService implements ProjectSupportService {
  /// Target platform selecting the correct app-specific public API key.
  final TargetPlatform _platform;

  /// Whether production keys must be used instead of the Test Store key.
  final bool _releaseMode;

  /// Optional RevenueCat Test Store key used only outside release builds.
  final String _testApiKey;

  /// Public RevenueCat key for the Google Play application.
  final String _androidApiKey;

  /// Public RevenueCat key for the App Store application.
  final String _iosApiKey;

  /// Native SDK configuration boundary.
  final RevenueCatConfigurator _configureRevenueCat;

  /// Native paywall presentation boundary.
  final RevenueCatPaywallPresenter _presentRevenueCatPaywall;

  /// RevenueCat customer-status boundary.
  final RevenueCatSupportStatusLoader _loadSupportStatus;

  /// External browser boundary.
  final ProjectUriLauncher _launchUri;

  /// Whether this service instance already configured RevenueCat.
  bool _configured = false;

  /// In-flight configuration shared by concurrent button presses.
  Future<bool>? _configuration;

  /// Creates the production service with injectable native boundaries.
  factory RevenueCatProjectSupportService({
    TargetPlatform? platform,
    bool? releaseMode,
    String testApiKey = Env.revenueCatTestApiKey,
    String androidApiKey = Env.revenueCatAndroidApiKey,
    String iosApiKey = Env.revenueCatIosApiKey,
    RevenueCatConfigurator configureRevenueCat = _configurePurchases,
    RevenueCatPaywallPresenter presentRevenueCatPaywall = _presentPaywall,
    RevenueCatSupportStatusLoader loadSupportStatus = _hasSupportEntitlement,
    ProjectUriLauncher launchUri = _launchExternalUri,
  }) => RevenueCatProjectSupportService._(
    platform ?? defaultTargetPlatform,
    releaseMode ?? kReleaseMode,
    testApiKey,
    androidApiKey,
    iosApiKey,
    configureRevenueCat,
    presentRevenueCatPaywall,
    loadSupportStatus,
    launchUri,
  );

  /// Creates the service after every environment default has been resolved.
  RevenueCatProjectSupportService._(
    this._platform,
    this._releaseMode,
    this._testApiKey,
    this._androidApiKey,
    this._iosApiKey,
    this._configureRevenueCat,
    this._presentRevenueCatPaywall,
    this._loadSupportStatus,
    this._launchUri,
  );

  @override
  Future<bool> openSourceCode() => _open(
    ProjectSupportService.sourceCodeUri,
  );

  @override
  Future<bool> openWebsite() => _open(
    ProjectSupportService.websiteUri,
  );

  @override
  Future<bool> openPrivacyPolicy() => _open(
    ProjectSupportService.privacyPolicyUri,
  );

  @override
  Future<ProjectSupportPaywallResult> presentPaywall() async {
    if (!await _ensureConfigured()) {
      return .unavailable;
    }
    try {
      return await _presentRevenueCatPaywall();
    } catch (_) {
      return .error;
    }
  }

  @override
  Future<bool> hasSupported() async {
    if (!await _ensureConfigured()) {
      return false;
    }
    try {
      return await _loadSupportStatus();
    } catch (_) {
      return false;
    }
  }

  /// Opens [uri] without allowing a platform failure to escape into the UI.
  Future<bool> _open(Uri uri) async {
    try {
      return await _launchUri(uri);
    } catch (_) {
      return false;
    }
  }

  /// Configures RevenueCat once when support status or the paywall is requested.
  Future<bool> _ensureConfigured() {
    if (_configured) {
      return Future<bool>.value(true);
    }
    Future<bool>? pending = _configuration;
    if (pending != null) {
      return pending;
    }
    Future<bool> configuration = _configure();
    _configuration = configuration;
    return configuration;
  }

  /// Selects the correct public key and initializes the native purchases SDK.
  Future<bool> _configure() async {
    try {
      String? apiKey = _apiKey;
      if (apiKey == null) {
        return false;
      }
      await _configureRevenueCat(apiKey);
      _configured = true;
      return true;
    } catch (_) {
      return false;
    } finally {
      _configuration = null;
    }
  }

  /// Public API key appropriate for the build mode and current platform.
  String? get _apiKey {
    String testKey = _testApiKey.trim();
    if (!_releaseMode && testKey.isNotEmpty) {
      return testKey;
    }
    String platformKey = switch (_platform) {
      .android => _androidApiKey.trim(),
      .iOS => _iosApiKey.trim(),
      _ => '',
    };
    return platformKey.isEmpty ? null : platformKey;
  }
}

/// Configures RevenueCat without diagnostics or advertising identifiers.
Future<void> _configurePurchases(String apiKey) async {
  if (await Purchases.isConfigured) {
    return;
  }
  PurchasesConfiguration configuration = PurchasesConfiguration(apiKey)
    ..automaticDeviceIdentifierCollectionEnabled = false
    ..diagnosticsEnabled = false;
  await Purchases.configure(configuration);
}

/// Presents the current RevenueCat offering using the native paywall UI.
Future<ProjectSupportPaywallResult> _presentPaywall() async => switch (await RevenueCatUI.presentPaywall(displayCloseButton: true)) {
  .purchased => .purchased,
  .restored => .restored,
  .cancelled => .cancelled,
  .notPresented => .unavailable,
  .error => .error,
};

/// Reads the active supporter entitlement from the RevenueCat customer.
Future<bool> _hasSupportEntitlement() async => (await Purchases.getCustomerInfo()).entitlements.active.containsKey(ProjectSupportService.supporterEntitlementId);

/// Opens a public project link in the user's external browser.
Future<bool> _launchExternalUri(Uri uri) => launchUrl(
  uri,
  mode: .externalApplication,
);

/// Provides the optional project-support integration.
@Riverpod(keepAlive: true)
ProjectSupportService projectSupportService(Ref ref) => RevenueCatProjectSupportService();
