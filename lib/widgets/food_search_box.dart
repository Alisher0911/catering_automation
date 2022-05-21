import 'package:catering/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FoodSearchBox extends StatelessWidget {
  const FoodSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "What would you like to eat?",
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary
                ),
                contentPadding: const EdgeInsets.only(left: 20, bottom: 5, top: 12.5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
          ),

          SizedBox(width: 10),

          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),

            ),
            child: IconButton(
                icon: Icon(Icons.menu),
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  // Navigator.pushNamed(context, '/filter');
                  pushNewScreenWithRouteSettings(
                    context,
                    settings: RouteSettings(name: FilterScreen.routeName),
                    screen: FilterScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
            ),
          )
        ],
      ),
    );
  }
}