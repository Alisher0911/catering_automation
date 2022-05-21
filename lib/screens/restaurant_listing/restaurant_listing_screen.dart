import 'package:flutter/material.dart';

import 'package:catering/models/restaurant_model.dart';
import 'package:catering/widgets/restaurant_card.dart';

class RestaurantListingScreen extends StatelessWidget {
  static const String routeName = '/restaurant-listing';

  final List<Restaurant> restaurants;

  const RestaurantListingScreen({
    required this.restaurants,
  });

  static Route route({required List<Restaurant> restaurants}) {
    return MaterialPageRoute(
      builder: (_) => RestaurantListingScreen(restaurants: restaurants),
      settings: RouteSettings(name: routeName),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurants')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return RestaurantCard(restaurant: restaurants[index]);
          }
        ),
      )
    );
  }
}
