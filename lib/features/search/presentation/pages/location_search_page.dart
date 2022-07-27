import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_bloc.dart';

import '../../injection_container.dart';
import '../widgets/widgets.dart';

class LocationSearchPage extends StatelessWidget {
  const LocationSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchBloc>(),
      child: const LocationSearchView(),
    );
  }
}

class LocationSearchView extends StatelessWidget {
  const LocationSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Search'),
        // ),
        body: _getBody(context),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: const [
          SearchControls(),
          Expanded(
            child: LocationList(),
          ),
        ],
      ),
    );
  }
}
