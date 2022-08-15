import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/search/presentation/bloc/search_bloc.dart';
import '../../../features/weather/presentation/bloc/weather_bloc.dart';
import '../../../features/injection_container.dart';
import '../../../features/search/presentation/pages/location_search_page.dart';
import '../../../features/settings/presentation/pages/settings_page.dart';
import '../../../features/weather/presentation/pages/weather_page.dart';
import '../../../features/weather/presentation/pages/weather_page_arguments.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case WeatherPage.routeName:
        return MaterialPageRoute(
          builder: (_) {
            // For load cached weather beffore build method called
            late WeatherPageArguments? args;
            final jsonString =
                sl<SharedPreferences>().getString(WeatherPageArguments.key);

            if (jsonString != null) {
              args = WeatherPageArguments.fromJson(jsonString);
            } else {
              args = null;
            }
            return BlocProvider(
              create: (context) {
                if (args != null) {
                  return sl<WeatherBloc>()
                    ..add(FetchDataFromCacheEvent(args.location));
                }
                return sl<WeatherBloc>()..add(SetInitialWeatherEvent());
              },
              child: const WeatherPage(),
            );
          },
          settings: routeSettings,
        );

      case LocationSearchPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SearchBloc>(),
            child: const LocationSearchPage(),
          ),
          settings: routeSettings,
        );

      case SettingsPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
          settings: routeSettings,
        );

      default:
        return null;
    }
  }

  void dispose() {}
}
