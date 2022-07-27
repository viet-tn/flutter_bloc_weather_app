import 'package:equatable/equatable.dart';

class GeocodingLocation extends Equatable {
  final double lat;
  final double lon;
  final String name;
  final String country;
  final String? state;

  const GeocodingLocation({
    required this.lat,
    required this.lon,
    required this.name,
    required this.country,
    this.state,
  });

  @override
  List<Object?> get props => [lat, lon, name, country, state];
}
