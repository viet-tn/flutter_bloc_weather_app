import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/entities.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather({
    required double lat,
    required double lon,
  });
  Future<Either<Failure, List<ThreeHrsWeather>>> get5Days3HrsWeathers({
    required double lat,
    required double lon,
  });
}
