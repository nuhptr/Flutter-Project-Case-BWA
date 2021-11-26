import 'package:bwa_flutter_jobs/models/user_model.dart';
import 'package:bwa_flutter_jobs/providers/auth_provider.dart';
import 'package:bwa_flutter_jobs/providers/user_provider.dart';
import 'package:bwa_flutter_jobs/theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var nameController = TextEditingController(text: '');
  var emailController = TextEditingController(text: '');
  var passwordController = TextEditingController(text: '');
  var yourGoalController = TextEditingController(text: '');

  var isEmailValid = false;
  var isUploaded = false;
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    // TODO: function show error
    void showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade300,
      ));
    }

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Sign Up',
            style: poppinsRegular.copyWith(
              color: titleColor,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            'Begin New Journey',
            style: poppinsSemiBold.copyWith(
              fontSize: 24,
              color: headerColor,
            ),
          )
        ],
      );
    }

    Widget uploadImage() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xff2A327D),
                    )),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isUploaded = !isUploaded;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: isUploaded
                        ? Image.asset('assets/image_profile.png')
                        : Image.asset('assets/icon_upload.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
              style: poppinsRegular.copyWith(
                fontSize: 16,
                color: titleColor,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 45,
              child: TextFormField(
                controller: nameController,
                onChanged: (value) {
                  // TODO: state email valid atau nggak
                  setState(() {
                    isEmailValid = EmailValidator.validate(value);
                  });
                },
                style: poppinsMedium.copyWith(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                decoration: formDecoration.copyWith(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: splashColorBg!,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style: poppinsRegular.copyWith(
                fontSize: 16,
                color: titleColor,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 45,
              child: TextFormField(
                controller: emailController,
                onChanged: (value) {
                  // TODO: state email valid atau nggak
                  setState(() {
                    isEmailValid = EmailValidator.validate(value);
                  });
                },
                style: poppinsMedium.copyWith(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: formDecoration.copyWith(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color:
                            isEmailValid ? splashColorBg! : Colors.red.shade300,
                      )),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: poppinsRegular.copyWith(
                fontSize: 16,
                color: titleColor,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 45,
              child: TextFormField(
                controller: passwordController,
                style: poppinsMedium.copyWith(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                obscureText: true,
                obscuringCharacter: '*',
                decoration: formDecoration.copyWith(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: splashColorBg!,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget yourGoalInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Goal',
              style: poppinsRegular.copyWith(
                fontSize: 16,
                color: titleColor,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 45,
              child: TextFormField(
                controller: yourGoalController,
                style: poppinsMedium.copyWith(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                decoration: formDecoration.copyWith(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: splashColorBg!,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget buttonSignUp() {
      return Container(
        margin: EdgeInsets.only(top: 40),
        width: double.infinity,
        height: 50,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: splashColorBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(66),
                    )),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  UserModel? user = await authProvider.register(
                      emailController.text,
                      nameController.text,
                      passwordController.text,
                      yourGoalController.text);

                  if (user == null) {
                    showError('Email Sudah Terdaftar');
                  } else {
                    userProvider.user = user;
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  }

                  setState(() {
                    isLoading = false;
                  });
                },
                child: Text(
                  'Sign Up',
                  style: poppinsMedium.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
      );
    }

    Widget buttonBackToSignIn() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Center(
          child: TextButton(
            style: ButtonStyle(
              // TODO: ngilangin splash color
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/sign-in');
            },
            child: Text(
              'Back To Sign In',
              style: poppinsMedium.copyWith(
                color: titleColor,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              uploadImage(),
              nameInput(),
              emailInput(),
              passwordInput(),
              yourGoalInput(),
              buttonSignUp(),
              buttonBackToSignIn(),
            ],
          ),
        ),
      ),
    );
  }
}
