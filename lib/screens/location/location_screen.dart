import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  static const String routeName = '/location';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => LocationScreen(), settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location')),
      body: Center(
        child: ElevatedButton(
          child: Text('Home Screen'),
          onPressed: () {
            Navigator.pushNamed(context, "/");
          },
        ),
      ),
    );
  }
}