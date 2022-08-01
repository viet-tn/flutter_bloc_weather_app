import 'dart:developer';
import 'dart:ffi';

import '../../domain/entities/entities.dart';

class ThreeHrsWeatherModel extends ThreeHrsWeather {
  const ThreeHrsWeatherModel({
    required super.time,
    required super.precipitation,
    required super.temp,
    required super.tempMin,
    required super.tempMax,
    required super.feelsLike,
    required super.icon,
    required super.description,
    required super.humidity,
    required super.pressure,
    required super.visibility,
    required super.windSpeed,
    required super.windDegree,
    required super.clouds,
    required super.sunrise,
    required super.sunset,
    required super.timezone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'precipitation': precipitation,
      'temp': temp,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'feelsLike': feelsLike,
      'icon': icon,
      'description': description,
      'humidity': humidity,
      'pressure': pressure,
      'visibility': visibility,
      'windSpeed': windSpeed,
      'windDegree': windDegree,
      'clouds': clouds,
      'sunrise': sunrise,
      'sunset': sunset,
      'timeZone': timezone,
    };
  }

  factory ThreeHrsWeatherModel.fromMap(Map<String, dynamic> map) {
    return ThreeHrsWeatherModel(
      time: map['time'] as int,
      precipitation: (map['precipitation'] as num) as double,
      temp: map['temp'] as double,
      tempMin: map['tempMin'] as double,
      tempMax: map['tempMax'] as double,
      feelsLike: map['feelsLike'] as double,
      icon: map['icon'] as String,
      description: map['description'] as String,
      humidity: map['humidity'] as int,
      pressure: map['pressure'] as int,
      visibility: map['visibility'] as int,
      windSpeed: map['windSpeed'] as double,
      windDegree: map['windDegree'] as int,
      clouds: map['clouds'] as int,
      sunrise: map['sunrise'] as int,
      sunset: map['sunset'] as int,
      timezone: map['timeZone'] as int,
    );
  }
}
