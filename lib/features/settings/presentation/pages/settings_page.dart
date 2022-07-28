import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/settings.dart';
import '../bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Theme'),
                  BlocBuilder<SettingsBloc, SettingsState>(
                    builder: (context, state) {
                      return Switch(
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
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
