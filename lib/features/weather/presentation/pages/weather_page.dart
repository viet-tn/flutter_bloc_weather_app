// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../search/presentation/pages/location_search_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../injection_container.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/main_section.dart';
import '../widgets/widgets.dart';

class WeatherPageArguments {
  final String location;
  final double lat;
  final double lon;

  const WeatherPageArguments({
    required this.location,
    required this.lat,
    required this.lon,
  });
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  static const routeName = '/';

  final WeatherPageArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WeatherBloc>(),
      child: WeatherView(
        arguments: arguments,
      ),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final WeatherPageArguments arguments;

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
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, LocationSearchPage.routeName),
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, SettingsPage.routeName),
              icon: const Icon(
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
              context.read<WeatherBloc>().add(
                    FetchDataEvent(
                      lat: arguments.lat,
                      lon: arguments.lon,
                      location: arguments.location,
                    ),
                  );
            }
            if (state is ErrorWeather) {
              return Text('Error ${state.message}');
            }
            if (state is LoadedWeather) {
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
