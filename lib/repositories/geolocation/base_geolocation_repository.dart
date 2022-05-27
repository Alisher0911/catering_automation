import 'package:catering/models/restaurant_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class BaseGeolocationRepository {
  Future<Position?> getCurrentLocation() async {}
  Future<void> getLocationByAddress(String address) async {}
  Future<Set<Marker>?> getMarkersOfRestaurants(List<Restaurant> restaurants) async {}
}