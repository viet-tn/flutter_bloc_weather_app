import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/geocoding_location.dart';
import '../../domain/usecases/get_geocoding_location.dart';

part 'search_event.dart';
part 'search_state.dart';

const String serverFailureMessage = 'Server Failure';
const String noInternetConnectionFailureMessage = 'No Internet Connection';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetGeocodingLocaion geocodingLocaion;
  SearchBloc({
    required this.geocodingLocaion,
  }) : super(Initial()) {
    on<GetLocationsEvent>(_onGetLocationsEvent);
  }

  FutureOr<void> _onGetLocationsEvent(
      GetLocationsEvent event, Emitter<SearchState> emit) async {
    emit(Loading());
    final locations = await geocodingLocaion(params: event.query);
    await locations.fold(
      (failure) async => emit(Error(message: _mapFailureToMessage(failure))),
      (locations) async {
        if (locations.isEmpty) return emit(Empty());
        return emit(Loaded(locations: locations));
      },
    );
  }
}

String _mapFailureToMessage(Failure failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    case NoInternetConnectionFailure:
      return noInternetConnectionFailureMessage;
    default:
      return 'Unexpected Error';
  }
}
