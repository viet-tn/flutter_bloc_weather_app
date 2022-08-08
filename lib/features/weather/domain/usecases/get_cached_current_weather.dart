import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/entities.dart';
import '../repositories/weather_repository.dart';

class GetCachedCurrentWeather implements UseCase<Weather, void> {
  final WeatherRepository _repository;

  GetCachedCurrentWeather(WeatherRepository repository)
      : _repository = repository;

  @override
  Future<Either<Failure, Weather>> call({required void params}) {
    return _repository.getCachedCurrentWeather();
  }
}
