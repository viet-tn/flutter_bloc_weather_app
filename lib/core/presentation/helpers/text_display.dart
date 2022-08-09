import '../../../features/settings/domain/entities/settings.dart';

class TextDisplay {
  static String temperature(double temp, WeatherMetric metric) {
    switch (metric) {
      case WeatherMetric.fahrenheit:
        return '${(temp * 9 / 5).round() + 32}°';
      case WeatherMetric.kevin:
        return '${(temp + 273.15).round()}K';
      default:
        return '${temp.round()}°';
    }
  }

  static String hourFromEpoch(int seconds) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static String toTitle(String string) {
    final words = string.split(' ');
    final uppercase = words.map((e) {
      if (e.trim().isEmpty) return '';
      return e[0].toUpperCase() + e.substring(1);
    });
    return uppercase.join(' ');
  }

  static String fromVisibility(int num) {
    if (num > 1000) {
      return '${num ~/ 1000} km';
    }
    return '$num m';
  }
}
