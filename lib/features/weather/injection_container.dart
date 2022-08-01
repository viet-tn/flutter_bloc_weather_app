import 'package:flutter_bloc_weather_app/core/network/network_info.dart';
import 'package:flutter_bloc_weather_app/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:flutter_bloc_weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_bloc_weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_bloc_weather_app/features/weather/domain/usecases/get_5_days_3_hrs_weather.dart';
import 'package:flutter_bloc_weather_app/features/weather/domain/usecases/get_current_weather.dart';
import 'package:flutter_bloc_weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

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

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}