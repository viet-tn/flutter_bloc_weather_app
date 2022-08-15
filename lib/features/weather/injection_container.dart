import 'package:get_it/get_it.dart';

import 'data/datasources/weather_local_data_source.dart';
import 'data/datasources/weather_remote_data_source.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/usecases.dart';
import 'presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  sl.registerFactory(() => WeatherBloc(sl(), sl(), sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));
  sl.registerLazySingleton(() => Get5Days3HrsWeathers(sl()));
  sl.registerLazySingleton(() => GetCachedCurrentWeather(sl()));
  sl.registerLazySingleton(() => GetCached5Days3HrsWeathers(sl()));

  // Repositories
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImp(sharedPreferences: sl()));
}
