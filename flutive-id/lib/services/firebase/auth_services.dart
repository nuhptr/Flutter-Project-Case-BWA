import 'package:firebase_auth/firebase_auth.dart' as auth;

import '/model/user.dart';
import '/extension/firebase_user_extension.dart';
import 'user_services.dart';

class AuthServices {
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // TODO: Sign Up for user
  static Future<SignInSignUpResult> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      // TODO: Authresult/ User Credential
      auth.AuthResult resultCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = resultCredential.user.convertToUser(
        name: name,
        selectedGenres: selectedGenres,
        selectedLanguage: selectedLanguage,
      );

      // TODO: mengirim data ke updateUser
      await UserServices.updateUser(user);

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(",")[1].trim());
    }
  }

  // TODO: sign in user
  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      // TODO: sign in method
      auth.AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = await result.user.fromFireStore();

      return SignInSignUpResult(user: user);
    } catch (e) {
      // TODO: return error message
      return SignInSignUpResult(message: e.toString().split(",")[1].trim());
    }
  }

  // TODO: sign out user
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // TODO: reset password
  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // TODO: stream firebase
  static Stream<auth.FirebaseUser> get userStream => _auth.onAuthStateChanged;
}

class SignInSignUpResult {
  final User user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
