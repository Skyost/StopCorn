// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the localized database-backed learning repository.

@ProviderFor(learningRepository)
final learningRepositoryProvider = LearningRepositoryProvider._();

/// Provides the localized database-backed learning repository.

final class LearningRepositoryProvider extends $FunctionalProvider<LearningRepository, LearningRepository, LearningRepository> with $Provider<LearningRepository> {
  /// Provides the localized database-backed learning repository.
  LearningRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learningRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learningRepositoryHash();

  @$internal
  @override
  $ProviderElement<LearningRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LearningRepository create(Ref ref) {
    return learningRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LearningRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LearningRepository>(value),
    );
  }
}

String _$learningRepositoryHash() => r'fb382e404581e81cc662dec168acbedab98af3ce';
