import 'dart:convert';
import 'dart:developer';

import '../models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

const String cachedForcastList = 'CACHED_FORCAST_LIST';
const String cachedWeather = 'CACHED_WEATHER';

abstract class WeatherLocalDataSource {
  Future<void> cacheWeather(WeatherModel weatherModel);
  Future<void> cacheForcastList(List<ThreeHrsWeatherModel> forcastList);
  Future<WeatherModel> getLastWeather();
  Future<List<ThreeHrsWeatherModel>> getLastForcastList();
}

class WeatherLocalDataSourceImp implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImp({
    required this.sharedPreferences,
  });

  @override
  Future<void> cacheForcastList(List<ThreeHrsWeatherModel> forcastList) {
    return sharedPreferences.setString(
      cachedForcastList,
      json.encode(
        {
          cachedForcastList: forcastList
              .map(
                (e) => e.toMap(),
              )
              .toList(),
        },
      ),
    );
  }

  @override
  Future<void> cacheWeather(WeatherModel weatherModel) {
    log(json.encode(weatherModel.toMap()));
    return sharedPreferences.setString(
        cachedWeather, json.encode(weatherModel.toMap()));
  }

  @override
  Future<List<ThreeHrsWeatherModel>> getLastForcastList() {
    final jsonString = sharedPreferences.getString(cachedForcastList);
    if (jsonString == null) throw CacheException();
    return Future.value([
      for (var i in json.decode(jsonString)[cachedForcastList])
        ThreeHrsWeatherModel.fromMap(i)
    ]);
  }

  @override
  Future<WeatherModel> getLastWeather() {
    final jsonString = sharedPreferences.getString(cachedWeather);
    log(jsonString ?? 'null');
    if (jsonString == null) throw CacheException();
    return Future.value(WeatherModel.fromMap(json.decode(jsonString)));
  }
}
