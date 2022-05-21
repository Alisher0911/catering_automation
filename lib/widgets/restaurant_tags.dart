import 'package:catering/models/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantTags extends StatelessWidget {
  const RestaurantTags({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: restaurant.tags
        .map((tag) =>
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text(tag),
            )
        )
            // restaurant.tags.indexOf(tag) == restaurant.tags.length - 1
            //     ? Text(tag, style: Theme.of(context).textTheme.bodyText1)
            //     : Text("$tag, ", style: Theme.of(context).textTheme.bodyText1))
        .toList()
    );
  }
}