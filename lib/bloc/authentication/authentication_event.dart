// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final String name;
  final String password;
  final String email;
  final BuildContext context;
  LoginEvent({
    required this.name,
    required this.password,
    required this.email,
    required this.context,
  });
}

class LogOutEvent extends AuthenticationEvent {}

class SignUpEvent extends AuthenticationEvent {
  final String name;
  final String password;
  final String email;
  final int phone;
  final BuildContext context;

  SignUpEvent({
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
    required this.context,
  });
}
