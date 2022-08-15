part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final String location;
  final Weather currentWeather;
  final List<ThreeHrsWeather> forcastList;

  const WeatherLoaded({
    required this.location,
    required this.currentWeather,
    required this.forcastList,
  });

  @override
  List<Object> get props => [currentWeather, forcastList];
}
