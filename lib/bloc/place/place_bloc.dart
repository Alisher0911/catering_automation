import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  PlaceBloc() : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  
}
