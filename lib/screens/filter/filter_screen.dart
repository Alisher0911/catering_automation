import 'package:catering/bloc/filter/filter_bloc.dart';
import 'package:catering/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/custom_category_filter.dart';
import 'widgets/custom_price_filter.dart';

class FilterScreen extends StatelessWidget {
  static const String routeName = '/filter';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => FilterScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Filter')),
        bottomNavigationBar: BottomAppBar(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                if (state is FilterLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                else if (state is FilterLoaded) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 50)),
                    child: Text("Apply"),
                    onPressed: () {
                      var categories = state.filter.categoryFilters
                          .where((filter) => filter.value)
                          .map((filter) => filter.category.name)
                          .toList();
                      
                      var prices = state.filter.priceFilters
                          .where((filter) => filter.value)
                          .map((filter) => filter.price.price)
                          .toList();

                      List<Restaurant> restaurants = Restaurant.restaurants
                                        .where((restaurant) => categories.any((category) => restaurant.tags.contains(category)))
                                        //.where((restaurant) => prices.any((price) => restaurant.priceCategory.contains(price)))
                                        .toList();

                      Navigator.pushNamed(context, '/restaurant-listing', arguments: restaurants);
                    },
                  );
                }
                
                else {
                  return Text("Something went wrong.");
                }
              },
            )
          ],
        )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Price",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Theme.of(context).colorScheme.primary)),
              CustomPriceFilter(),
              Text("Category",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Theme.of(context).colorScheme.primary)),
              CustomCategoryFilter(),
            ],
          ),
        ));
  }
}
