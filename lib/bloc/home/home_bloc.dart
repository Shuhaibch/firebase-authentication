import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase/implimentation/home/home_firebase.dart';
import 'package:firebase/models/user_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    //* Get User details */
    on<GetUserData>((event, emit) async {
      emit(GetUserDataLoading());
      var res = await HomeImplimentation().getCurrentUserData(event.id);
      log(res['data']);
      if (res['status'] == 'success') {
        emit(GetUserDataSuccess(userDetails: res['data']));
      } else {
        emit(GetUserDatafailed(message: res['message']));
      }
    });
  }
}
