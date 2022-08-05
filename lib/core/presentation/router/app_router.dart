import 'package:flutter/material.dart';
import '../../../features/search/presentation/pages/location_search_page.dart';
import '../../../features/settings/presentation/pages/settings_page.dart';
import '../../../features/weather/presentation/pages/weather_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case WeatherPage.routeName:
        return MaterialPageRoute(
          builder: (_) {
            final args = routeSettings.arguments as WeatherPageArguments?;
            return args == null
                ? const WeatherPage(
                    arguments: WeatherPageArguments(
                      lat: 10.7546664,
                      lon: 106.4150315,
                      location: 'Ho Chi Minh City',
                    ),
                  )
                : WeatherPage(
                    arguments: args,
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
