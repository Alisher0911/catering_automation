import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => FavouriteScreen(), settings: RouteSettings(name: routeName));
  }

  const FavouriteScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text("Favourite Screen"),
    );
  }
}