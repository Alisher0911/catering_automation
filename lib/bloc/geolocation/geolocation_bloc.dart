import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catering/repositories/geolocation/geolocation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepository _geolocationRepository;
  StreamSubscription? _geolocationSubscription;

  GeolocationBloc({required GeolocationRepository geolocationRepository}) 
    : _geolocationRepository = geolocationRepository,
    super(GeolocationLoading()) {
      on<LoadGeolocation>(_onLoadGeolocation);
      on<UpdateGeolocation>(_onUpdateGeolocation);
  }

  void _onLoadGeolocation(LoadGeolocation event, Emitter<GeolocationState> emit) async {
    _geolocationSubscription?.cancel();
    final Position position = await _geolocationRepository.getCurrentLocation();
    print("${position.latitude} + " " + ${position.longitude}");
    add(UpdateGeolocation(position: position));
  }

  void _onUpdateGeolocation(UpdateGeolocation event, Emitter<GeolocationState> emit) async {
    emit(GeolocationLoaded(position: event.position));
  }

  @override
  Future<void> close() {
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
