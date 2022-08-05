import 'package:get_it/get_it.dart';

import 'data/datasources/geocoding_remote_data_source.dart';
import 'data/repositories/geocoding_repository_impl.dart';
import 'domain/repositories/geocoding_repository.dart';
import 'domain/usecases/get_geocoding_location.dart';
import 'presentation/bloc/search_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  sl.registerFactory(() => SearchBloc(geocodingLocaion: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetGeocodingLocaion(sl()));

  // Repositories
  sl.registerLazySingleton<GeocodingRepository>(
    () => GeocodingRepositoryImpl(
      geocodingRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<GeocodingRemoteDataSource>(
    () => GeocodingRemoteDataSourceImpl(
      client: sl(),
    ),
  );
}
