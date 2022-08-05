part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class ErrorWeather extends WeatherState {
  final String message;

  const ErrorWeather({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class LoadingWeather extends WeatherState {}

class LoadedWeather extends WeatherState {
  final String location;
  final Weather currentWeather;
  final List<ThreeHrsWeather> forcastList;

  const LoadedWeather({
    required this.location,
    required this.currentWeather,
    required this.forcastList,
  });

  @override
  List<Object> get props => [currentWeather, forcastList];
}
