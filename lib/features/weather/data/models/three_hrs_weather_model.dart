import '../../domain/entities/entities.dart';

class ThreeHrsWeatherModel extends ThreeHrsWeather {
  const ThreeHrsWeatherModel({
    required super.lat,
    required super.lon,
    required super.location,
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
      'lat': lat,
      'lon': lon,
      'location': location,
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
      lat: (map['lat'] as num).toDouble(),
      lon: (map['lon'] as num).toDouble(),
      location: map['location'] as String,
      time: map['time'] as int,
      precipitation: (map['precipitation'] as num).toDouble(),
      temp: (map['temp'] as num).toDouble(),
      tempMin: (map['tempMin'] as num).toDouble(),
      tempMax: (map['tempMax'] as num).toDouble(),
      feelsLike: (map['feelsLike'] as num).toDouble(),
      icon: map['icon'] as String,
      description: map['description'] as String,
      humidity: (map['humidity'] as num).toInt(),
      pressure: (map['pressure'] as num).toInt(),
      visibility: (map['visibility'] as num).toInt(),
      windSpeed: map['windSpeed'].toDouble(),
      windDegree: (map['windDegree'] as num).toInt(),
      clouds: (map['clouds'] as num).toInt(),
      sunrise: (map['sunrise'] as num).toInt(),
      sunset: (map['sunset'] as num).toInt(),
      timezone: (map['timeZone'] as num).toInt(),
    );
  }
}
