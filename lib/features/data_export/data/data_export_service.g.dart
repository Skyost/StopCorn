// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_export_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the production export service.

@ProviderFor(dataExportService)
final dataExportServiceProvider = DataExportServiceProvider._();

/// Provides the production export service.

final class DataExportServiceProvider extends $FunctionalProvider<DataExportService, DataExportService, DataExportService> with $Provider<DataExportService> {
  /// Provides the production export service.
  DataExportServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dataExportServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dataExportServiceHash();

  @$internal
  @override
  $ProviderElement<DataExportService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DataExportService create(Ref ref) {
    return dataExportService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DataExportService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DataExportService>(value),
    );
  }
}

String _$dataExportServiceHash() => r'8e4f1ced16cd26e5f1e2c9dd977f9ba1a490aafd';
