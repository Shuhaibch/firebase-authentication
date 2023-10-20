// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetUserData extends HomeEvent {
  final String id ;
  GetUserData({
    required this.id,
  });
}
