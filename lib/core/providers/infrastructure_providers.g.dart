// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infrastructure_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Exposes the process-wide database injected by [main].

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// Exposes the process-wide database injected by [main].

final class AppDatabaseProvider extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase> with $Provider<AppDatabase> {
  /// Exposes the process-wide database injected by [main].
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'9bfa0a4a1cc8fd88f4bc8b3e7d29e52fc10e4f71';

/// Exposes the process-wide asynchronous preferences facade.

@ProviderFor(appPreferences)
final appPreferencesProvider = AppPreferencesProvider._();

/// Exposes the process-wide asynchronous preferences facade.

final class AppPreferencesProvider extends $FunctionalProvider<AppPreferences, AppPreferences, AppPreferences> with $Provider<AppPreferences> {
  /// Exposes the process-wide asynchronous preferences facade.
  AppPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appPreferencesHash();

  @$internal
  @override
  $ProviderElement<AppPreferences> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  AppPreferences create(Ref ref) {
    return appPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppPreferences>(value),
    );
  }
}

String _$appPreferencesHash() => r'f79c657694bb113398ddbbfcd754e2fb6d6711cf';

/// Exposes the application clock, replaceable with a fixed clock in tests.

@ProviderFor(appClock)
final appClockProvider = AppClockProvider._();

/// Exposes the application clock, replaceable with a fixed clock in tests.

final class AppClockProvider extends $FunctionalProvider<AppClock, AppClock, AppClock> with $Provider<AppClock> {
  /// Exposes the application clock, replaceable with a fixed clock in tests.
  AppClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appClockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appClockHash();

  @$internal
  @override
  $ProviderElement<AppClock> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  AppClock create(Ref ref) {
    return appClock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppClock value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppClock>(value),
    );
  }
}

String _$appClockHash() => r'e1fb0e382f31b2588127780c0985e470e145cba3';

/// Exposes the UUID generator used for local entity identifiers.

@ProviderFor(uuid)
final uuidProvider = UuidProvider._();

/// Exposes the UUID generator used for local entity identifiers.

final class UuidProvider extends $FunctionalProvider<Uuid, Uuid, Uuid> with $Provider<Uuid> {
  /// Exposes the UUID generator used for local entity identifiers.
  UuidProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uuidProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uuidHash();

  @$internal
  @override
  $ProviderElement<Uuid> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Uuid create(Ref ref) {
    return uuid(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Uuid value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Uuid>(value),
    );
  }
}

String _$uuidHash() => r'63633bd7add95a8e80ee3cd2fbccd7919f6eebc9';
