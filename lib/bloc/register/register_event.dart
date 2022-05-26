part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String username;
  final String password;
  final String confirmPassword;

  const RegisterButtonPressed({
    required this.email,
    required this.username,
    required this.password,
    required this.confirmPassword
  });

  @override
  List<Object> get props => [email, username, password, confirmPassword];

  @override
  String toString() => 'RegisterButtonPressed { email: $email, password: $password }';
}