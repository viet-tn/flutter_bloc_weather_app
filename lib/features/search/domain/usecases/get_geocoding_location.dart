import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/geocoding_location.dart';
import '../repositories/geocoding_repository.dart';

class GetGeocodingLocaion extends UseCase<List<GeocodingLocation>, String> {
  final GeocodingRepository _repository;

  GetGeocodingLocaion(GeocodingRepository repository)
      : _repository = repository;

  @override
  Future<Either<Failure, List<GeocodingLocation>>> call(
      {required String params}) async {
    return await _repository.getGeocodingLocations(params);
  }
}
