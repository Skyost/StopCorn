import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/features/project_support/application/project_support_service.dart';

part 'project_support_status_controller.g.dart';

/// Reports whether the supporter acknowledgement should be displayed.
///
/// The check is opt-in: as long as nobody has opened the support paywall,
/// StopCorn never contacts RevenueCat, so displaying Settings stays a purely
/// local operation. Opening the paywall already involves the store, and it is
/// also the only moment a purchase can exist, so it is what turns the check on
/// for later launches.
@riverpod
final class ProjectSupportStatusController extends _$ProjectSupportStatusController {
  @override
  Future<bool> build() async {
    AppPreferences preferences = ref.watch(appPreferencesProvider);
    if (!await preferences.getProjectSupportChecksEnabled()) {
      return false;
    }
    return ref.read(projectSupportServiceProvider).hasSupported();
  }

  /// Allows online status checks from now on, before the paywall opens.
  ///
  /// The preference is stored first so a purchase made in the store is still
  /// acknowledged after the application is closed mid-flow.
  Future<void> allowChecks() async {
    if (await ref.read(appPreferencesProvider).getProjectSupportChecksEnabled()) {
      return;
    }
    await ref.read(appPreferencesProvider).setProjectSupportChecksEnabled(true);
  }

  /// Re-reads the supporter status after the paywall closes.
  Future<void> refresh() async {
    state = const AsyncLoading<bool>();
    state = await AsyncValue.guard(
      () => ref.read(projectSupportServiceProvider).hasSupported(),
    );
  }
}
