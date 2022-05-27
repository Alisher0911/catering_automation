import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catering/bloc/restaurant/restaurant_bloc.dart';
import 'package:catering/models/place.dart';
import 'package:catering/models/restaurant_model.dart';
import 'package:catering/repositories/geolocation/geolocation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final GeolocationRepository geolocationRepository;
  StreamSubscription? otherBlocSubscription;

  PlaceBloc({
    required this.geolocationRepository,
  }) : super(PlaceByAddressLoading()) {
    on<LoadPlaceByAddress>(_onLoadLocationByAddress);
    on<LoadMarkers>(_onLoadMarkers);
  }

  void _onLoadLocationByAddress(LoadPlaceByAddress event, Emitter<PlaceState> emit) async {
    final Location location = await geolocationRepository.getLocationByAddress(event.address);
    emit(PlaceByAddressLoaded(location: location));
  }

  void _onLoadMarkers(LoadMarkers event, Emitter<PlaceState> emit) async {
    try {
      final Set<Marker> markers = await geolocationRepository.getMarkersOfRestaurants(event.restaurants);
      emit(MarkersLoaded(mapMarkers: markers));
    } catch(_) {
      emit(PlaceError());
    }
  }
}
