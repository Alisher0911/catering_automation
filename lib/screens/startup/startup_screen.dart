import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StartupScreen extends StatelessWidget {
  static const String routeName = '/startup';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => StartupScreen(), settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/onboarding");
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background_start.jpg"),
                  fit: BoxFit.cover
                )
              ),
            ),
      
            SizedBox(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Container(
                      width: 262,
                      height: 262,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                      ),
                    ),
                  ),
                  Positioned(
                    left: -15,
                    bottom: 0,
                    child: SvgPicture.asset(
                      'assets/startup/ellipse_vector.svg',
                      height: 185,
                      width: 230,
                    ),
                  ),
                  Positioned(
                    child: Image(
                      image: AssetImage("assets/happy_food.png"),
                    ),
                  ),
                  Positioned(
                    top: -45,
                    right: 15,
                    child: SvgPicture.asset(
                      'assets/startup/person.svg',
                      width: 105,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),          
          ],
          
        ),
      ),
    );
  }
}