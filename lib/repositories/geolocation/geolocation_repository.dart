import 'package:catering/models/place.dart';
import 'package:catering/models/restaurant_model.dart';
import 'package:catering/repositories/geolocation/base_geolocation_repository.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert' as convert;

class GeolocationRepository extends BaseGeolocationRepository {
  GeolocationRepository();

  @override
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } 

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }


  @override
  Future<Location> getLocationByAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    return locations.first;
  }

  @override
  Future<Set<Marker>> getMarkersOfRestaurants(List<Restaurant> restaurants) async {
    Set<Marker> markers = {};
    Position position = await getCurrentLocation();
    markers.add(
      Marker(
        markerId: MarkerId("Current location"),
        infoWindow: InfoWindow(title: "It's you"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(position.latitude, position.longitude),
      )
    );
    for (Restaurant restaurant in restaurants) {
      Location location = await getLocationByAddress(restaurant.address);
      markers.add(
        Marker(
          markerId: MarkerId("${restaurant.id}"),
          infoWindow: InfoWindow(title: restaurant.name),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          position: LatLng(location.latitude, location.longitude),
          onTap: () {
          }
        )
      );
    }
    return markers;
  }
}