import 'dart:io';

class RegisterUser {
  String name;
  String email;
  String password;
  List<String> selectedGenres;
  String selectedLanguage;
  File profileImage;

  RegisterUser({
    this.name = "",
    this.email = "",
    this.password = "",
    this.profileImage,
    this.selectedGenres = const [],
    this.selectedLanguage = "",
  });
}
