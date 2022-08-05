import 'package:flutter/material.dart';
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
        // TODO: Format datetime
        Text(
          '${DateTime.now()}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(.5),
          ),
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
            Text(
              '${current.temp.round()}°',
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        const SizedBox(height: 30),
        Text(
          '${current.tempMax.round()}°/${current.tempMin.round()} Feels like ${current.feelsLike.round()}°',
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          toTitle(current.description),
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

String toTitle(String string) {
  final words = string.split(' ');
  final uppercase = words.map((e) {
    if (e.trim().isEmpty) return '';
    return e[0].toUpperCase() + e.substring(1);
  });
  return uppercase.join(' ');
}
