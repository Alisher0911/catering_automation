import 'package:catering/bloc/authentication/authentication_bloc.dart';
import 'package:catering/config/text_styles.dart';
import 'package:catering/screens/main/main_screen.dart';
import 'package:catering/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RootScreen extends StatelessWidget {
  static const String routeName = '/root';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => RootScreen(), settings: RouteSettings(name: routeName));
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return MainScreen();
        } else if (state is AuthenticationUnauthenticated) {
          return LoginScreen();
        } else if (state is AuthenticationLoading) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(appColor2),
                      strokeWidth: 4.0,
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(appColor2),
                    strokeWidth: 4.0,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
