import 'package:get_it/get_it.dart';
import 'data/datasources/weather_remote_data_source.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/get_5_days_3_hrs_weather.dart';
import 'domain/usecases/get_current_weather.dart';
import 'presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  sl.registerFactory(() => WeatherBloc(sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));
  sl.registerLazySingleton(() => Get5Days3HrsWeather(sl()));

  // Repositories
  sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: sl()));
}
