import 'package:apo/core/di/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  PreferencesHelper._();

  static SharedPreferences get _sharedPreferences => getIt<SharedPreferences>();

  /// Removes a value from SharedPreferences with given [key].
  static Future<void> removeData(String key) async {
    await _sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences.
  static Future<void> clear() async {
    await _sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static Future<void> setData(String key, Object value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
    } else {
      throw ArgumentError(
        'Unsupported value type for SharedPreferences: ${value.runtimeType}',
      );
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static bool getBool(String key) {
    return _sharedPreferences.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with given [key].
  static double getDouble(String key) {
    return _sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  static int getInt(String key) {
    return _sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets a String value from SharedPreferences with given [key].
  static String getString(String key) {
    return _sharedPreferences.getString(key) ?? '';
  }
}
