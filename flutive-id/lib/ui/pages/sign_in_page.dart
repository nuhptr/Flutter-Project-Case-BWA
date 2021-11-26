import 'package:another_flushbar/flushbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/model/register_user.dart';
import '/bloc/page_bloc.dart';
import '../../services/firebase/auth_services.dart';
import '/theme.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPage createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  // TODO: Properties class _LoginPage
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var isEmailValid = false;
  var isPasswordValid = false;
  var isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    // TODO: action ingin kembali ke splashpage
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSplashPage());
        return;
      },

      // TODO: tampilan utama
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  logo(),
                  const SizedBox(height: 60),
                  title(),
                  const SizedBox(height: 40),
                  inputEmail(),
                  const SizedBox(height: 25),
                  inputPassword(),
                  const SizedBox(height: 30),
                  textForgetPassword(),
                  const SizedBox(height: 50),
                  loginButton(),
                  const SizedBox(height: 50),
                  textRegisterUser(),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TODO: IMAGE
  Widget logo() => SizedBox(
        height: 74,
        width: 71,
        child: Image.asset("assets/image/logo.png"),
      );

  // TODO: TITLE
  Widget title() => Text(
        "Selamat Datang,\nMoviers!",
        style: blackRalewayMedium.copyWith(
            color: Colors.black, fontSize: 20, height: 1.4),
      );

  // TODO: WIDGET INPUT EMAIL
  Widget inputEmail() => TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (text) {
          setState(() {
            isEmailValid = EmailValidator.validate(text);
          });
        },
        style: blackRalewayMedium,
        controller: emailController,
        decoration: InputDecoration(
          errorStyle: blackRalewayRegular.copyWith(color: redColor),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: grayColor)),
          labelStyle: blackRalewayLight.copyWith(color: grayColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: "Google Email",
        ),
      );

  // TODO: WIDGET INPUT PASSWORD
  Widget inputPassword() => TextFormField(
        onChanged: (text) {
          setState(() {
            isPasswordValid = text.length >= 6;
          });
        },
        style: blackRalewayMedium,
        obscureText: true,
        controller: passwordController,
        decoration: InputDecoration(
          errorStyle: blackRalewayRegular.copyWith(color: redColor),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: grayColor)),
          labelStyle: blackRalewayLight.copyWith(color: grayColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: "password",
        ),
      );

  // TODO: FORGET PASSWORD
  Widget textForgetPassword() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Lupa Password?",
              style: blackRalewayRegular.copyWith(
                color: grayColor,
                fontSize: 14,
              )),
          SizedBox(width: 3),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Reset",
              style:
                  blackRalewayMedium.copyWith(color: orangeColor, fontSize: 14),
            ),
          )
        ],
      );

  // TODO: LOGIN FLOATING ACTION BUTTON
  Widget loginButton() => Center(
        child: Container(
          width: 50,
          height: 50,
          child: isSigningIn
              ? CircularProgressIndicator(
                  color: mainColor,
                )
              : FloatingActionButton(
                  elevation: 0,
                  onPressed: isEmailValid && isPasswordValid
                      ? () async {
                          setState(() {
                            isSigningIn = true;
                          });

                          var result = await AuthServices.signIn(
                              emailController.text, passwordController.text);

                          if (result.user == null) {
                            setState(() {
                              isSigningIn = false;
                            });

                            Flushbar(
                                backgroundColor: redColor,
                                flushbarPosition: FlushbarPosition.TOP,
                                message: result.message,
                                duration: Duration(seconds: 4))
                              ..show(context);
                          }
                        }
                      : null,
                  backgroundColor:
                      isEmailValid && isPasswordValid ? mainColor : grayColor,
                  child: Container(
                    width: 24,
                    height: 24,
                    child: Image.asset("assets/icon/arrow_right_icon.png"),
                  )),
        ),
      );

  // TODO: footer
  Widget textRegisterUser() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Baru gabung?",
              style: blackRalewayRegular.copyWith(
                color: grayColor,
                fontSize: 14,
              )),
          SizedBox(width: 3),
          GestureDetector(
            onTap: () {
              context
                  .read<PageBloc>()
                  .add(GotoRegistrationPage(RegisterUser()));
            },
            child: Text(
              "Daftar",
              style:
                  blackRalewayMedium.copyWith(color: orangeColor, fontSize: 14),
            ),
          )
        ],
      );
}
