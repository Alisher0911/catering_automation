import 'package:catering/bloc/restaurant/restaurant_bloc.dart';
import 'package:catering/models/category_model.dart';
import 'package:catering/models/restaurant_model.dart';
import 'package:catering/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CategoryBox extends StatelessWidget {
  final Category category;

  const CategoryBox({ Key? key, required this.category }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    // final restaurants = Restaurant.restaurants.where((restaurant) => restaurant.tags.contains(category.name));

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        //Navigator.pushNamed(context, '/restaurant-listing', arguments: restaurants);
        pushNewScreenWithRouteSettings(
          context,
          settings: RouteSettings(name: RestaurantListingScreen.routeName),
          screen: BlocBuilder<RestaurantBloc, RestaurantState>(
            builder: (context, state) {
              if (state is RestaurantLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if (state is RestaurantLoaded) {
                return RestaurantListingScreen(restaurants: state.restaurants.where((restaurant) => restaurant.tags.contains(category.name)).toList());
              } else {
                return Container();
              }
            },
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Container(
        width: 65,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100)
        ),
        child: Stack(children: [
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              height: 55,
              width: 55,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 2,
                    blurStyle: BlurStyle.inner
                  ),
                ]
              ),
              child: Image.network(
                category.urlImage
              ),
            ),
          ),
    
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                category.name,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black)
              ),
            ),
          ),
        ]),
      ),
    );
  }
}