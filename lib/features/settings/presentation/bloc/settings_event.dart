part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class FetchSettingEvent extends SettingsEvent {
  const FetchSettingEvent();

  @override
  List<Object> get props => [];
}

class ChangeWeatherMetricEvent extends SettingsEvent {
  final WeatherMetric metric;

  const ChangeWeatherMetricEvent({
    required this.metric,
  });

  @override
  List<Object> get props => [metric];
}

class ChangeWeatherAppThemeEvent extends SettingsEvent {
  final WeatherAppTheme theme;

  const ChangeWeatherAppThemeEvent({
    required this.theme,
  });

  @override
  List<Object> get props => [theme];
}
