// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_check_in_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Owns and persists the daily check-in form.
///
/// Passing a [requestedDate] edits the check-in of that local calendar day
/// instead of today's, which is how a past entry is corrected.

@ProviderFor(DailyCheckInController)
final dailyCheckInControllerProvider = DailyCheckInControllerFamily._();

/// Owns and persists the daily check-in form.
///
/// Passing a [requestedDate] edits the check-in of that local calendar day
/// instead of today's, which is how a past entry is corrected.
final class DailyCheckInControllerProvider extends $AsyncNotifierProvider<DailyCheckInController, DailyCheckInState> {
  /// Owns and persists the daily check-in form.
  ///
  /// Passing a [requestedDate] edits the check-in of that local calendar day
  /// instead of today's, which is how a past entry is corrected.
  DailyCheckInControllerProvider._({
    required DailyCheckInControllerFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'dailyCheckInControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dailyCheckInControllerHash();

  @override
  String toString() {
    return r'dailyCheckInControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DailyCheckInController create() => DailyCheckInController();

  @override
  bool operator ==(Object other) {
    return other is DailyCheckInControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dailyCheckInControllerHash() => r'a8c8e9b5c58c2af9d004fa9fc66231a24bd28434';

/// Owns and persists the daily check-in form.
///
/// Passing a [requestedDate] edits the check-in of that local calendar day
/// instead of today's, which is how a past entry is corrected.

final class DailyCheckInControllerFamily extends $Family with $ClassFamilyOverride<DailyCheckInController, AsyncValue<DailyCheckInState>, DailyCheckInState, FutureOr<DailyCheckInState>, String?> {
  DailyCheckInControllerFamily._()
    : super(
        retry: null,
        name: r'dailyCheckInControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Owns and persists the daily check-in form.
  ///
  /// Passing a [requestedDate] edits the check-in of that local calendar day
  /// instead of today's, which is how a past entry is corrected.

  DailyCheckInControllerProvider call(String? requestedDate) => DailyCheckInControllerProvider._(argument: requestedDate, from: this);

  @override
  String toString() => r'dailyCheckInControllerProvider';
}

/// Owns and persists the daily check-in form.
///
/// Passing a [requestedDate] edits the check-in of that local calendar day
/// instead of today's, which is how a past entry is corrected.

abstract class _$DailyCheckInController extends $AsyncNotifier<DailyCheckInState> {
  late final _$args = ref.$arg as String?;
  String? get requestedDate => _$args;

  FutureOr<DailyCheckInState> build(String? requestedDate);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DailyCheckInState>, DailyCheckInState>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<DailyCheckInState>, DailyCheckInState>, AsyncValue<DailyCheckInState>, Object?, Object?>;
    return element.handleCreate(ref, () => build(_$args));
  }
}
