import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class WeatherPageArguments {
  final String location;
  final double lat;
  final double lon;

  static const key = 'WEATHER_PAGE_ARGUMENTS_KEY';

  const WeatherPageArguments({
    required this.location,
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location,
      'lat': lat,
      'lon': lon,
    };
  }

  factory WeatherPageArguments.fromMap(Map<String, dynamic> map) {
    return WeatherPageArguments(
      location: map['location'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherPageArguments.fromJson(String source) =>
      WeatherPageArguments.fromMap(json.decode(source) as Map<String, dynamic>);
}
