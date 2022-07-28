// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum WeatherAppTheme { dark, light }

enum WeatherMetric { celcius, fahrenheit }

class Settings extends Equatable {
  final WeatherAppTheme theme;
  final WeatherMetric metric;

  const Settings({
    required this.theme,
    required this.metric,
  });

  @override
  List<Object> get props => [theme, metric];

  Settings copyWith({
    WeatherAppTheme? theme,
    WeatherMetric? metric,
  }) {
    return Settings(
      theme: theme ?? this.theme,
      metric: metric ?? this.metric,
    );
  }
}
