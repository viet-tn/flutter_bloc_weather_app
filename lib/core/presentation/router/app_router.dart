import 'package:flutter/material.dart';
import '../constants.dart';
import '../../../features/weather/presentation/pages/weather_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const WeatherPage());
      default:
        return null;
    }
  }

  void dispose() {}
}
