import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/weather/presentation/bloc/weather_bloc.dart';
import '../../../features/injection_container.dart';
import '../../../features/search/presentation/pages/location_search_page.dart';
import '../../../features/settings/presentation/pages/settings_page.dart';
import '../../../features/weather/presentation/pages/weather_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case WeatherPage.routeName:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => sl<WeatherBloc>(),
              child: const WeatherPage(),
            );
          },
          settings: routeSettings,
        );
      case LocationSearchPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const LocationSearchPage(),
          settings: routeSettings,
        );
      case SettingsPage.routeName:
        return MaterialPageRoute(
            builder: (_) => const SettingsPage(), settings: routeSettings);
      default:
        return null;
    }
  }

  void dispose() {}
}
