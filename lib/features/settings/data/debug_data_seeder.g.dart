// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_data_seeder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the debug-only local sample-data seeder.

@ProviderFor(debugDataSeeder)
final debugDataSeederProvider = DebugDataSeederProvider._();

/// Provides the debug-only local sample-data seeder.

final class DebugDataSeederProvider extends $FunctionalProvider<DebugDataSeeder, DebugDataSeeder, DebugDataSeeder> with $Provider<DebugDataSeeder> {
  /// Provides the debug-only local sample-data seeder.
  DebugDataSeederProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugDataSeederProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugDataSeederHash();

  @$internal
  @override
  $ProviderElement<DebugDataSeeder> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  DebugDataSeeder create(Ref ref) {
    return debugDataSeeder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugDataSeeder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugDataSeeder>(value),
    );
  }
}

String _$debugDataSeederHash() => r'adb439dd19486ce7799110e15a9b50353f629307';
