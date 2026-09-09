import 'package:expenseflow_firebase_flutter/features/authentication/authentication_state.dart';

abstract class AuthenticationEvent {}

class Signup extends AuthenticationEvent {
  final String email;
  final String password;

  Signup({
    required this.email,
    required this.password,
  });
}

class Login extends AuthenticationEvent {
  final String email;
  final String password;

  Login({
    required this.email,
    required this.password,
  });
}

class Obscure extends AuthenticationEvent{}