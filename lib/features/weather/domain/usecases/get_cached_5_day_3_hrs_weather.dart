import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/entities.dart';
import '../repositories/weather_repository.dart';

class GetCached5Days3HrsWeathers
    implements UseCase<List<ThreeHrsWeather>, void> {
  final WeatherRepository _repository;

  GetCached5Days3HrsWeathers(WeatherRepository repository)
      : _repository = repository;

  @override
  Future<Either<Failure, List<ThreeHrsWeather>>> call({required void params}) {
    return _repository.getCached5Days3HrsWeathers();
  }
}
