import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/presentation/router/app_router.dart';
import 'features/injection_container.dart' as di;
import 'features/settings/domain/entities/settings.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializeDateFormatting('vi', null);
  // Intl.defaultLocale = 'vi';

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
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.sl<SettingsBloc>()..add(const FetchSettingEvent()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is LoadedSettingsState) {
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
          }
          return const Center(child: CircularProgressIndicator());
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
