part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends WeatherEvent {
  final double lat;
  final double lon;
  final String location;

  const FetchDataEvent({
    required this.lat,
    required this.lon,
    required this.location,
  });

  @override
  List<Object> get props => [lat, lon];
}

class FetchDataFromCacheEvent extends WeatherEvent {
  final String location;

  const FetchDataFromCacheEvent(this.location);

  @override
  List<Object> get props => [location];
}
