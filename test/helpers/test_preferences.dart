import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Creates an isolated asynchronous preferences store for one test fixture.
SharedPreferencesAsync createTestPreferences({
  Map<String, Object> initialValues = const {},
  String? locale = 'fr',
}) {
  Map<String, Object> localizedValues = {
    ...?(locale == null ? null : {'locale': locale}),
    ...initialValues,
  };
  LocaleSettings.setLocaleSync(locale == 'fr' ? .fr : .en);
  SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.withData(localizedValues);
  return SharedPreferencesAsync();
}
