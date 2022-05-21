import 'package:catering/models/restaurant_model.dart';
import 'package:catering/screens/restaurant_details/widgets/menu_item_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'widgets/glassmorphism.dart';
import 'widgets/restaurant_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBarIndicator(
                                  rating: 2.75,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star_rate_rounded,
                                    color: Color(0xFF45BFE4),
                                  ),
                                  itemCount: 5,
                                  itemSize: 25.0,
                                  direction: Axis.horizontal,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  restaurant.name,
                                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white, fontSize: 28),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  restaurant.address,
                                  style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white.withOpacity(0.6), fontWeight: FontWeight.normal),
                                )
                              ],
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Icon(
                                Icons.table_restaurant_rounded,
                                color: Color(0xFF45BFE4),
                                size: 25,
                              ),
                            )
                          ]
                        ),
                      ),
                    ),
                  )
                ],
              ),

              // RestaurantInformation(restaurant: restaurant),

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
        // Column(
        //     children: restaurant.menuItems
        //         .where(
        //             (menuItem) => menuItem.category == restaurant.tags[index])
        //         .map((menuItem) => Column(
        //           children: [
        //               Container(
        //                 color: Colors.white,
        //                 padding: const EdgeInsets.symmetric(horizontal: 20),
        //                 child: ListTile(
        //                   dense: true,
        //                   contentPadding: EdgeInsets.zero,
        //                   title: Text(
        //                     menuItem.name,
        //                     style: Theme.of(context).textTheme.headline5
        //                   ),
        //                   subtitle: Text(
        //                     menuItem.description,
        //                     style: Theme.of(context).textTheme.bodyText1
        //                   ),
        //                   trailing: Row(
        //                     mainAxisAlignment: MainAxisAlignment.end,
        //                     mainAxisSize: MainAxisSize.min,
        //                     children: [
        //                       Text(
        //                         "\$${menuItem.price}",
        //                         style: Theme.of(context).textTheme.bodyText1
        //                       ),
        //                       BlocBuilder<BasketBloc, BasketState>(
        //                         builder: (context, state) {
        //                           return IconButton(
        //                             onPressed: () {
        //                               context.read<BasketBloc>().add(AddItem(menuItem));
        //                             },
        //                             icon: Icon(
        //                               Icons.add_circle,
        //                               color: Theme.of(context).colorScheme.secondary
        //                             )
        //                           );
        //                         },
        //                       )
        //                     ]
        //                   ),
        //                 ),
        //               ),
        //               Divider(
        //                 height: 2,
        //               )
        //           ]
        //         ))
        //         .toList()
        // )
      ],
    );
  }
}
