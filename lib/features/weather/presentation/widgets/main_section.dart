import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/helpers/text_display.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../domain/entities/entities.dart';
import 'widgets.dart';

class MainSection extends StatelessWidget {
  final Weather current;
  final String location;
  const MainSection({Key? key, required this.current, required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          location,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          DateFormat.yMMMMEEEEd().format(DateTime.now()),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: WeatherIcon(
                iconName: current.icon,
              ),
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                if (state is LoadedSettingsState) {
                  return Text(
                    TextDisplay.temperature(
                        current.temp, state.settings.metric),
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
        const SizedBox(height: 30),
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is LoadedSettingsState) {
              return Text(
                '${TextDisplay.temperature(current.tempMax, state.settings.metric)}/${TextDisplay.temperature(current.tempMin, state.settings.metric)} Feels like ${TextDisplay.temperature(current.feelsLike, state.settings.metric)}',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        const SizedBox(height: 15),
        Text(
          TextDisplay.toTitle(current.description),
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
