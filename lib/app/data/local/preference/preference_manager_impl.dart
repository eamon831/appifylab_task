import 'package:appifylab_task/flavors/build_config.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/app/data/local/preference/preference_manager.dart';

class PreferenceManagerImpl implements PreferenceManager {
  final Future<SharedPreferences> _preference = SharedPreferences.getInstance();
  final logger = BuildConfig.instance.config.logger;

  Future<T> _handlePreferenceError<T>(
    Future<T> Function() action,
    T defaultValue,
  ) async {
    try {
      return await action();
    } on Exception catch (e) {
      if (kDebugMode) {
        logger.e('Preference error: $e');
      }
      return defaultValue;
    }
  }

  @override
  Future<String> getString(String key, {String defaultValue = ''}) {
    return _handlePreferenceError(
      () async {
        final preference = await _preference;
        return preference.getString(key) ?? defaultValue;
      },
      defaultValue,
    );
  }

  @override
  Future<bool> setString(String key, String value) {
    return _handlePreferenceError(
      () async {
        final preference = await _preference;
        return preference.setString(key, value);
      },
      false,
    );
  }

  @override
  Future<int> getInt(String key, {int defaultValue = 0}) {
    return _handlePreferenceError(
      () async {
        final preference = await _preference;
        return preference.getInt(key) ?? defaultValue;
      },
      defaultValue,
    );
  }

  @override
  Future<bool> setInt(String key, int value) {
    return _handlePreferenceError(
      () async {
        final preference = await _preference;
        return preference.setInt(key, value);
      },
      false,
    );
  }

  @override
  Future<double> getDouble(String key, {double defaultValue = 0.0}) {
    return _handlePreferenceError(
      () async {
        final preference = await _preference;
        return preference.getDouble(key) ?? defaultValue;
      },
      defaultValue,
    );
  }

  @override
  Future<bool> setDouble(String key, double value) {
    return _handlePreferenceError(
      () async {
        final preference = await _preference;
        return preference.setDouble(key, value);
      },
      false,
    );
  }

  @override
  Future<bool> getBool(String key, {bool defaultValue = false}) {
    return _handlePreferenceError(
      () async {
        final preference = await _preference;
        return preference.getBool(key) ?? defaultValue;
      },
      defaultValue,
    );
  }

  @override
  Future<bool> setBool(String key, {required bool value}) {
    return _handlePreferenceError(
      () async {
        final preference = await _preference;
        return preference.setBool(key, value);
      },
      false,
    );
  }

  @override
  Future<List<String>> getStringList(
    String key, {
    List<String> defaultValue = const [],
  }) {
    return _handlePreferenceError(
      () async {
        final preference = await _preference;
        return preference.getStringList(key) ?? defaultValue;
      },
      defaultValue,
    );
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    return _handlePreferenceError(
      () async {
        final preference = await _preference;
        return preference.setStringList(key, value);
      },
      false,
    );
  }

  @override
  Future<bool> remove(String key) {
    return _handlePreferenceError(
      () async {
        final preference = await _preference;
        return preference.remove(key);
      },
      false,
    );
  }

  @override
  Future<bool> clear() {
    return _handlePreferenceError(
      () async {
        final preference = await _preference;
        return preference.clear();
      },
      false,
    );
  }
}
