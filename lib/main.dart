import 'dart:developer';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/weather/presentation/pages/weather_page_arguments.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/presentation/router/app_router.dart';
import 'features/injection_container.dart' as di;
import 'features/settings/domain/entities/settings.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CountryCodes.init();
  await di.init();
  final jsonString =
      di.sl<SharedPreferences>().getString(WeatherPageArguments.key);
  // For load saved settings and cached weather beffore build method called

  di.sl<SettingsBloc>().add(const LoadSettingEvent());
  if (jsonString != null) {
    final args = WeatherPageArguments.fromJson(jsonString);
    di.sl<WeatherBloc>().add(FetchDataFromCacheEvent(args.location));
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<SettingsBloc>(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          log(state.settings.theme.name);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Location',
            theme: ThemeData(
              brightness: state.settings.theme == WeatherAppTheme.dark
                  ? Brightness.dark
                  : Brightness.light,
              fontFamily: 'Montserrat',
              useMaterial3: true,
            ),
            onGenerateRoute: _appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }
}
