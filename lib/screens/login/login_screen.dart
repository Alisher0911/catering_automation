import 'package:catering/config/text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => LoginScreen(), settings: RouteSettings(name: routeName));
  }


  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {  

    bool _isHidden = true;

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
                      LoginForm(formKey: _signInFormKey, emailController: loginEmailController, passwordController: loginPasswordController, isHidden: _isHidden),

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
                                  Navigator.pushNamed(context, "/registration");
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