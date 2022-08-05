import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/string_time_from_epoch.dart';
import '../widgets/hourly_forcast.dart';
import '../widgets/main_section.dart';

import '../../injection_container.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/widgets.dart';

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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: _getAppBar(context),
        ),
        body: _getBody(),
      ),
    );
  }

  Widget _getAppBar(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Row(
          children: [
            const Text(
              'Locations',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.search,
              color: Colors.black,
            ),
            const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getBody() {
    return SizedBox.expand(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              return ElevatedButton(
                  onPressed: () => context.read<WeatherBloc>().add(
                        FetchDataEvent(
                          lat: 10.7546664,
                          lon: 106.4150315,
                          location: 'Ho Chi Minh City',
                        ),
                      ),
                  child: Text('send event'));
            }
            if (state is Error) {
              return Text('Error ${state.message}');
            }
            if (state is Loaded) {
              final current = state.currentWeather;
              final forcastList = state.forcastList;
              var size = MediaQuery.of(context).size;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  MainSection(current: current, location: state.location),
                  const SizedBox(height: 50),
                  HourlyForcast(forcastList: forcastList),
                  const SizedBox(height: 20),
                  DetailsSection(current: current),
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
