// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumption_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the database-backed consumption repository.

@ProviderFor(consumptionRepository)
final consumptionRepositoryProvider = ConsumptionRepositoryProvider._();

/// Provides the database-backed consumption repository.

final class ConsumptionRepositoryProvider extends $FunctionalProvider<ConsumptionRepository, ConsumptionRepository, ConsumptionRepository> with $Provider<ConsumptionRepository> {
  /// Provides the database-backed consumption repository.
  ConsumptionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'consumptionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$consumptionRepositoryHash();

  @$internal
  @override
  $ProviderElement<ConsumptionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConsumptionRepository create(Ref ref) {
    return consumptionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConsumptionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConsumptionRepository>(value),
    );
  }
}

String _$consumptionRepositoryHash() => r'f366d138a54bf6b3157571fa6d00a49b8ccec8b8';
