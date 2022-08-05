// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetLocationsEvent extends SearchEvent {
  final String query;

  const GetLocationsEvent(this.query);

  @override
  List<Object> get props => [query];
}

// class SendDataToWeatherPageEvent extends SearchEvent {
//   final String location;
//   final double lat;
//   final double lon;

//   const SendDataToWeatherPageEvent({
//     required this.location,
//     required this.lat,
//     required this.lon,
//   });
// }
