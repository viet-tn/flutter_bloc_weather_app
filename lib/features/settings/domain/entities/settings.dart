import 'package:equatable/equatable.dart';

enum WeatherAppTheme { dark, light }

enum WeatherMetric { celcius, fahrenheit, kevin }

class Settings extends Equatable {
  final WeatherAppTheme theme;
  final WeatherMetric metric;

  const Settings({
    required this.theme,
    required this.metric,
  });

  static const defaultSettings = Settings(
    theme: WeatherAppTheme.light,
    metric: WeatherMetric.celcius,
  );

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
