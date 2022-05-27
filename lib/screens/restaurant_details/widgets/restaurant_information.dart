import 'package:catering/bloc/place/place_bloc.dart';
import 'package:catering/bloc/restaurant/restaurant_bloc.dart';
import 'package:catering/config/text_styles.dart';
import 'package:catering/models/booking_table_model.dart';
import 'package:catering/models/restaurant_model.dart';
import 'package:catering/repositories/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantInformation extends StatelessWidget {
  const RestaurantInformation({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white, fontSize: 28),
            ),
            SizedBox(height: 5),
            Text(
              restaurant.address,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            _showTables(context, restaurant);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: //IconButton(
                // onPressed: () {
                //   _showTables(context);
                // },
                // padding: EdgeInsets.zero,
                // constraints: BoxConstraints(),
                Icon(
              Icons.table_restaurant_rounded,
              color: Color(0xFF45BFE4),
              size: 25,
            ),
            //),
          ),
        )
      ]),
    );
  }
}

void _showTables(context, Restaurant restaurant) {
  showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return BlocProvider(
          create: (context) =>
              RestaurantBloc(restaurantRepository: context.read<RestaurantRepository>(), placeBloc: context.read<PlaceBloc>())
                ..add(LoadRestaurantTables(id: restaurant.id)),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.7,
            minChildSize: 0.4,
            maxChildSize: 0.8,
            builder: (_, controller) => Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: Text("Бронь столов",
                      style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white)
                    ),
                  ),

                  BlocBuilder<RestaurantBloc, RestaurantState>(
                    builder: (context, state) {
                      if (state is RestaurantTablesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is RestaurantTablesLoaded) {
                        return Expanded(
                          child: ListView.builder(
                            controller: controller,
                            itemCount: state.tables.length,
                            itemBuilder: (_, index) { 
                              return _buildTables(context, state.tables[index]);
                            }
                          ),
                        );
                      } else if (state is RestaurantTablesError) {
                        return Center(
                          child: Text(state.error.toString(), style: TextStyle(color: Colors.white)),
                        );
                      }
                      else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

Widget _buildTables(BuildContext context, BookingTable table) {
  return Container(
    margin: EdgeInsets.only(top: 20),
    child: ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(vertical: 4),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              table.title,
              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white
            ),
          ),
          Text(
            table.subTitle,
            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
          ),
        ],
      ),
      leading: Container(
        height: 85,
        width: 85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(
                    table.imageUrl),
                fit: BoxFit.cover)),
      ),
      trailing: SizedBox(
        width: 80,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              minimumSize: const Size.fromHeight(40),
              side: BorderSide(width: 2, color: KPrimaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              )),
          onPressed: () {},
          child: Text(
            "Бронь",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: KPrimaryColor),
          ),
        ),
      ),
    ),
  );
}
