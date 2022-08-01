// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class Error extends WeatherState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class Loading extends WeatherState {}

class Loaded extends WeatherState {
  final Weather currentWeather;
  final List<ThreeHrsWeather> forcastList;

  const Loaded({
    required this.currentWeather,
    required this.forcastList,
  });

  @override
  List<Object> get props => [currentWeather, forcastList];
}
