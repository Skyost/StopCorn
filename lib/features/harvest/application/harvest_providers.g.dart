// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'harvest_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Watches the locally derived harvest for the current calendar day.

@ProviderFor(harvestSummary)
final harvestSummaryProvider = HarvestSummaryProvider._();

/// Watches the locally derived harvest for the current calendar day.

final class HarvestSummaryProvider extends $FunctionalProvider<AsyncValue<HarvestSummary>, HarvestSummary, Stream<HarvestSummary>>
    with $FutureModifier<HarvestSummary>, $StreamProvider<HarvestSummary> {
  /// Watches the locally derived harvest for the current calendar day.
  HarvestSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'harvestSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$harvestSummaryHash();

  @$internal
  @override
  $StreamProviderElement<HarvestSummary> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<HarvestSummary> create(Ref ref) {
    return harvestSummary(ref);
  }
}

String _$harvestSummaryHash() => r'e99783ef2c4c32dc87464ca1a262b5457da09297';

/// Watches whether the optional harvest presentation is enabled.

@ProviderFor(harvestVisibility)
final harvestVisibilityProvider = HarvestVisibilityProvider._();

/// Watches whether the optional harvest presentation is enabled.

final class HarvestVisibilityProvider extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>> with $FutureModifier<bool>, $StreamProvider<bool> {
  /// Watches whether the optional harvest presentation is enabled.
  HarvestVisibilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'harvestVisibilityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$harvestVisibilityHash();

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) => $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    return harvestVisibility(ref);
  }
}

String _$harvestVisibilityHash() => r'4a1bdc40c28d0b4abf8d4ca31163b05ad006e6e9';

/// Provides reward detection around actions that may cultivate today.

@ProviderFor(harvestRewardService)
final harvestRewardServiceProvider = HarvestRewardServiceProvider._();

/// Provides reward detection around actions that may cultivate today.

final class HarvestRewardServiceProvider extends $FunctionalProvider<HarvestRewardService, HarvestRewardService, HarvestRewardService> with $Provider<HarvestRewardService> {
  /// Provides reward detection around actions that may cultivate today.
  HarvestRewardServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'harvestRewardServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$harvestRewardServiceHash();

  @$internal
  @override
  $ProviderElement<HarvestRewardService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HarvestRewardService create(Ref ref) {
    return harvestRewardService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HarvestRewardService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HarvestRewardService>(value),
    );
  }
}

String _$harvestRewardServiceHash() => r'efa7eb9b79ec8c1ba73cff02abd151d03da7a451';
