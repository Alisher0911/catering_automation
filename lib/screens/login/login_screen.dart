import 'package:catering/bloc/authentication/authentication_bloc.dart';
import 'package:catering/bloc/login/login_bloc.dart';
import 'package:catering/config/text_styles.dart';
import 'package:catering/repositories/user_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => LoginScreen(), settings: RouteSettings(name: routeName));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 80),
                child: Text(
                  "Добро\nпожаловать!",
                  style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
                ),
              ),

              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocProvider(
                        create: (context) { 
                          return LoginBloc(
                            userRepository: context.read<UserRepository>(),
                            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
                            // categoryBloc: BlocProvider.of<CategoryBloc>(context)
                          );
                        },
                        child: LoginForm(),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.2),

                      // Go to Sign Up
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.headline5!.copyWith(color: appColor1),
                          children: [
                            TextSpan(
                              text: "Нет учетной записи? "
                            ),
                            TextSpan(
                              text: "Регистрация",
                              style: TextStyle(color: appColor2),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(context, "/registration");
                                }
                            )
                          ]
                        )
                      ),

                      SizedBox(height: 20)
                    ],
                  )
                )
              ),

              
            ],
          ),
        )
    );
  }
}