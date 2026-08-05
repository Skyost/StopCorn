import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/features/urge/data/coping_strategy_repository.dart';

part 'ordered_strategies_provider.g.dart';

/// Minimal strategy data needed by the urge-selection screen.
final class StrategyOption {
  /// Stable coping-strategy identifier.
  final String id;

  /// Creation timestamp used as a deterministic fallback order.
  final DateTime createdAt;

  /// Whether the strategy belongs to the user's personal backup plan.
  final bool isInBackupPlan;

  /// Creates a strategy option.
  const StrategyOption({
    required this.id,
    required this.createdAt,
    required this.isInBackupPlan,
  });
}

/// Lists enabled strategies with personal-plan choices first.
@riverpod
Future<List<StrategyOption>> orderedStrategies(Ref ref) async {
  List<CopingStrategy> stored = await ref.watch(copingStrategyRepositoryProvider).getEnabled();
  List<String> selected = await ref.watch(appPreferencesProvider).getSelectedStrategyIds();
  Set<String> selectedIds = selected.toSet();
  List<StrategyOption> strategies = stored
      .map(
        (strategy) => StrategyOption(
          id: strategy.id,
          createdAt: strategy.createdAt,
          isInBackupPlan: selectedIds.contains(strategy.id),
        ),
      )
      .toList();
  Map<String, int> selectedOrder = {
    for (final (int index, String id) in selected.indexed) id: index,
  };
  strategies.sort((first, second) {
    int? firstIndex = selectedOrder[first.id];
    int? secondIndex = selectedOrder[second.id];
    if (firstIndex != null && secondIndex != null) {
      return firstIndex.compareTo(secondIndex);
    }
    if (firstIndex != null) {
      return -1;
    }
    if (secondIndex != null) {
      return 1;
    }
    return first.createdAt.compareTo(second.createdAt);
  });
  return strategies;
}
