import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/settings/domain/entities/settings.dart';
import 'features/settings/injection_container.dart' as settings_di;
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/weather/injection_container.dart' as weather_di;
import 'features/weather/presentation/pages/weather_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CountryCodes.init();
  // await search_di.init();
  await settings_di.init();
  await weather_di.init();

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
            debugShowCheckedModeBanner: false,
            title: 'Location',
            theme: ThemeData(
              brightness: state.settings.theme == WeatherAppTheme.dark
                  ? Brightness.dark
                  : Brightness.light,
            ),
            home: const WeatherPage(),
          );
        },
      ),
    );
  }
}
