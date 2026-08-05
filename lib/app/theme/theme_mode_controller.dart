import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';

part 'theme_mode_controller.g.dart';

/// Loads and persists the theme mode selected by the user.
@Riverpod(keepAlive: true)
final class ThemeModeController extends _$ThemeModeController {
  @override
  Future<AppThemeMode> build() => ref.watch(appPreferencesProvider).getThemeMode();

  /// Applies [mode] optimistically and persists it, rolling back on failure.
  Future<void> setThemeMode(AppThemeMode mode) async {
    AsyncValue<AppThemeMode> previous = state;
    state = AsyncData<AppThemeMode>(mode);
    try {
      await ref.read(appPreferencesProvider).setThemeMode(mode);
    } catch (error, stackTrace) {
      state = previous;
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
