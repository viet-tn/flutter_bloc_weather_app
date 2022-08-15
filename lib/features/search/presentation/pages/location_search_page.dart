import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class LocationSearchPage extends StatelessWidget {
  const LocationSearchPage({Key? key}) : super(key: key);

  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return const LocationSearchView();
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
