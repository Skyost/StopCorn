// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the repository that assembles the combined journal.

@ProviderFor(journalRepository)
final journalRepositoryProvider = JournalRepositoryProvider._();

/// Provides the repository that assembles the combined journal.

final class JournalRepositoryProvider extends $FunctionalProvider<JournalRepository, JournalRepository, JournalRepository> with $Provider<JournalRepository> {
  /// Provides the repository that assembles the combined journal.
  JournalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalRepositoryHash();

  @$internal
  @override
  $ProviderElement<JournalRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  JournalRepository create(Ref ref) {
    return journalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JournalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JournalRepository>(value),
    );
  }
}

String _$journalRepositoryHash() => r'5c34d4ac8b3584a77f62fc710c4f5cf63fade48d';

/// Loads the combined journal and releases it when its screen is closed.

@ProviderFor(journalDays)
final journalDaysProvider = JournalDaysProvider._();

/// Loads the combined journal and releases it when its screen is closed.

final class JournalDaysProvider extends $FunctionalProvider<AsyncValue<List<JournalDay>>, List<JournalDay>, FutureOr<List<JournalDay>>>
    with $FutureModifier<List<JournalDay>>, $FutureProvider<List<JournalDay>> {
  /// Loads the combined journal and releases it when its screen is closed.
  JournalDaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalDaysProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalDaysHash();

  @$internal
  @override
  $FutureProviderElement<List<JournalDay>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<JournalDay>> create(Ref ref) {
    return journalDays(ref);
  }
}

String _$journalDaysHash() => r'936a5c34e769dbf158705dddd954646ff5947b5c';
