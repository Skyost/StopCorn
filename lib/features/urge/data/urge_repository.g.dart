// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'urge_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the database-backed urge repository.

@ProviderFor(urgeRepository)
final urgeRepositoryProvider = UrgeRepositoryProvider._();

/// Provides the database-backed urge repository.

final class UrgeRepositoryProvider extends $FunctionalProvider<UrgeRepository, UrgeRepository, UrgeRepository> with $Provider<UrgeRepository> {
  /// Provides the database-backed urge repository.
  UrgeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'urgeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$urgeRepositoryHash();

  @$internal
  @override
  $ProviderElement<UrgeRepository> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  UrgeRepository create(Ref ref) {
    return urgeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UrgeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UrgeRepository>(value),
    );
  }
}

String _$urgeRepositoryHash() => r'0e18caf5e6cee8f1da00b1b2530e5696fed02d8c';
