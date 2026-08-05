// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_check_in_notification_gateway.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Exposes the process-wide local-notification boundary injected by [main].

@ProviderFor(dailyCheckInNotificationGateway)
final dailyCheckInNotificationGatewayProvider = DailyCheckInNotificationGatewayProvider._();

/// Exposes the process-wide local-notification boundary injected by [main].

final class DailyCheckInNotificationGatewayProvider extends $FunctionalProvider<DailyCheckInNotificationGateway, DailyCheckInNotificationGateway, DailyCheckInNotificationGateway>
    with $Provider<DailyCheckInNotificationGateway> {
  /// Exposes the process-wide local-notification boundary injected by [main].
  DailyCheckInNotificationGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyCheckInNotificationGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyCheckInNotificationGatewayHash();

  @$internal
  @override
  $ProviderElement<DailyCheckInNotificationGateway> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DailyCheckInNotificationGateway create(Ref ref) {
    return dailyCheckInNotificationGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DailyCheckInNotificationGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DailyCheckInNotificationGateway>(
        value,
      ),
    );
  }
}

String _$dailyCheckInNotificationGatewayHash() => r'9a409bf1be7e7643c1d14e18dffaf0366310751e';
