import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injection_container.dart';
import '../../../search/presentation/pages/location_search_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/main_section.dart';
import '../widgets/widgets.dart';
import 'weather_page_arguments.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final jsonString =
      sl<SharedPreferences>().getString(WeatherPageArguments.key);
  WeatherPageArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _getAppBar(),
        ),
        body: _getBody(),
      ),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Row(
          children: [
            const Text(
              'Locations',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () async {
                final args = await Navigator.pushNamed(
                    context, LocationSearchPage.routeName);
                arguments = args as WeatherPageArguments;
                if (!mounted) return;
                context.read<WeatherBloc>().add(
                      FetchDataEvent(
                        lat: arguments!.lat,
                        lon: arguments!.lon,
                        location: arguments!.location,
                      ),
                    );
                sl<SharedPreferences>()
                    .setString(WeatherPageArguments.key, arguments!.toJson());
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, SettingsPage.routeName),
              icon: const Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getBody() {
    var size = MediaQuery.of(context).size;
    return SizedBox.expand(
      child: RefreshIndicator(
        onRefresh: () async {
          final jsonString =
              sl<SharedPreferences>().getString(WeatherPageArguments.key);
          if (jsonString == null) return;
          arguments ??= WeatherPageArguments.fromJson(jsonString);
          Future.delayed(
            Duration.zero,
            () => context.read<WeatherBloc>().add(
                  FetchDataEvent(
                    lat: arguments!.lat,
                    lon: arguments!.lon,
                    location: arguments!.location,
                  ),
                ),
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(5),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return SizedBox(
                  height: size.height / 2,
                  width: size.width,
                  child: const Center(
                    child: Text('Please search for weather!'),
                  ),
                );
              }
              if (state is ErrorWeather) {
                return Text('Error ${state.message}');
              }
              if (state is LoadedWeather) {
                final current = state.currentWeather;
                final forcastList = state.forcastList;
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

              return SizedBox(
                height: size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
