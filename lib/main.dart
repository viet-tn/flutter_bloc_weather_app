import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';

import 'features/search/injection_container.dart' as search_di;
import 'features/search/presentation/pages/location_search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CountryCodes.init();
  await search_di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Location',
      home: LocationSearchPage(),
    );
  }
}
