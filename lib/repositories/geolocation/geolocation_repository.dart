import 'package:catering/repositories/geolocation/base_geolocation_repository.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationRepository extends BaseGeolocationRepository {
  GeolocationRepository();

  @override
  Future<Position> getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Future<void> getLocationByAddress(String address) async {
  }
    
}