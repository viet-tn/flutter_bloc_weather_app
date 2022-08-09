import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/helpers/text_display.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../domain/entities/three_hrs_weather.dart';
import 'widgets.dart';

class ForcastCard extends StatelessWidget {
  final ThreeHrsWeather forcast;
  final int minValue;
  final int maxValue;
  const ForcastCard({
    Key? key,
    required this.forcast,
    required this.minValue,
    required this.maxValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                TextDisplay.hourFromEpoch(forcast.time),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: WeatherIcon(
                  iconName: forcast.icon,
                ),
              ),
              Row(
                children: [
                  Icon(
                    forcast.precipitation <= .5
                        ? Icons.water_drop_outlined
                        : Icons.water_drop,
                    size: 12,
                  ),
                  Text(
                    '${(forcast.precipitation * 100).round()}%',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 15),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return Text(
                    TextDisplay.temperature(
                        forcast.temp, state.settings.metric),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                },
              ),
              const SizedBox(height: 2),
              Container(
                width: 5,
                // Calculate % of height depends on min and max temp
                // +0.6 to avoid in case (forcast.temp.round() - minValue) = 0 -> 60 * 0 = 0
                // +1e-10 to avoid divide by zero exception.
                height: 60 *
                    ((forcast.temp.round() - minValue) + .6) /
                    (maxValue + 1e-10 - minValue),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
