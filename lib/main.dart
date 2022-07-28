import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weather_app/features/settings/domain/entities/settings.dart';
import 'package:flutter_bloc_weather_app/features/settings/presentation/pages/settings_page.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

import 'features/search/injection_container.dart' as search_di;
import 'features/settings/injection_container.dart' as settings_di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CountryCodes.init();
  await search_di.init();
  await settings_di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var abc = settings_di.sl<SettingsBloc>().add(const LoadSettingEvent());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => settings_di.sl<SettingsBloc>(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Location',
            theme: ThemeData(
              brightness: state.settings.theme == WeatherAppTheme.dark
                  ? Brightness.dark
                  : Brightness.light,
            ),
            home: const SettingsPage(),
          );
        },
      ),
    );
  }
}
