import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../services/firebase/user_services.dart';
import '/model/user.dart';

extension FirebaseUserExtension on auth.FirebaseUser {
  // TODO: extension to convert user
  User convertToUser(
      {String name = "No Name",
      List<String> selectedGenres = const [],
      String selectedLanguage = "English",
      int balance = 500000}) {
    return User(this.uid, this.email,
        name: name,
        selectedGenres: selectedGenres,
        selectedLanguage: selectedLanguage,
        balance: balance);
  }

  // TODO: get user extension
  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
