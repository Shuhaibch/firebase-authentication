// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:firebase/implimentation/authentication/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginEvent>(
      (event, emit) async {
        emit(LoginLoadingState());
        var _auth = await Authentication()
            .loginUsingEmailAndPass(event.email, event.password, event.context);
        if (_auth['status'] == 'success') {
          emit(LoginSuccessState(loggedUser: _auth['data']));
        } else {
          emit(LoginfailedState(errorMsg: _auth["message"]));
        }
      },
    );
    on<LogOutEvent>((event, emit) async {
      emit(LoggedOutloadingState());
      var _auth = await Authentication().loggedOut();
      if (_auth['status'] == 'success') {
        emit(LoggedOutSuccessState());
      } else {
        emit(LoggedOutFailedState());
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(SignUploadingState());
      var _auth = await Authentication().signUpUsingEmailAndPass(
        event.email,
        event.password,
        event.phone,
        event.name,
        event.context,
      );
      if (_auth['status'] == 'success') {
        emit(
          SignUpSuccessState(
            loggedUser: _auth['data'],
          ),
        );
      } else {
        emit(SignUpFailedState(message: _auth['message']));
      }
    });
  }
}
