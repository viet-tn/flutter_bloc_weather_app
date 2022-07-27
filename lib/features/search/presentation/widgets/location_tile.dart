import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/geocoding_location.dart';

class LocationTile extends StatelessWidget {
  final GeocodingLocation location;
  final void Function() onTap;

  const LocationTile({
    Key? key,
    required this.location,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              location.state == null
                  ? '${CountryCodes.name(locale: Locale('en', location.country))}'
                  : '${location.state}, ${CountryCodes.name(locale: Locale('en', location.country))}',
              style: const TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
