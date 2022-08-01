import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
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
      'temp': temp,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'feelsLike': feelsLike,
      'icon': icon,
      'humidity': humidity,
      'pressure': pressure,
      'visibility': visibility,
      'windSpeed': windSpeed,
      'windDegree': windDegree,
      'clouds': clouds,
      'sunrise': sunrise,
      'sunset': sunset,
      'timezone': timezone,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
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
