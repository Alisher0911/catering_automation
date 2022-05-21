import 'package:catering/models/restaurant_model.dart';
import 'package:catering/screens/screens.dart';
import 'package:catering/widgets/restaurant_tags.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({ Key? key, required this.restaurant }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        //Navigator.pushNamed(context, '/restaurant-details', arguments: restaurant);
        pushNewScreenWithRouteSettings(
          context,
          settings: RouteSettings(name: RestaurantDetailsScreen.routeName),
          screen: RestaurantDetailsScreen(restaurant: restaurant),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //width: 270,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                      ),
                      image: DecorationImage(
                        image: NetworkImage(restaurant.imageUrl),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
    
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${restaurant.deliveryTime} min",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
    
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurant.name, style: Theme.of(context).textTheme.headline5),
    
                    SizedBox(height: 5),
    
                    Text("${restaurant.distance}km - \$${restaurant.deliveryFee} delivery fee", style: Theme.of(context).textTheme.bodyText1),
    
                    SizedBox(height: 5),
    
                    RestaurantTags(restaurant: restaurant),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
 
  }
}