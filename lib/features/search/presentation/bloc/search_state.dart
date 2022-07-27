part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class Initial extends SearchState {}

class Empty extends SearchState {}

class Loading extends SearchState {}

class Loaded extends SearchState {
  final List<GeocodingLocation> locations;

  const Loaded({required this.locations});

  @override
  List<Object> get props => [locations];
}

class Error extends SearchState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
