import 'dart:developer';

import 'package:firebase/bloc/authentication/authentication_bloc.dart';
import 'package:firebase/bloc/home/home_bloc.dart';
import 'package:firebase/main.dart';
import 'package:firebase/view/auth/screen_sign_up.dart';
import 'package:firebase/view/home/screen_home_page.dart';
import 'package:firebase/widgets/decaratioin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passCtrl = TextEditingController();
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController emailCtrl = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Login Screen"),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  child: Column(
                    children: [
                      // TextFormField(
                      //   controller: nameCtrl,
                      //   decoration: loginInputDecation(
                      //     "Name",
                      //   ),
                      // ),
                      // const SizedBox( shuhaib00@gmail.com
                      //   height: 10,
                      // ),

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailCtrl,
                        decoration: loginInputDecation("Email"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        controller: passCtrl,
                        decoration: loginInputDecation("Password"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //? Log in button
                  BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                      if (state is LoginfailedState) {
                        log("Login  failes");
                      } else if (state is LoginSuccessState) {
                        navigatorKey.currentState!.pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => HomeBloc()
                                ..add(GetUserData(
                                  id: state.loggedUser.uid,
                                )),
                              child: HomeScreen(user: state.loggedUser),
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      log(state.toString());
                      if (state is LoginLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return TextButton(
                        onPressed: () {
                          context.read<AuthenticationBloc>().add(
                                LoginEvent(
                                    name: nameCtrl.text,
                                    password: passCtrl.text,
                                    email: emailCtrl.text,
                                    context: context),
                              );
                          // Authentication().loginUsingEmailAndPass(
                          //   emailCtrl.text,
                          //   passCtrl.text,
                          //   context,
                          // );
                        },
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.deepPurpleAccent)),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                      );
                    },
                  ),

                  //? Sign up button
                  TextButton(
                    onPressed: () {
                      navigatorKey.currentState!.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const ScreenSignUp(),
                        ),
                      );
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.purple)),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
