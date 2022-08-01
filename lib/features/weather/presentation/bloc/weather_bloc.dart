import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/get_5_days_3_hrs_weather.dart';
import '../../domain/usecases/get_current_weather.dart';
import '../../domain/usecases/params.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather _getCurrentWeather;
  final Get5Days3HrsWeather _get5days3hrsWeather;
  WeatherBloc(GetCurrentWeather getCurrentWeather,
      Get5Days3HrsWeather get5days3hrsWeather)
      : _getCurrentWeather = getCurrentWeather,
        _get5days3hrsWeather = get5days3hrsWeather,
        super(WeatherInitial()) {
    on<FetchDataEvent>(_onFetchDataEvent);
  }

  FutureOr<void> _onFetchDataEvent(
      FetchDataEvent event, Emitter<WeatherState> emit) async {
    emit(Loading());

    final currentWeather = await _getCurrentWeather(
        params: Coordinate(lat: event.lat, lon: event.lon));

    await currentWeather.fold(
      (failure1) async => emit(
        Error(message: failure1.runtimeType.toString()),
      ),
      (currentWeatherValue) async {
        final forcastList = await _get5days3hrsWeather(
            params: Coordinate(lat: event.lat, lon: event.lon));
        forcastList.fold(
          (failure2) => emit(
            Error(message: failure2.runtimeType.toString()),
          ),
          (forcastListValue) => emit(
            Loaded(
                currentWeather: currentWeatherValue,
                forcastList: forcastListValue),
          ),
        );
      },
    );
  }
}
