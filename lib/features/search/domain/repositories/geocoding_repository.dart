import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/geocoding_location.dart';

abstract class GeocodingRepository {
  Future<Either<Failure, List<GeocodingLocation>>> getGeocodingLocations(
      String query);
}
