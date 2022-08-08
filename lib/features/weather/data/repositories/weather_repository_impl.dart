import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/three_hrs_weather.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_data_source.dart';
import '../datasources/weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final NetworkInfo _networkInfo;
  final WeatherRemoteDataSource _remoteDataSource;
  final WeatherLocalDataSource _localDataSource;
  const WeatherRepositoryImpl({
    required NetworkInfo networkInfo,
    required WeatherRemoteDataSource remoteDataSource,
    required WeatherLocalDataSource localDataSource,
  })  : _networkInfo = networkInfo,
        _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, List<ThreeHrsWeather>>> get5Days3HrsWeathers(
      {required double lat, required double lon}) async {
    if (!(await _networkInfo.isConnected)) {
      return Left(NoInternetConnectionFailure());
    }
    try {
      final forcastList =
          await _remoteDataSource.get5Days3HrsWeathers(lat, lon);
      await _localDataSource.cacheForcastList(forcastList);
      log('forcast list cached');
      return Right(forcastList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(
      {required double lat, required double lon}) async {
    if (!(await _networkInfo.isConnected)) {
      return Left(NoInternetConnectionFailure());
    }
    try {
      final currentWeather =
          await _remoteDataSource.getCurrentWeather(lat, lon);
      await _localDataSource.cacheWeather(currentWeather);
      log('current weather cached');
      return Right(currentWeather);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ThreeHrsWeather>>>
      getCached5Days3HrsWeathers() async {
    try {
      final forcastList = await _localDataSource.getLastForcastList();
      return Right(forcastList);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Weather>> getCachedCurrentWeather() async {
    try {
      final weather = await _localDataSource.getLastWeather();
      return Right(weather);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
