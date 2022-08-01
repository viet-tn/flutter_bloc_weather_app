import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';
import '../bloc/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WeatherBloc>(),
      child: WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              return ElevatedButton(
                  onPressed: () => context
                      .read<WeatherBloc>()
                      .add(FetchDataEvent(lat: 10.7546664, lon: 106.4150315)),
                  child: Text('send event'));
            } else if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is Error) {
              return Text('Error ${state.message}');
            } else if (state is Loaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Current: ${state.currentWeather.toString()}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'ForcastList : ${state.forcastList.toString()}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              );
            } else {
              return Text('Something wrong');
            }
          },
        ),
      ),
    );
  }
}
