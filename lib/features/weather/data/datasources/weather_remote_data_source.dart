import 'dart:convert';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/secrets/secret.dart';

const _baseUrl = 'api.openweathermap.org';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(double lat, double lon);
  Future<List<ThreeHrsWeatherModel>> get5Days3HrsWeathers(
      double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({
    required this.client,
  });

  Map<String, dynamic> _apiMapToWeatherModelMap(Map<String, dynamic> map) {
    final weather = map['weather'][0];
    final main = map['main'];
    final wind = map['wind'];
    final sys = map['sys'];

    return <String, dynamic>{
      'temp': main['temp'],
      'tempMin': main['temp_min'],
      'tempMax': main['temp_max'],
      'feelsLike': main['feels_like'],
      'icon': weather['icon'],
      'description': weather['description'],
      'humidity': main['humidity'],
      'pressure': main['pressure'],
      'visibility': map['visibility'],
      'windSpeed': wind['speed'],
      'windDegree': wind['deg'],
      'clouds': map['clouds']['all'],
      'sunrise': sys['sunrise'],
      'sunset': sys['sunset'],
      'timeZone': map['timezone'],
    };
  }

  Map<String, dynamic> _apiMapToThreeHrsWeatherModelMap(
      Map<String, dynamic> map) {
    final list = map['list'];
    final city = map['city'];

    return <String, dynamic>{
      'list': [
        ...list.map(
          (e) {
            final main = e['main'];
            final weather = e['weather'][0];
            final wind = e['wind'];
            return <String, dynamic>{
              'time': e['dt'],
              'precipitation': (e['pop'] as num).toDouble(),
              'temp': main['temp'],
              'tempMin': main['temp_min'],
              'tempMax': main['temp_max'],
              'feelsLike': main['feels_like'],
              'icon': weather['icon'],
              'description': weather['description'],
              'humidity': main['humidity'],
              'pressure': main['pressure'],
              'visibility': e['visibility'],
              'windSpeed': wind['speed'],
              'windDegree': wind['deg'],
              'clouds': e['clouds']['all'],
              'sunrise': city['sunrise'],
              'sunset': city['sunset'],
              'timeZone': city['timezone'],
            };
          },
        ).toList(),
      ],
    };
  }

  @override
  Future<List<ThreeHrsWeatherModel>> get5Days3HrsWeathers(
      double lat, double lon) async {
    final Uri uri = Uri.http(
      _baseUrl,
      '/data/2.5/forecast',
      <String, String>{
        'lat': lat.toString(),
        'lon': lon.toString(),
        'units': 'metric',
        'cnt': '16',
        'appid': apiKey,
      },
    );
    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) throw ServerException();

    final forcastList =
        _apiMapToThreeHrsWeatherModelMap(json.decode(response.body))['list'];
    return <ThreeHrsWeatherModel>[
      for (var forcast in forcastList) ThreeHrsWeatherModel.fromMap(forcast)
    ];
  }

  @override
  Future<WeatherModel> getCurrentWeather(double lat, double lon) async {
    final Uri uri = Uri.http(
      _baseUrl,
      '/data/2.5/weather',
      <String, String>{
        'lat': lat.toString(),
        'lon': lon.toString(),
        'units': 'metric',
        'appid': apiKey,
      },
    );
    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) throw ServerException();

    final weatherMap = _apiMapToWeatherModelMap(json.decode(response.body));
    return WeatherModel.fromMap(weatherMap);
  }
}
