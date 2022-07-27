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
