// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase/bloc/authentication/authentication_bloc.dart';
import 'package:firebase/main.dart';
import 'package:firebase/view/auth/screen_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../bloc/home/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    this.user,
  }) : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    // log(user!.uid);
    // final CollectionReference collectionReference =
    //     FirebaseFirestore.instance.collection("User");
    // log(collectionReference.id);
    // final DatabaseReference ref =
    //     FirebaseDatabase.instance.ref("User/${user!.uid}");
    // log(ref.path);

    // final FirebaseAuth auth = FirebaseAuth.instance;
    // // Get the current user.
    // final User? user = auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () {
                context.read<AuthenticationBloc>().add(LogOutEvent());
              },
              child: const Text("LogOut"))
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is LoggedOutSuccessState) {
            navigatorKey.currentState!.pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ScreenLogin(),
              ),
            );
          } else if (state is LoggedOutFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to logout")));
          }
        },
        builder: (context, state) {
          if (state is GetUserDataLoading) {
            return const CircularProgressIndicator();
          } else if (state is GetUserDataSuccess) {
            return Container(
              alignment: Alignment.center,
              child: Text(state.userDetails.name ?? 'not Found'),
            );
          }
          return Container(
            alignment: Alignment.center,
            child: Text("Error"),
          );
        },
      ),
    );
  }
}
