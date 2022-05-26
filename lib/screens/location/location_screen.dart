import 'dart:async';

import 'package:catering/bloc/geolocation/geolocation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LocationScreen extends StatelessWidget {
  static const String routeName = '/location';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => LocationScreen(), settings: RouteSettings(name: routeName));
  }
  
  Completer<GoogleMapController> _controller = Completer();


  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414
  //   );

  static final Marker restMarker = Marker(
    markerId: MarkerId("Wall Street"),
    infoWindow: InfoWindow(title: "Wall Street"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(51.0889616, 71.4103024)
  );

  static final Marker restMarker1 = Marker(
    markerId: MarkerId("Wall Street"),
    infoWindow: InfoWindow(title: "Wall Street"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(51.1889616, 71.5403024)
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          BlocBuilder<GeolocationBloc, GeolocationState>(
            builder: (context, state) {
              if (state is GeolocationLoading) {
                return Center(child: CircularProgressIndicator());
              } else if ( state is GeolocationLoaded) {
                return GoogleMap(
                  myLocationButtonEnabled: true,
                  markers: {
                    restMarker,
                    restMarker1
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(state.position.latitude, state.position.longitude),
                    zoom: 5,
                  ),
                  // onMapCreated: (GoogleMapController controller) {
                  //   _controller.complete(controller);
                  // },
                );
              } else {
                return Text("Something went wrong");
              }
            },
          ),

          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: LocationSearchBox()
          )
        ],
      ),
    );
  }

  // Future<void> _goToTheWall() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition());
  // }
}


class LocationSearchBox extends StatelessWidget {
  const LocationSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Enter your location",
          suffixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.only(bottom: 5, top: 5, left: 20),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white)
          ),
        ),
      ),
    );
  }
}