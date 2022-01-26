import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:airplane/models/user_model.dart';

class UserService {
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel? user) async {
    try {
      _userRef.doc(user?.id).set({
        'email': user?.email,
        'name': user?.name,
        'hobby': user?.hobby,
        'balance': user?.balance,
      });
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<UserModel> getUserById(String? id) async {
    try {
      DocumentSnapshot snapshot = await _userRef.doc(id).get();
      return UserModel(
        id: id,
        email: snapshot['email'],
        name: snapshot['name'],
        hobby: snapshot['hobby'],
        balance: snapshot['balance'],
      );
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
