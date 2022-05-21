import 'package:catering/models/restaurant_model.dart';
import 'package:catering/widgets/restaurant_tags.dart';
import 'package:flutter/material.dart';

class RestaurantInformation extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantInformation({ Key? key, required this.restaurant }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: Theme.of(context).textTheme.headline3!
                .copyWith(color: Theme.of(context).colorScheme.secondary)
          ),

          SizedBox(height: 10),

          RestaurantTags(restaurant: restaurant),

          SizedBox(height: 5),

          Text(
            "${restaurant.distance}km away - \$${restaurant.deliveryFee} delivery fee",
            style: Theme.of(context).textTheme.bodyText1
          ),

          SizedBox(height: 10),

          Text(
            "Restaurant Information",
            style: Theme.of(context).textTheme.headline5
          ),

          SizedBox(height: 5),

          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            style: Theme.of(context).textTheme.bodyText1
          ),
        ],
      ),
    );
  }
}