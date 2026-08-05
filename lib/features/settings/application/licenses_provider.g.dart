// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'licenses_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Collects and sorts licenses registered by Flutter dependencies.

@ProviderFor(openSourceLicenses)
final openSourceLicensesProvider = OpenSourceLicensesProvider._();

/// Collects and sorts licenses registered by Flutter dependencies.

final class OpenSourceLicensesProvider extends $FunctionalProvider<AsyncValue<List<OpenSourceLicense>>, List<OpenSourceLicense>, FutureOr<List<OpenSourceLicense>>>
    with $FutureModifier<List<OpenSourceLicense>>, $FutureProvider<List<OpenSourceLicense>> {
  /// Collects and sorts licenses registered by Flutter dependencies.
  OpenSourceLicensesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openSourceLicensesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openSourceLicensesHash();

  @$internal
  @override
  $FutureProviderElement<List<OpenSourceLicense>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OpenSourceLicense>> create(Ref ref) {
    return openSourceLicenses(ref);
  }
}

String _$openSourceLicensesHash() => r'4b101b99fd175a7d4c0525525b9df81d47663d31';
