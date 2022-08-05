import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/presentation/router/app_router.dart';
import 'features/injection_container.dart' as di;
import 'features/settings/domain/entities/settings.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CountryCodes.init();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _ = di.sl<SettingsBloc>().add(const LoadSettingEvent());
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<SettingsBloc>(),
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
