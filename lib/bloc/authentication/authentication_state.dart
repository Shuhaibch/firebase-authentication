// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

//? login state
class LoginSuccessState extends AuthenticationState {
  final User loggedUser;
  LoginSuccessState({
    required this.loggedUser,
  });
}

class LoginfailedState extends AuthenticationState {
  final String errorMsg;
  LoginfailedState({
    required this.errorMsg,
  });
}

class LoginLoadingState extends AuthenticationState {}

//? logout state
class LoggedOutloadingState extends AuthenticationState {}

class LoggedOutSuccessState extends AuthenticationState {}

class LoggedOutFailedState extends AuthenticationState {}

//? Signin state
class SignUploadingState extends AuthenticationState {}

class SignUpSuccessState extends AuthenticationState {
  final User loggedUser;
  SignUpSuccessState({
    required this.loggedUser,
  });
}

class SignUpFailedState extends AuthenticationState {
  final String message;
  SignUpFailedState({
    required this.message,
  });
}
