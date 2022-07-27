import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/geocoding_remote_data_source.dart';
import '../models/geocoding_location_model.dart';
import '../../domain/entities/geocoding_location.dart';
import '../../domain/repositories/geocoding_repository.dart';

import '../../../../core/network/network_info.dart';

class GeocodingRepositoryImpl implements GeocodingRepository {
  final GeocodingRemoteDataSource geocodingRemoteDataSource;
  final NetworkInfo networkInfo;

  GeocodingRepositoryImpl({
    required this.geocodingRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<GeocodingLocation>>> getGeocodingLocations(
      String query) async {
    if (!(await networkInfo.isConnected)) {
      return Left(NoInternetConnectionFailure());
    }
    try {
      final List<GeocodingLocationModel> locations =
          await geocodingRemoteDataSource.getGeoCodingLocations(query);
      return Right(locations);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
