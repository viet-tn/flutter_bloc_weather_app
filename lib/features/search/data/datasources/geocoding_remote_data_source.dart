import 'dart:convert';
import 'dart:developer';

import '../../../../core/error/exceptions.dart';
import '../models/geocoding_location_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/secrets/secret.dart';

const baseUrl = 'api.openweathermap.org';

abstract class GeocodingRemoteDataSource {
  Future<List<GeocodingLocationModel>> getGeoCodingLocations(String query);
}

class GeocodingRemoteDataSourceImpl implements GeocodingRemoteDataSource {
  final http.Client client;

  GeocodingRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<GeocodingLocationModel>> getGeoCodingLocations(
      String query) async {
    final Uri uri = Uri.http(
      baseUrl,
      '/geo/1.0/direct',
      <String, String>{
        'q': query,
        'limit': '5',
        'appid': apiKey,
      },
    );
    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    log(response.body);

    if (response.statusCode != 200) throw ServerException();
    return <GeocodingLocationModel>[
      for (var location in (json.decode(response.body)))
        GeocodingLocationModel.fromJson(location)
    ];
  }
}
