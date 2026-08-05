// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the database-backed goal repository.

@ProviderFor(goalRepository)
final goalRepositoryProvider = GoalRepositoryProvider._();

/// Provides the database-backed goal repository.

final class GoalRepositoryProvider extends $FunctionalProvider<GoalRepository, GoalRepository, GoalRepository> with $Provider<GoalRepository> {
  /// Provides the database-backed goal repository.
  GoalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalRepositoryHash();

  @$internal
  @override
  $ProviderElement<GoalRepository> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  GoalRepository create(Ref ref) {
    return goalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalRepository>(value),
    );
  }
}

String _$goalRepositoryHash() => r'80eb0d0589305b0efb96c0d0a4fb33825d232ca7';

/// Watches every goal the person has set, newest first.

@ProviderFor(goalHistory)
final goalHistoryProvider = GoalHistoryProvider._();

/// Watches every goal the person has set, newest first.

final class GoalHistoryProvider extends $FunctionalProvider<AsyncValue<List<GoalHistoryEntry>>, List<GoalHistoryEntry>, Stream<List<GoalHistoryEntry>>>
    with $FutureModifier<List<GoalHistoryEntry>>, $StreamProvider<List<GoalHistoryEntry>> {
  /// Watches every goal the person has set, newest first.
  GoalHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalHistoryHash();

  @$internal
  @override
  $StreamProviderElement<List<GoalHistoryEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<GoalHistoryEntry>> create(Ref ref) {
    return goalHistory(ref);
  }
}

String _$goalHistoryHash() => r'6a95b15d137d94e45af9c66de48a28e3bab6b6ce';
