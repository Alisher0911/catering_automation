import 'package:catering/models/restaurant_model.dart';
import 'package:catering/screens/restaurant_details/widgets/menu_item_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'widgets/glassmorphism.dart';
import 'package:flutter/material.dart';

import 'widgets/restaurant_information.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  static const String routeName = '/restaurant-details';

  final Restaurant restaurant;

  const RestaurantDetailsScreen({required this.restaurant});

  static Route route({required Restaurant restaurant}) {
    return MaterialPageRoute(
        builder: (_) => RestaurantDetailsScreen(restaurant: restaurant),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 30 //50
                        )
                      ),
                      image: DecorationImage(
                        image: NetworkImage(restaurant.imageUrl),
                        fit: BoxFit.cover
                      )
                    ),
                  ),

                  Positioned(
                    bottom: 20,
                    child: Glassmorphism(
                      blur: 15,
                      opacity: 0.1,
                      child: RestaurantInformation(restaurant: restaurant),
                    ),
                  )
                ],
              ),

              SizedBox(height: 20),
              
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: restaurant.tags.length,
                  itemBuilder: (context, index) {
                    return _buildMenuItems(restaurant, context, index);
                  }),
              
              SizedBox(height: 20),
            ],
          ),
        ));
  }


  Widget _buildMenuItems(Restaurant restaurant, BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        restaurant.menuItems.where((menuItem) => menuItem.category == restaurant.tags[index]).isEmpty
        ? Container()
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            restaurant.tags[index],
            style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            children: restaurant.menuItems
                .where((menuItem) => menuItem.category == restaurant.tags[index])
                .map((menuItem) => MenuItemCard(menuItem: menuItem))
                .toList()
              
          ),
        ),
      ],
    );
  }
}