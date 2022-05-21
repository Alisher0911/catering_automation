import 'package:flutter/material.dart';

class QRCodeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => QRCodeScreen(), settings: RouteSettings(name: routeName));
  }

  const QRCodeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text("QR Code Screen"),
    );
  }
}