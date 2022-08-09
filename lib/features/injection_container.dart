import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/network_info.dart';
import 'search/injection_container.dart' as search_di;
import 'settings/injection_container.dart' as settings_di;
import 'weather/injection_container.dart' as weather_di;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Settings
  settings_di.init();

  // Search
  search_di.init();

  // Weather
  weather_di.init();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      internetConnectionChecker: sl(),
    ),
  );

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
