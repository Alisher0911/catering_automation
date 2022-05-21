import 'package:catering/bloc/restaurant/restaurant_bloc.dart';
import 'package:catering/models/category_model.dart';
import 'package:catering/models/promo_model.dart';
import 'package:catering/screens/home/widgets/navigation_drawer.dart';
import 'package:catering/widgets/category_box.dart';
import 'package:catering/widgets/food_search_box.dart';
import 'package:catering/widgets/promo_box.dart';
import 'package:catering/widgets/restaurant_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => HomeScreen(), settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppBar(
          actionButton: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(CupertinoIcons.person_alt_circle, size: 40),
              onPressed: () {},
            ),
          ),
        ),
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: Category.categories.length,
                      itemBuilder: ((context, index) {
                        return CategoryBox(
                            category: Category.categories[index]);
                      })),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 125,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: Promo.promos.length,
                      itemBuilder: ((context, index) {
                        return PromoBox(promo: Promo.promos[index]);
                      })),
                ),
              ),

              FoodSearchBox(),

              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Top Rated",
                          style: Theme.of(context).textTheme.headline3!.copyWith(fontStyle: FontStyle.italic, fontFamily: "Nunito", fontWeight: FontWeight.w700, color: Colors.white)))),

              BlocBuilder<RestaurantBloc, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (state is RestaurantLoaded) {
                    // return ConstrainedBox(
                    //   constraints: BoxConstraints(maxHeight: 250, minHeight: 200),
                      return ListView.builder(
                        // scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.restaurants.length,
                        itemBuilder: (context, index) {
                          return RestaurantCard(
                              restaurant: state.restaurants[index]);
                        });
                    //);
                  }
                  else if (state is RestaurantError) {
                    return Center(
                      child: Text(state.error.toString(), style: TextStyle(color: Colors.white)),
                    );
                  }
                  else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ));
  }
}