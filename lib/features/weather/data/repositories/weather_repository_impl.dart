import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/three_hrs_weather.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';

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
