import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/three_hrs_weather.dart';
import '../repositories/weather_repository.dart';
import 'params.dart';

class Get5Days3HrsWeathers
    implements UseCase<List<ThreeHrsWeather>, Coordinate> {
  final WeatherRepository _repository;

  Get5Days3HrsWeathers(WeatherRepository repository) : _repository = repository;

  @override
  Future<Either<Failure, List<ThreeHrsWeather>>> call(
      {required Coordinate params}) {
    return _repository.get5Days3HrsWeathers(
      lat: params.lat,
      lon: params.lon,
    );
  }
}
