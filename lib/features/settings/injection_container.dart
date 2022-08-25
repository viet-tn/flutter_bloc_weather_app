import 'package:get_it/get_it.dart';

import 'data/datasources/settings_local_data_source.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'domain/repositories/settings_repository.dart';
import 'domain/usecases/get_settings.dart';
import 'domain/usecases/save_settings.dart';
import 'presentation/bloc/settings_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  sl.registerFactory(() => SettingsBloc(sl(), sl()));

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
}
