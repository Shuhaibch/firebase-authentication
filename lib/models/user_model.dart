import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final int phone;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
  });
  tojson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;

    return UserModel(
      id: documentSnapshot.id,
      name: data['name'],
      email: data["email"],
      phone: data["phone"],
    );
  }
}
