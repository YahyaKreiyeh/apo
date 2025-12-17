import 'package:apo/core/constants/secure_storage_keys.dart';
import 'package:apo/core/di/dependency_injection.dart';
import 'package:apo/core/networking/dio_factory.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  SecureStorageHelper._();

  static FlutterSecureStorage get _secureStorage =>
      getIt<FlutterSecureStorage>();

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static Future<void> setString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Gets a String value from FlutterSecureStorage with given [key].
  static Future<String> getString(String key) async {
    return await _secureStorage.read(key: key) ?? '';
  }

  /// Removes a value from FlutterSecureStorage with given [key].
  static Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
  }

  /// Removes all keys and values in the FlutterSecureStorage.
  static Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

  /// Saves the authentication token to secure storage and updates Dio headers.
  static Future<void> saveAuthToken(String token) async {
    await setString(SecureStorageKey.authToken, token);
    DioFactory.setAuthToken(token);
  }

  /// Gets the authentication token from secure storage.
  static Future<String> getAuthToken() async {
    return await getString(SecureStorageKey.authToken);
  }

  /// Removes the authentication token from secure storage and clears Dio headers.
  static Future<void> clearAuthToken() async {
    await remove(SecureStorageKey.authToken);
    DioFactory.setAuthToken(null);
  }

  /// Saves the FCM token to secure storage.
  static Future<void> saveFcmToken(String token) async {
    await setString(SecureStorageKey.fcmToken, token);
  }

  /// Gets the FCM token from secure storage.
  static Future<String> getFcmToken() async {
    return await getString(SecureStorageKey.fcmToken);
  }

  /// Removes the stored FCM token from secure storage.
  static Future<void> clearFcmToken() async {
    await remove(SecureStorageKey.fcmToken);
  }
}
