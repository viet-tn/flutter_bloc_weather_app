// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_weather_app/core/error/failures.dart';
import 'package:flutter_bloc_weather_app/core/network/network_info.dart';
import 'package:flutter_bloc_weather_app/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:flutter_bloc_weather_app/features/weather/domain/entities/three_hrs_weather.dart';
import 'package:flutter_bloc_weather_app/features/weather/domain/entities/weather.dart';
import 'package:flutter_bloc_weather_app/features/weather/domain/repositories/weather_repository.dart';

import '../../../../core/error/exceptions.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final NetworkInfo _networkInfo;
  final WeatherRemoteDataSource _remoteDataSource;
  const WeatherRepositoryImpl({
    required NetworkInfo networkInfo,
    required WeatherRemoteDataSource remoteDataSource,
  })  : _networkInfo = networkInfo,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<ThreeHrsWeather>>> get5Days3HrsWeathers(
      {required double lat, required double lon}) async {
    if (!(await _networkInfo.isConnected)) {
      return Left(NoInternetConnectionFailure());
    }
    try {
      final forcastList =
          await _remoteDataSource.get5Days3HrsWeathers(lat, lon);
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
      return Right(currentWeather);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
