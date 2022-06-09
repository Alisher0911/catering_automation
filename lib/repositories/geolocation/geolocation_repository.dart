import 'package:catering/models/local_organization.dart';
import 'package:catering/models/place.dart';
import 'package:catering/repositories/geolocation/base_geolocation_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  Future<Set<Marker>> getMarkersOfOrganizations(List<LocalOrganization> localOrganizations) async {
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
    for (LocalOrganization localOrganization in localOrganizations) {
      try {
        Location location = await getLocationByAddress(localOrganization.address);
        markers.add(
          Marker(
            markerId: MarkerId("${localOrganization.id}"),
            infoWindow: InfoWindow(title: localOrganization.name),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
            position: LatLng(location.latitude, location.longitude),
            onTap: () {
            }
          )
        );
      } catch (_) {}
    }
    return markers;
  }


  Future<List<Place>> getLocationsOfOrganizations(List<LocalOrganization> localOrganizations) async {
    List<Place> places = [];
    for (LocalOrganization localOrganization in localOrganizations) {
      try {
        Location location = await getLocationByAddress(localOrganization.address);
        Place place = Place(localOrganization: localOrganization, location: location);
        print("${place.localOrganization} ${place.location}");
        places.add(place);
      } catch (_) {}
    }
    return places;
  }
}