import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/usecases.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/params.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather _getCurrentWeather;
  final Get5Days3HrsWeathers _get5days3hrsWeathers;
  final GetCachedCurrentWeather _getCachedCurrentWeather;
  final GetCached5Days3HrsWeathers _getCached5Days3HrsWeathers;

  WeatherBloc(
    GetCurrentWeather getCurrentWeather,
    Get5Days3HrsWeathers get5days3hrsWeathers,
    GetCachedCurrentWeather getCachedCurrentWeather,
    GetCached5Days3HrsWeathers getCached5Days3HrsWeathers,
  )   : _getCurrentWeather = getCurrentWeather,
        _get5days3hrsWeathers = get5days3hrsWeathers,
        _getCachedCurrentWeather = getCachedCurrentWeather,
        _getCached5Days3HrsWeathers = getCached5Days3HrsWeathers,
        super(WeatherInitial()) {
    on<FetchDataEvent>(_onFetchDataEvent);
    on<FetchDataFromCacheEvent>(_onFetchDataOnCacheEvent);
  }

  FutureOr<void> _onFetchDataEvent(
      FetchDataEvent event, Emitter<WeatherState> emit) async {
    emit(LoadingWeather());

    final currentWeather = await _getCurrentWeather(
        params: Coordinate(lat: event.lat, lon: event.lon));

    await currentWeather.fold(
      (failure1) async => emit(
        ErrorWeather(message: failure1.runtimeType.toString()),
      ),
      (currentWeatherValue) async {
        final forcastList = await _get5days3hrsWeathers(
            params: Coordinate(lat: event.lat, lon: event.lon));
        forcastList.fold(
          (failure2) => emit(
            ErrorWeather(message: failure2.runtimeType.toString()),
          ),
          (forcastListValue) => emit(
            LoadedWeather(
                location: event.location,
                currentWeather: currentWeatherValue,
                forcastList: forcastListValue),
          ),
        );
      },
    );
  }

  FutureOr<void> _onFetchDataOnCacheEvent(
      FetchDataFromCacheEvent event, Emitter<WeatherState> emit) async {
    emit(LoadingWeather());
    log('_onFetchDataOnCacheEvent called');

    final currentWeather = await _getCachedCurrentWeather(params: none());

    await currentWeather.fold(
      (failure1) async {
        log('failure1');
        emit(
          WeatherInitial(),
        );
      },
      (currentWeatherValue) async {
        final forcastList = await _getCached5Days3HrsWeathers(params: none());
        forcastList.fold(
          (failure2) {
            log('failure2');
            emit(WeatherInitial());
          },
          (forcastListValue) {
            log('success load cache');
            emit(
              LoadedWeather(
                  location: event.location,
                  currentWeather: currentWeatherValue,
                  forcastList: forcastListValue),
            );
          },
        );
      },
    );
  }
}
