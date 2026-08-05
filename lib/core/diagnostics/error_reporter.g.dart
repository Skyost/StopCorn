// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_reporter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Exposes the process-wide error-reporting boundary injected by `main`.

@ProviderFor(errorReporter)
final errorReporterProvider = ErrorReporterProvider._();

/// Exposes the process-wide error-reporting boundary injected by `main`.

final class ErrorReporterProvider extends $FunctionalProvider<ErrorReporter, ErrorReporter, ErrorReporter> with $Provider<ErrorReporter> {
  /// Exposes the process-wide error-reporting boundary injected by `main`.
  ErrorReporterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'errorReporterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$errorReporterHash();

  @$internal
  @override
  $ProviderElement<ErrorReporter> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  ErrorReporter create(Ref ref) {
    return errorReporter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ErrorReporter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ErrorReporter>(value),
    );
  }
}

String _$errorReporterHash() => r'a9ab5adeb2707180cdf218c59041e6db7669fa7a';
