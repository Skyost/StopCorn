// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the database-backed daily check-in repository.

@ProviderFor(checkInRepository)
final checkInRepositoryProvider = CheckInRepositoryProvider._();

/// Provides the database-backed daily check-in repository.

final class CheckInRepositoryProvider extends $FunctionalProvider<CheckInRepository, CheckInRepository, CheckInRepository> with $Provider<CheckInRepository> {
  /// Provides the database-backed daily check-in repository.
  CheckInRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkInRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkInRepositoryHash();

  @$internal
  @override
  $ProviderElement<CheckInRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckInRepository create(Ref ref) {
    return checkInRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckInRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckInRepository>(value),
    );
  }
}

String _$checkInRepositoryHash() => r'fad6ba1f6bbe377e098110c30b42571ff29f8391';
