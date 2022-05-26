import 'dart:async';

import 'package:catering/bloc/authentication/authentication_bloc.dart';
import 'package:catering/screens/root/root_screen.dart';
import 'package:catering/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StartupScreen extends StatefulWidget {
  static const String routeName = '/startup';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => StartupScreen(), settings: RouteSettings(name: routeName));
  }

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}


class _StartupScreenState extends State<StartupScreen> {

  // Future<void> _handleStartScreen() async {
  //   Auth _auth = Auth();

  //   if (await _auth.isLoggedIn()) {
  //     Navigator.popAndPushNamed(context, ChatScreen.id);
  //   } else {
  //     Navigator.popAndPushNamed(context, WelcomeScreen.id);
  //   }
  // }

  late Widget nextScreen;
  
  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }


  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      // _handleStartScreen();
      setState(() {
        nextScreen = RootScreen();
      });
    } else {
      await prefs.setBool('seen', true);
      // Navigator.pushNamed(context, IntroScreen.id);
      setState(() {
        nextScreen = OnboardingScreen();
      });
    }

    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(_createRoute())
    );
  }


  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
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
    );
  }
}