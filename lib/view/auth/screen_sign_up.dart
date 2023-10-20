import 'dart:developer';

import 'package:firebase/bloc/authentication/authentication_bloc.dart';
import 'package:firebase/main.dart';
import 'package:firebase/view/auth/screen_login.dart';
import 'package:firebase/view/home/screen_home_page.dart';
import 'package:firebase/widgets/decaratioin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSignUp extends StatelessWidget {
  const ScreenSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passCtrl = TextEditingController();
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController emailCtrl = TextEditingController();
    TextEditingController phoneCtrl = TextEditingController();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("SignUp"),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameCtrl,
                          decoration: loginInputDecation(
                            "Name",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailCtrl,
                          decoration: loginInputDecation("Email"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneCtrl,
                          decoration: loginInputDecation("Phone"),
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
                    TextButton(
                      onPressed: () {
                        navigatorKey.currentState!.pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const ScreenLogin(),
                          ),
                        );
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.purple)),
                      child: const Text(
                        "Login ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    BlocConsumer<AuthenticationBloc, AuthenticationState>(
                      listener: (context, state) {
                        if (state is SignUpFailedState) {
                          log("Login  failes");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                        } else if (state is SignUpSuccessState) {
                          navigatorKey.currentState!.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(user: state.loggedUser),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is SignUploadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return TextButton(
                          onPressed: () {
                            context.read<AuthenticationBloc>().add(
                                  SignUpEvent(
                                    name: nameCtrl.text,
                                    password: passCtrl.text,
                                    email: emailCtrl.text,
                                    phone: int.parse(phoneCtrl.text),
                                    context: context,
                                  ),
                                );
                            // Authentication().signUpUsingEmailAndPass(
                            //   emailCtrl.text,
                            //   passCtrl.text,
                            //   int.parse(phoneCtrl.text),
                            //   nameCtrl.text,
                            //   context
                            // );
                          },
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.deepPurpleAccent)),
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
