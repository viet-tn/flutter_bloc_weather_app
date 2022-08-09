import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/settings.dart';
import '../bloc/settings_bloc.dart';
import '../widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Theme'),
                      Switch(
                        value: state.settings.theme == WeatherAppTheme.dark,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                ChangeWeatherAppThemeEvent(
                                  theme: value
                                      ? WeatherAppTheme.dark
                                      : WeatherAppTheme.light,
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Temperature Unit'),
                      TemperatureUnitToggler(
                        index:
                            WeatherMetric.values.indexOf(state.settings.metric),
                        onTap: (int index) {
                          context.read<SettingsBloc>().add(
                                ChangeWeatherMetricEvent(
                                  metric: WeatherMetric.values[index],
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
