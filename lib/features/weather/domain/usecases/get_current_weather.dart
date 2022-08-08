import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/entities.dart';
import '../repositories/weather_repository.dart';
import 'params.dart';

class GetCurrentWeather implements UseCase<Weather, Coordinate> {
  final WeatherRepository _repository;

  GetCurrentWeather(WeatherRepository repository) : _repository = repository;

  @override
  Future<Either<Failure, Weather>> call({required Coordinate params}) {
    return _repository.getCurrentWeather(
      lat: params.lat,
      lon: params.lon,
    );
  }
}
