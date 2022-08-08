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
      temp: (map['temp'] as num).toDouble(),
      tempMin: (map['tempMin'] as num).toDouble(),
      tempMax: (map['tempMax'] as num).toDouble(),
      feelsLike: (map['feelsLike'] as num).toDouble(),
      icon: map['icon'] as String,
      description: map['description'] as String,
      humidity: (map['humidity'] as num).toInt(),
      pressure: (map['pressure'] as num).toInt(),
      visibility: (map['visibility'] as num).toInt(),
      windSpeed: (map['windSpeed'] as num).toDouble(),
      windDegree: (map['windDegree'] as num).toInt(),
      clouds: (map['clouds'] as num).toInt(),
      sunrise: (map['sunrise'] as num).toInt(),
      sunset: (map['sunset'] as num).toInt(),
      timezone: (map['timeZone'] as num).toInt(),
    );
  }
}
