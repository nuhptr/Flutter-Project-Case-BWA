import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '/services/firebase/auth_services.dart';
import '/shared/shared_value.dart';
import '/theme.dart';
import '/bloc/page_bloc.dart';
import '/model/register_user.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegisterUser registerUser;

  AccountConfirmationPage(this.registerUser);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  // TODO: properties kelas
  bool isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToPreferencePage(widget.registerUser));
        return;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  header(),
                  const SizedBox(height: 60),
                  photo(),
                  const SizedBox(height: 50),
                  selamatDatang(),
                  const SizedBox(height: 10),
                  userRegister(),
                  const SizedBox(height: 80),
                  buttonConfirmation(),
                ],
              ),
            )),
      ),
    );
  }

  Widget header() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // TODO: button icon
          IconButton(
              onPressed: () {
                context
                    .read<PageBloc>()
                    .add(GoToPreferencePage(widget.registerUser));
              },
              icon: Image.asset(
                "assets/icon/arrow_left_icon.png",
                height: 24,
                width: 24,
              )),
          SizedBox(width: 70),
          // TODO: title
          Text(
            "Konfirmasi\nAkun Baru",
            style: blackRalewayMedium.copyWith(fontSize: 20),
          ),
        ],
      );

  // TODO: foto
  Widget photo() => Center(
        child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (widget.registerUser.profileImage == null)
                      ? AssetImage("assets/image/user_pic.png") as ImageProvider
                      : FileImage(widget.registerUser.profileImage)),
            )),
      );

  // TODO: TEXT SELAMAT DATANG
  Widget selamatDatang() => Text(
        "Selamat Datang",
        style: blackRalewayLight.copyWith(fontSize: 16),
      );

  // TODO: TEXT USER REGISTER
  Widget userRegister() => Text(
        widget.registerUser.name,
        style: blackRalewayMedium.copyWith(fontSize: 20),
      );

  // TODO: LOGIC BUTTON CONFIRMATION
  Widget buttonConfirmation() => (isSignUp)
      ? Container(
          child: CircularProgressIndicator(),
          height: 50,
          width: 50,
        )
      : Container(
          width: 250,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () async {
              setState(() {
                isSignUp = true;
              });

              // TODO: melempar data picture ke variabelw
              imageFileToUpload = widget.registerUser.profileImage;

              SignInSignUpResult result = await AuthServices.signUp(
                  widget.registerUser.email,
                  widget.registerUser.password,
                  widget.registerUser.name,
                  widget.registerUser.selectedGenres,
                  widget.registerUser.selectedLanguage);
              if (result.user == null) {
                setState(() {
                  isSignUp = false;
                });

                Flushbar(
                  duration: Duration(milliseconds: 1500),
                  backgroundColor: redColor,
                  flushbarPosition: FlushbarPosition.TOP,
                  message: result.message,
                )..show(context);
              }
            },
            child: Text("Buat Akun",
                style: blackRalewayMedium.copyWith(
                  fontSize: 16,
                )),
          ),
        );
}
