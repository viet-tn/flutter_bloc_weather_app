import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Weather extends Equatable {
  // Celcius
  final double temp;
  final double tempMin;
  final double tempMax;
  final double feelsLike;
  //
  final String icon;
  final String description;
  // Percentage
  final int humidity;
  // Hectopascal
  final int pressure;
  // Meter, maximum is 10.000m
  final int visibility;
  // Meter/sec
  final double windSpeed;
  // Degree
  final int windDegree;
  // Percentage
  final int clouds;
  // Datetime in seconds
  final int sunrise;
  final int sunset;
  // Hour in seconds
  final int timezone;

  const Weather({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.feelsLike,
    required this.icon,
    required this.description,
    required this.humidity,
    required this.pressure,
    required this.visibility,
    required this.windSpeed,
    required this.windDegree,
    required this.clouds,
    required this.sunrise,
    required this.sunset,
    required this.timezone,
  });

  @override
  List<Object> get props => [
        temp,
        temp,
        tempMin,
        tempMax,
        feelsLike,
        icon,
        description,
        humidity,
        pressure,
        visibility,
        windSpeed,
        windDegree,
        clouds,
        sunrise,
        sunset,
        timezone,
      ];
}
