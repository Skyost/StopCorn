// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_check_in_reminder_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the local daily check-in reminder coordinator.

@ProviderFor(dailyCheckInReminderService)
final dailyCheckInReminderServiceProvider = DailyCheckInReminderServiceProvider._();

/// Provides the local daily check-in reminder coordinator.

final class DailyCheckInReminderServiceProvider extends $FunctionalProvider<DailyCheckInReminderService, DailyCheckInReminderService, DailyCheckInReminderService>
    with $Provider<DailyCheckInReminderService> {
  /// Provides the local daily check-in reminder coordinator.
  DailyCheckInReminderServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyCheckInReminderServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyCheckInReminderServiceHash();

  @$internal
  @override
  $ProviderElement<DailyCheckInReminderService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DailyCheckInReminderService create(Ref ref) {
    return dailyCheckInReminderService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DailyCheckInReminderService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DailyCheckInReminderService>(value),
    );
  }
}

String _$dailyCheckInReminderServiceHash() => r'be85200f5d1c7eb6c4abdd35f4b25edfea5098f0';
