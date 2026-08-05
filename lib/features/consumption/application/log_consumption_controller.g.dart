// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_consumption_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Owns and persists a voluntary consumption event form.
///
/// Passing an [eventId] edits that existing event instead of creating one.

@ProviderFor(LogConsumptionController)
final logConsumptionControllerProvider = LogConsumptionControllerFamily._();

/// Owns and persists a voluntary consumption event form.
///
/// Passing an [eventId] edits that existing event instead of creating one.
final class LogConsumptionControllerProvider extends $AsyncNotifierProvider<LogConsumptionController, LogConsumptionState> {
  /// Owns and persists a voluntary consumption event form.
  ///
  /// Passing an [eventId] edits that existing event instead of creating one.
  LogConsumptionControllerProvider._({
    required LogConsumptionControllerFamily super.from,
    required (String?, String?, String?) super.argument,
  }) : super(
         retry: null,
         name: r'logConsumptionControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$logConsumptionControllerHash();

  @override
  String toString() {
    return r'logConsumptionControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  LogConsumptionController create() => LogConsumptionController();

  @override
  bool operator ==(Object other) {
    return other is LogConsumptionControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$logConsumptionControllerHash() => r'5b7097d6e6729b6bd1aae97f1a1ffea501222382';

/// Owns and persists a voluntary consumption event form.
///
/// Passing an [eventId] edits that existing event instead of creating one.

final class LogConsumptionControllerFamily extends $Family
    with $ClassFamilyOverride<LogConsumptionController, AsyncValue<LogConsumptionState>, LogConsumptionState, FutureOr<LogConsumptionState>, (String?, String?, String?)> {
  LogConsumptionControllerFamily._()
    : super(
        retry: null,
        name: r'logConsumptionControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Owns and persists a voluntary consumption event form.
  ///
  /// Passing an [eventId] edits that existing event instead of creating one.

  LogConsumptionControllerProvider call(
    String? urgeSessionId,
    String? eventId,
    String? initialLocalDate,
  ) => LogConsumptionControllerProvider._(
    argument: (urgeSessionId, eventId, initialLocalDate),
    from: this,
  );

  @override
  String toString() => r'logConsumptionControllerProvider';
}

/// Owns and persists a voluntary consumption event form.
///
/// Passing an [eventId] edits that existing event instead of creating one.

abstract class _$LogConsumptionController extends $AsyncNotifier<LogConsumptionState> {
  late final _$args = ref.$arg as (String?, String?, String?);
  String? get urgeSessionId => _$args.$1;
  String? get eventId => _$args.$2;
  String? get initialLocalDate => _$args.$3;

  FutureOr<LogConsumptionState> build(
    String? urgeSessionId,
    String? eventId,
    String? initialLocalDate,
  );
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LogConsumptionState>, LogConsumptionState>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<LogConsumptionState>, LogConsumptionState>, AsyncValue<LogConsumptionState>, Object?, Object?>;
    return element.handleCreate(
      ref,
      () => build(_$args.$1, _$args.$2, _$args.$3),
    );
  }
}
