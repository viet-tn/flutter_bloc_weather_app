import 'package:flutter/material.dart';

import '../../../../core/presentation/helpers/text_display.dart';
import '../../domain/entities/entities.dart';
import 'widgets.dart';

class DetailsSection extends StatelessWidget {
  final Weather current;
  const DetailsSection({Key? key, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const dividerIntent = 32.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            bottom: 5,
          ),
          child: Text(
            'Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.withOpacity(.15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 25,
            ),
            child: Column(
              children: [
                DetailsTile(
                  icon: Icons.water_drop,
                  title: 'Humidity',
                  content: '${current.humidity}%',
                ),
                const DetailsDivider(
                  indent: dividerIntent,
                ),
                DetailsTile(
                  icon: Icons.cloud,
                  title: 'Clouds',
                  content: '${current.clouds} %',
                ),
                const DetailsDivider(
                  indent: dividerIntent,
                ),
                DetailsTile(
                  icon: Icons.air,
                  title: 'Wind speed',
                  content: '${current.windSpeed.toStringAsFixed(2)} m/s',
                ),
                const DetailsDivider(
                  indent: dividerIntent,
                ),
                DetailsTile(
                  icon: Icons.dark_mode,
                  title: 'Sunset',
                  content: TextDisplay.hourFromEpoch(current.sunset),
                ),
                const DetailsDivider(
                  indent: dividerIntent,
                ),
                DetailsTile(
                  icon: Icons.sunny,
                  title: 'Sunrise',
                  content: TextDisplay.hourFromEpoch(current.sunrise),
                ),
                const DetailsDivider(
                  indent: dividerIntent,
                ),
                DetailsTile(
                  icon: Icons.thermostat_auto,
                  title: 'Pressure',
                  content: '${current.pressure} hPa',
                ),
                const DetailsDivider(
                  indent: dividerIntent,
                ),
                DetailsTile(
                  icon: Icons.visibility,
                  title: 'Visibility',
                  content: TextDisplay.fromVisibility(current.visibility),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
