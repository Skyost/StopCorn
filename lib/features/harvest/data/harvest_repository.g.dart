// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'harvest_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the database-backed harvest repository.

@ProviderFor(harvestRepository)
final harvestRepositoryProvider = HarvestRepositoryProvider._();

/// Provides the database-backed harvest repository.

final class HarvestRepositoryProvider extends $FunctionalProvider<HarvestRepository, HarvestRepository, HarvestRepository> with $Provider<HarvestRepository> {
  /// Provides the database-backed harvest repository.
  HarvestRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'harvestRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$harvestRepositoryHash();

  @$internal
  @override
  $ProviderElement<HarvestRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HarvestRepository create(Ref ref) {
    return harvestRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HarvestRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HarvestRepository>(value),
    );
  }
}

String _$harvestRepositoryHash() => r'7b15fd6c975d96331550f99c9008c5ee7977f422';
