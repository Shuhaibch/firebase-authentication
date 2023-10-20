import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/user_model.dart';

class HomeImplimentation {
  // final _db = FirebaseFirestore.instance;

  Future getCurrentUserData(String id) async {
    // FirebaseUser user = await FirebaseAuth.instance.currentUser!();
    // final docRef = _db.collection("Users").doc(id);

    log(id.toString());
    try {
      // final snapshot =
      //     await _db.collection("Users").where("uid", isEqualTo: id).get();
      // log(snapshot.docs.toString());
      // final userData =
      //     snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      // log(userData.name.toString());
      // final CollectionReference ref =
      //     FirebaseFirestore.instance.collection("User");
      //     final DocumentSnapshot snapshot = ref.snapshots.
      return {
        'status': "success",
        "data": 'userData',
      };
    } on FirebaseException catch (e) {
      return {
        'status': "failed",
        "message": e.code,
      };
    } catch (e) {
      return {
        'status': 'failes',
        'message': e,
      };
    }
  }
}
