import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String iconName;
  const WeatherIcon({Key? key, required this.iconName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage('https://openweathermap.org/img/wn/$iconName@2x.png'),
    );
  }
}
