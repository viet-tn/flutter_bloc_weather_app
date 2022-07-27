import '../../domain/entities/geocoding_location.dart';

class GeocodingLocationModel extends GeocodingLocation {
  const GeocodingLocationModel({
    required super.lat,
    required super.lon,
    required super.name,
    required super.country,
    super.state,
  });

  factory GeocodingLocationModel.fromJson(Map<String, dynamic> json) {
    return GeocodingLocationModel(
      lat: json['lat'] as double,
      lon: json['lon'] as double,
      name: json['name'] as String,
      country: json['country'] as String,
      state: json['state'] != null ? json['state'] as String : null,
    );
  }
}
