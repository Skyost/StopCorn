// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coping_strategy_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the database-backed coping-strategy repository.

@ProviderFor(copingStrategyRepository)
final copingStrategyRepositoryProvider = CopingStrategyRepositoryProvider._();

/// Provides the database-backed coping-strategy repository.

final class CopingStrategyRepositoryProvider extends $FunctionalProvider<CopingStrategyRepository, CopingStrategyRepository, CopingStrategyRepository> with $Provider<CopingStrategyRepository> {
  /// Provides the database-backed coping-strategy repository.
  CopingStrategyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'copingStrategyRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$copingStrategyRepositoryHash();

  @$internal
  @override
  $ProviderElement<CopingStrategyRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CopingStrategyRepository create(Ref ref) {
    return copingStrategyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CopingStrategyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CopingStrategyRepository>(value),
    );
  }
}

String _$copingStrategyRepositoryHash() => r'6d1a0ccbec6906c61ed6ccce766ee2c01794ee1e';
