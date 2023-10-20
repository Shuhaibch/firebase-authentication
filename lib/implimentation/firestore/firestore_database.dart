// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  // final DocumentReference documentReference = FirebaseFirestore.instance;
  Future addUserDetails({
    required String? id,
    required String name,
    required int phone,
    required String email,
  }) async {
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('Users').doc(id);
    final data = {'name': name, 'phone': phone, 'email': email};
    try {
      await ref.set(data);
      return {
        'status': "sccesss",
      };
    } catch (e) {
      print(e);
      return {
        'status': "failed",
      };
    }
  }
}
