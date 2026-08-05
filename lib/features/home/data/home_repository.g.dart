// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the database-backed home repository.

@ProviderFor(homeRepository)
final homeRepositoryProvider = HomeRepositoryProvider._();

/// Provides the database-backed home repository.

final class HomeRepositoryProvider extends $FunctionalProvider<HomeRepository, HomeRepository, HomeRepository> with $Provider<HomeRepository> {
  /// Provides the database-backed home repository.
  HomeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRepositoryHash();

  @$internal
  @override
  $ProviderElement<HomeRepository> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  HomeRepository create(Ref ref) {
    return homeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRepository>(value),
    );
  }
}

String _$homeRepositoryHash() => r'629f877733ed176d6174c65bfe14587ade07c98a';

/// Watches the current home summary.

@ProviderFor(homeSummary)
final homeSummaryProvider = HomeSummaryProvider._();

/// Watches the current home summary.

final class HomeSummaryProvider extends $FunctionalProvider<AsyncValue<HomeSummary>, HomeSummary, Stream<HomeSummary>> with $FutureModifier<HomeSummary>, $StreamProvider<HomeSummary> {
  /// Watches the current home summary.
  HomeSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeSummaryHash();

  @$internal
  @override
  $StreamProviderElement<HomeSummary> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<HomeSummary> create(Ref ref) {
    return homeSummary(ref);
  }
}

String _$homeSummaryHash() => r'48f401df225c80fe4bcd89e0ceb7c3d80d823333';
