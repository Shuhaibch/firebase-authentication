// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetUserDataSuccess extends HomeState {
  final UserModel userDetails;
  GetUserDataSuccess({
    required this.userDetails,
  });
}

class GetUserDatafailed extends HomeState {
  final String message;
  GetUserDatafailed({
    required this.message,
  });
}

class GetUserDataLoading extends HomeState {}
