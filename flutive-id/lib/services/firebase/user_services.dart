import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user.dart';

class UserServices {
  // TODO: buat collection user -> FirebaseFirestore (change from Firestore)
  static CollectionReference _collectUser =
      Firestore.instance.collection('users');

  // TODO: sign up dan untuk data selected genre berupa array
  static Future<void> updateUser(User user) async {
    // TODO: add data to firestore
    _collectUser.document(user.id).setData({
      "email": user.email,
      "name": user.name,
      "balance": user.balance,
      "selectedGenres": user.selectedGenres,
      "selectedLanguage": user.selectedLanguage,
      "profilePicture": user.profilePicture ?? ""
    });
  }

  // TODO: get user setelah login
  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _collectUser.document(id).get();

    // TODO: buat mappingnya
    // Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;

    return User(
      id,
      snapshot.data["email"],
      balance: snapshot.data["balance"],
      profilePicture: snapshot.data["profilePicture"],
      selectedGenres: (snapshot.data["selectedGenres"] as List)
          .map((e) => e.toString())
          .toList(),
      selectedLanguage: snapshot.data["selectedLanguage"],
      name: snapshot.data["name"],
    );
  }
}
