import 'package:flutter/foundation.dart';

import 'weather.dart';

@immutable
class ThreeHrsWeather extends Weather {
  // Time UTC in seconds
  final int time;
  // [0,1] 1 means 100%
  final double precipitation;

  const ThreeHrsWeather({
    required this.time,
    required this.precipitation,
    required super.lat,
    required super.lon,
    required super.location,
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

  @override
  List<Object> get props => [...super.props, time, precipitation];
}
