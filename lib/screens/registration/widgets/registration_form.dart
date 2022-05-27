import 'package:catering/bloc/register/register_bloc.dart';
import 'package:catering/config/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegistrationForm extends StatefulWidget {
  const RegistrationForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}


class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _isHidden1 = true;
  bool _isHidden2 = true;

  void _togglePassword() {
    setState(() {
      _isHidden1 = !_isHidden1;
    });
  }

  void _toggleConfirmPassword() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Регистрация не удалась."),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is RegisterSuccess) {
          Navigator.pushReplacementNamed(context, "/root");
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
          
              // Username
              TextFormField(
                controller: usernameController,
                style: inputText,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:  BorderSide(color: Colors.white ),
                  ),
                  filled: true,
                  fillColor: Color(0xFF393939),
                  hintText: 'Имя пользователя',
                  hintStyle: hintText,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.person, color: Color(0xFF626262), size: 25)
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Поле не может быть пустым';
                  }
                  return null;
                },
              ),
          
              SizedBox(height: 20),
          
              // Email
              TextFormField(
                controller: emailController,
                style: inputText,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:  BorderSide(color: Colors.white ),
                  ),
                  filled: true,
                  fillColor: Color(0xFF393939),
                  hintText: 'E-mail',
                  hintStyle: hintText,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(Icons.alternate_email_sharp, color: Color(0xFF626262), size: 25)
                  ),
                  
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Поле не может быть пустым';
                  }
                  var regExp = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");
                  if (!regExp.hasMatch(emailController.text)) {
                    return 'Введите корректный e-mail';
                  }
                  return null;
                },
              ),
          
              SizedBox(height: 20),
          
              // Password
              TextFormField(
                controller: passwordController,
                style: inputText,
                textAlignVertical: TextAlignVertical.center,
                obscureText: _isHidden1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:  BorderSide(color: Colors.white ),
                  ),
                  filled: true,
                  fillColor: Color(0xFF393939),
                  hintText: 'Пароль',
                  hintStyle: hintText,
                  contentPadding:EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.lock, color: Color(0xFF626262), size: 25)
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      // onTap: _togglePassword,
                      child: Icon(
                        _isHidden1 ? Icons.visibility : Icons.visibility_off,
                        color: Color(0xFF626262),
                        size: 25,
                      ),
                    ),
                  )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Поле не может быть пустым';
                  }
                  if (value.length < 6 || value.length > 30) {
                    return 'Пароль должен состоять из 6-30 символов';
                  }
                  return null;
                },
              ),
          
              SizedBox(height: 20),
          
              // Confirm password
              TextFormField(
                controller: confirmPasswordController,
                style: inputText,
                textAlignVertical: TextAlignVertical.center,
                obscureText: _isHidden2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:  BorderSide(color: Colors.white ),
                  ),
                  filled: true,
                  fillColor: Color(0xFF393939),
                  hintText: 'Подтвердить пароль',
                  hintStyle: hintText,
                  contentPadding:EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.lock, color: Color(0xFF626262), size: 25)
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      // onTap: _togglePassword,
                      child: Icon(
                        _isHidden2 ? Icons.visibility : Icons.visibility_off,
                        color: Color(0xFF626262),
                        size: 25,
                      ),
                    ),
                  )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Поле не может быть пустым';
                  }
                  if (value != passwordController.text) {
                    return 'Пароль не совпадает';
                  }
                  return null;
                },
              ),
          
              SizedBox(height: 15),
          
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: appColor1),
                  children: [
                    TextSpan(
                      text: "* ",
                      style: TextStyle(color: Colors.red)
                    ),
                    TextSpan(text: "Нажимая на кнопку "),
                    TextSpan(
                      text: "Регистрация",
                      style: TextStyle(color: appColor2),
                    ),
                    TextSpan(text: ", вы соглашаетесь с публичной офертой")
                  ]
                )
              ),
          
              SizedBox(height: 40),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Регистрация",
                    style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
                  ),
          
                  state is RegisterLoading ?
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: CupertinoActivityIndicator(
                        color: appColor2,
                        radius: 15,
                      ),
                    )
                  )
                  : Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: appColor2,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: appColor2.withOpacity(0.25),
                          spreadRadius: 5,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterBloc>(context).add(
                            RegisterButtonPressed(
                              email: emailController.text,
                              username: usernameController.text,
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text
                            )
                          );
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Registration success!')),
                          // );
                          // Navigator.pushReplacementNamed(context, "/root");
                        }
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ),
                  )
                ],
              )
            ],
          )
        );
      },
    );
  }
}
