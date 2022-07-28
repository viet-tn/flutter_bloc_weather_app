import 'package:flutter_bloc_weather_app/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:flutter_bloc_weather_app/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:flutter_bloc_weather_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter_bloc_weather_app/features/settings/domain/usecases/get_settings.dart';
import 'package:flutter_bloc_weather_app/features/settings/domain/usecases/save_settings.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/bloc/settings_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerLazySingleton(() => SettingsBloc(sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => GetSettings(sl()));
  sl.registerLazySingleton(() => SaveSettings(sl()));

  // Repositories
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImp(sharedPreferences: sl()),
  );

  //! Core

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
