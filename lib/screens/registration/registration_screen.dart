import 'package:catering/bloc/register/register_bloc.dart';
import 'package:catering/config/text_styles.dart';
import 'package:catering/repositories/user_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/registration_form.dart';

class RegistrationScreen extends StatelessWidget {
  static const String routeName = '/registration';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => RegistrationScreen(), settings: RouteSettings(name: routeName));
  }


  // @override
  // Widget build(BuildContext context) {
  //   final _formKey = GlobalKey<FormState>();
  //   TextEditingController usernameController = TextEditingController();
  //   TextEditingController emailController = TextEditingController();
  //   TextEditingController passwordController = TextEditingController();
  //   TextEditingController confirmPasswordController = TextEditingController();

  //   bool _isHidden = true;

  //   return Scaffold(
  //       backgroundColor: Theme.of(context).colorScheme.background,
  //       body: SizedBox(
  //         height: MediaQuery.of(context).size.height,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 80),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 "Create an account",
  //                 style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
  //               ),
        

  //               SingleChildScrollView(
  //                 child: SizedBox(
  //                   height: MediaQuery.of(context).size.height * 0.6,
  //                   child: RegistrationForm(formKey: _formKey, emailController: emailController, passwordController: passwordController, isHidden: _isHidden, usernameController: usernameController, confirmPasswordController: confirmPasswordController,)
  //                 ),
  //               ),
        
  //               // Go to Sign Up
  //               RichText(
  //                 text: TextSpan(
  //                   style: Theme.of(context).textTheme.headline5!.copyWith(color: appColor1),
  //                   children: [
  //                     TextSpan(
  //                       text: "Already a member? "
  //                     ),
  //                     TextSpan(
  //                       text: "Login",
  //                       style: TextStyle(color: appColor2),
  //                       recognizer: TapGestureRecognizer()
  //                         ..onTap = () {
  //                           Navigator.pushNamed(context, "/login");
  //                         }
  //                     )
  //                   ]
  //                 )
  //               ),
  //             ],
  //           ),
  //         ),
  //       )
  //   );
  // }
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    bool _isHidden = true;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 80),
                child: Text(
                  "Создайте\nучетную запись",
                  style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
                ),
              ),
          

              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocProvider(
                        create: (context) { 
                          return RegisterBloc(
                            userRepository: context.read<UserRepository>(),
                          );
                        },
                        child: RegistrationForm(formKey: _registrationFormKey, emailController: emailController, passwordController: passwordController, isHidden: _isHidden, usernameController: usernameController, confirmPasswordController: confirmPasswordController),
                      ),
                      

                      SizedBox(height: 60),

                      // Go to Sign In
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.headline5!.copyWith(color: appColor1),
                          children: [
                            TextSpan(
                              text: "Уже зарегистрировались? "
                            ),
                            TextSpan(
                              text: "Войти",
                              style: TextStyle(color: appColor2),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, "/login");
                                }
                            )
                          ]
                        )
                      ),

                      SizedBox(height: 20)
                    ],
                  )
                ),
              ),
            ],
          ),
        )
    );
  }
}