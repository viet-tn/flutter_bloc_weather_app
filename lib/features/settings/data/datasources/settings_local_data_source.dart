import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/settings_model.dart';

const cachedSettings = 'CACHED_SETTINGS';

abstract class SettingsLocalDataSource {
  Future<SettingsModel> getSettings();
  Future<void> cacheSettings(SettingsModel settingsModel);
}

class SettingsLocalDataSourceImp implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImp({
    required this.sharedPreferences,
  });
  @override
  Future<SettingsModel> getSettings() {
    final jsonString = sharedPreferences.getString(cachedSettings);
    if (jsonString == null) throw CacheException();
    return Future.value(SettingsModel.fromMap(json.decode(jsonString)));
  }

  @override
  Future<void> cacheSettings(SettingsModel settingsModel) {
    return sharedPreferences.setString(
      cachedSettings,
      json.encode(settingsModel.toMap()),
    );
  }
}
