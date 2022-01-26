import 'package:firebase_auth/firebase_auth.dart';

import 'package:airplane/models/user_model.dart';
import 'package:airplane/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> signIn({
    required String? email,
    required String? password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email ?? '',
        password: password ?? '',
      );

      UserModel userModel = await UserService().getUserById(
        userCredential.user?.uid,
      );
      return userModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel userModel = UserModel(
        id: userCredential.user?.uid,
        email: userCredential.user?.email,
        name: name,
        hobby: hobby,
        balance: 28000000,
      );

      await UserService().setUser(userModel);

      return userModel;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
