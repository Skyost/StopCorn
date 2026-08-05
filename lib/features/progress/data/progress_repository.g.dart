// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the database-backed progress repository.

@ProviderFor(progressRepository)
final progressRepositoryProvider = ProgressRepositoryProvider._();

/// Provides the database-backed progress repository.

final class ProgressRepositoryProvider extends $FunctionalProvider<ProgressRepository, ProgressRepository, ProgressRepository> with $Provider<ProgressRepository> {
  /// Provides the database-backed progress repository.
  ProgressRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'progressRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$progressRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProgressRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProgressRepository create(Ref ref) {
    return progressRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProgressRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProgressRepository>(value),
    );
  }
}

String _$progressRepositoryHash() => r'755b25217b8643ba84de444efce946cd62a1bc73';
