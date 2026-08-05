// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordered_strategies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Lists enabled strategies with personal-plan choices first.

@ProviderFor(orderedStrategies)
final orderedStrategiesProvider = OrderedStrategiesProvider._();

/// Lists enabled strategies with personal-plan choices first.

final class OrderedStrategiesProvider extends $FunctionalProvider<AsyncValue<List<StrategyOption>>, List<StrategyOption>, FutureOr<List<StrategyOption>>>
    with $FutureModifier<List<StrategyOption>>, $FutureProvider<List<StrategyOption>> {
  /// Lists enabled strategies with personal-plan choices first.
  OrderedStrategiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderedStrategiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderedStrategiesHash();

  @$internal
  @override
  $FutureProviderElement<List<StrategyOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StrategyOption>> create(Ref ref) {
    return orderedStrategies(ref);
  }
}

String _$orderedStrategiesHash() => r'73f1427dda38ba3f8c2e3a11b9ce5a0f4bc273cc';
