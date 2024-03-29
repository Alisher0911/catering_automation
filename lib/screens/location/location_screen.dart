import 'dart:async';

import 'package:catering/bloc/geolocation/geolocation_bloc.dart';
import 'package:catering/bloc/local_organization/localorganization_bloc.dart';
import 'package:catering/bloc/place/place_bloc.dart';
import 'package:catering/bloc/restaurant/restaurant_bloc.dart';
import 'package:catering/config/text_styles.dart';
import 'package:catering/models/place.dart';
import 'package:catering/models/restaurant_model.dart';
import 'package:catering/repositories/category_repository.dart';
import 'package:catering/repositories/geolocation/geolocation_repository.dart';
import 'package:catering/repositories/restaurant_repository.dart';
import 'package:catering/screens/local_organization_details/local_organization_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


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

    Marker _buildMarker(Place place) {
      return Marker(
        markerId: MarkerId("${place.localOrganization.id}"),
        infoWindow: InfoWindow(title: place.localOrganization.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        position: LatLng(place.location.latitude, place.location.longitude),
        onTap: () {
          _showOrganizationInfo(context, place);
        }
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalOrganizationBloc(restaurantRepository: context.read<RestaurantRepository>(), categoryRepository: context.read<CategoryRepository>(), geolocationRepository: context.read<GeolocationRepository>(), placeBloc: context.read<PlaceBloc>())..add(LoadLocalOrganizations())),
      ],
      child: Scaffold(
          body: Stack(
            children: [
              BlocBuilder<GeolocationBloc, GeolocationState>(
                builder: (context, state) {
                  if (state is GeolocationLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if ( state is GeolocationLoaded) {
                    return BlocBuilder<LocalOrganizationBloc, LocalOrganizationState>(
                      builder: (context, localState) {
                        if (localState is LocalOrganizationsLoaded) {
                          Set<Marker> markers = {};
                          for (Place place in localState.places) {
                            Marker marker = _buildMarker(place);
                            markers.add(marker);
                          }
                          markers.add(
                            Marker(
                              markerId: MarkerId("Current location"),
                              infoWindow: InfoWindow(title: "It's you"),
                              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                              position: LatLng(state.position.latitude, state.position.longitude),
                            )
                          );
                          return GoogleMap(
                            myLocationButtonEnabled: true,
                            markers: markers,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(state.position.latitude, state.position.longitude),
                              zoom: 18,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          );
                        } else {
                          return GoogleMap(
                            myLocationButtonEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(state.position.latitude, state.position.longitude),
                              zoom: 18,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          );
                        }
    
    
                        // Set<Marker> markers = {};
                        // if (placeState is MarkersLoaded) {
                        //   markers = placeState.mapMarkers;
                        // }
                        // return GoogleMap(
                        //   myLocationButtonEnabled: true,
                        //   markers: markers,
                        //   initialCameraPosition: CameraPosition(
                        //     target: LatLng(state.position.latitude, state.position.longitude),
                        //     zoom: 18,
                        //   ),
                        //   onMapCreated: (GoogleMapController controller) {
                        //     _controller.complete(controller);
                        //   },
                        // );
                      },
                    );
                  } else {
                    return Text("Something went wrong");
                  }
                },
              ),
      
              // Positioned(
              //   top: 40,
              //   left: 20,
              //   right: 20,
              //   child: LocationSearchBox()
              // )
            ],
          ),
        ),
    );
  }

  void _showOrganizationInfo(BuildContext context, Place place) {
    showModalBottomSheet(
          useRootNavigator: true,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          context: context,
          builder: (BuildContext bc) {
            return FractionallySizedBox(
              heightFactor: 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)
                          ),
                          image: DecorationImage(
                            image: NetworkImage(place.localOrganization.urlImage),
                            fit: BoxFit.contain
                          )
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              Navigator.of(bc).pop();
                            },
                            icon: Icon(
                              CupertinoIcons.xmark,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.localOrganization.name,
                          style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white)
                        ),
                        SizedBox(height: 5),
                        Text(
                          place.localOrganization.address,
                          style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white)
                        ),
                        SizedBox(height: 5),
                        RatingBarIndicator(
                          rating: place.localOrganization.rate,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 25,
                          itemBuilder: (context, _) => Icon(
                            Icons.star_rate_rounded,
                            color: Color(0xFF45BFE4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: KPrimaryColor,
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            )
                          ),
                          onPressed: () {
                            Navigator.of(bc).pop();
                            pushNewScreenWithRouteSettings(
                              context,
                              settings: RouteSettings(name: LocalOrganizationDetailsScreen.routeName),
                              screen: LocalOrganizationDetailsScreen(id: place.localOrganization.id),
                              withNavBar: true,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Text(
                            "Показать информацию",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
                          )
                        )
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        );
  }

  // Future<void> _goToTheWall() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition());
  // }
}


// class LocationSearchBox extends StatelessWidget {
//   const LocationSearchBox({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: BlocProvider(
//         create: (context) => RestaurantBloc(restaurantRepository: context.read<RestaurantRepository>(), placeBloc: context.read<PlaceBloc>())..add(LoadRestaurants()),
//         child: BlocBuilder<RestaurantBloc, RestaurantState>(
//               builder: (context, state) {
//                 return state is RestaurantLoaded? 
//                 Autocomplete<Restaurant>(
//                   optionsBuilder: (TextEditingValue textEditingValue) {
//                     if (textEditingValue.text == '') {
//                       return const Iterable<Restaurant>.empty();
//                     }
//                     return state.restaurants.where((Restaurant restaurant) {
//                       return restaurant.name.toLowerCase().contains(textEditingValue.text.toLowerCase());
//                     });
//                   },
//                   displayStringForOption: (Restaurant option) => option.name,
//                 )
//                 : LocationSearchTextField();
//               },
//             ),
//       ),
//     );
//   }
// }


// class LocationSearchTextField extends StatelessWidget {
//   const LocationSearchTextField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white,
//         hintText: "Enter your location",
//         suffixIcon: Icon(Icons.search),
//         contentPadding: EdgeInsets.only(bottom: 5, top: 5, left: 20),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.white)
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.white)
//         ),
//       ),
//     );
//   }
// }