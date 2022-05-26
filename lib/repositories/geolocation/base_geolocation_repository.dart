import 'package:geolocator/geolocator.dart';

abstract class BaseGeolocationRepository {
  Future<Position?> getCurrentLocation() async {}
  Future<void> getLocationByAddress(String address) async {}
}