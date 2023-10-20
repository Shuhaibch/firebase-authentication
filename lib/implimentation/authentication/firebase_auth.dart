// ignore_for_file: avoid_print, use_build_context_synchronously, unused_local_variable

import 'dart:developer';

import 'package:firebase/implimentation/firestore/firestore_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;

  Future signUpUsingEmailAndPass(String email, String password, int phone,
      String name, BuildContext context) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final addDatabse = DataBase().addUserDetails(
        email: email,
        id: credential.additionalUserInfo?.providerId,
        name: name,
        phone: phone,
      );
      // navigatorKey.currentState!.pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const HomeScreen(),
      //   ),
      // );
      return {
        'status': 'success',
        'data': credential.user,
        "database": addDatabse,
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text('The password provided is too weak.')));
        return {
          'status': 'failed',
          'message': "The password provided is too weak.",
        };
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text('The account already exists for that email.')));
        return {
          'status': 'failed',
          'message': "The account already exists for that email.",
        };
      } else {
        print('The account already exists for that email.');
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(e.code)));
        return {
          'status': 'failed',
          'message': e.code,
        };
      }
    } catch (e) {
      print(e);
      log(e.toString());
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('Error Occured')));

      return {
        'status': 'failed',
        'message': "Error Occured",
      };
    }
  }

  Future loginUsingEmailAndPass(
      String email, String password, BuildContext context) async {
    log(email, name: "in login");
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('You are Logged in')));
      // navigatorKey.currentState!.pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const HomeScreen(),
      //   ),
      // );
      return {
        'status': 'success',
        'data': credential.user,
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        log('wrong-password');
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text('Wrong password provided for that user.')));
        return {
          'status': 'failed',
          'message': "Wrong password provided for that user.",
        };
      } else if (e.code == 'user-not-found') {
        log('No user found for that email.');
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('No user found for that email.')));

        return {
          'status': 'failed',
          'message': "No user found for that email.",
        };
      } else {
        log('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid Password or Email"),
          ),
        );

        return {'status': 'failed', 'message': 'Invalid Password or Email'};
      }
    } catch (e) {
      print(e);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('Error Occured')));
      return {'status': 'failed', 'message': "Error Occured"};
    }
  }

  Future loggedOut() async {
    try {
      _auth.signOut();
      return {
        'status': 'success',
        'message': "true",
      };
    } catch (e) {
      print(e);
      return {
        'status': 'failed',
        'message': "Error Occured",
      };
    }
  }
}
