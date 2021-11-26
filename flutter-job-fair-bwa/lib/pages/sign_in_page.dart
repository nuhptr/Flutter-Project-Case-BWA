import 'package:bwa_flutter_jobs/models/user_model.dart';
import 'package:bwa_flutter_jobs/providers/auth_provider.dart';
import 'package:bwa_flutter_jobs/providers/user_provider.dart';
import 'package:bwa_flutter_jobs/theme.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var emailController = TextEditingController(text: '');
  var passwordController = TextEditingController(text: '');

  var isEmailValid = false;
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
            'Sign In',
            style: poppinsRegular.copyWith(
              fontSize: 16,
              color: titleColor,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            'Build Your Career',
            style: poppinsSemiBold.copyWith(
              fontSize: 24,
              color: headerColor,
            ),
          ),
        ],
      );
    }

    Widget image() {
      return Center(
        child: Container(
          width: 240,
          height: 260,
          margin: EdgeInsets.only(
            top: 30,
          ),
          child: Image.asset(
            'assets/bg_signin.png',
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
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
              height: 10,
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
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
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
              height: 10,
            ),
            Container(
              height: 45,
              child: TextFormField(
                style: poppinsMedium.copyWith(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                controller: passwordController,
                obscureText: true,
                obscuringCharacter: '*',
                decoration: formDecoration.copyWith(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: splashColorBg!,
                      )),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget buttonSignIn() {
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
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    showError('Semua Field Harus Diisi');
                  } else {
                    setState(() {
                      isLoading = true;
                    });

                    UserModel? user = await authProvider.login(
                      emailController.text,
                      passwordController.text,
                    );

                    setState(() {
                      isLoading = false;
                    });

                    if (user == null) {
                      showError('email atau password salah');
                    } else {
                      userProvider.user = user;
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false,
                      );
                    }
                  }
                },
                child: Text(
                  'Sign In',
                  style: poppinsMedium.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
      );
    }

    Widget buttonCreateAccount() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Center(
          child: TextButton(
            style: ButtonStyle(
              // TODO: ngilangin splash color
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/sign-up');
            },
            child: Text(
              'Create New Account',
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
        child: Container(
          padding: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                image(),
                emailInput(),
                passwordInput(),
                buttonSignIn(),
                buttonCreateAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
