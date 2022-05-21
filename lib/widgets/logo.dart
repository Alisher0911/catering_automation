import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 73,
      height: 73,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        "assets/happy_food.png",
        width: 48,
        height: 34,
      ),
    );
  }
}