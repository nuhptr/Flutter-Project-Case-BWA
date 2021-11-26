import 'package:another_flushbar/flushbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/shared/shared_method.dart';
import '/bloc/page_bloc.dart';
import '/model/register_user.dart';
import '/theme.dart';

class SignUpPage extends StatefulWidget {
  // TODO: menyimpan data yang udah diisi
  final RegisterUser registerUser;

  SignUpPage(this.registerUser);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // TODO: buat controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var reTypePasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement controller akan menyesuaikan data registerUser
    super.initState();
    nameController.text = widget.registerUser.name;
    emailController.text = widget.registerUser.email;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: widget back akan ke -> yang dituju
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSplashPage());
        return;
      },

      // TODO: CONTENT
      child: SafeArea(
        child: Scaffold(
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    headerBackAndTitle(context),
                    const SizedBox(height: 10),
                    uploadPhoto(),
                    const SizedBox(height: 28),
                    formInputNama(),
                    const SizedBox(height: 20),
                    formInputEmail(),
                    const SizedBox(height: 20),
                    formInputPassword(),
                    const SizedBox(height: 20),
                    formKonfirmasiPassword(),
                    const SizedBox(height: 80),
                    buttonValidasiAndKePreference(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO: HEADER BACK AND TITLE
  Widget headerBackAndTitle(BuildContext context) => Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                context.read<PageBloc>().add(GoToSplashPage());
              },
              icon: Image.asset(
                "assets/icon/arrow_left_icon.png",
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(width: 70),
          // TODO: title
          Align(
            alignment: Alignment.center,
            child: Text("Buat Akun \nMovie Baru",
                textAlign: TextAlign.center,
                style: blackRalewayMedium.copyWith(
                  fontSize: 20,
                  color: mainColor,
                  height: 1.3,
                )),
          )
        ],
      );

  // TODO: UPLOAD PHOTO
  Widget uploadPhoto() => Center(
        child: Container(
          width: 90,
          height: 104,
          child: Stack(
            children: [
              Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.registerUser.profileImage == null)
                            ? AssetImage("assets/image/user_pic.png")
                                as ImageProvider
                            : FileImage(widget.registerUser.profileImage)),
                  )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () async {
                      // TODO: Action add photo
                      if (widget.registerUser.profileImage == null) {
                        widget.registerUser.profileImage = await getImage();
                      } else {
                        widget.registerUser.profileImage = null;
                      }

                      setState(() {});
                    },
                    child: Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                          (widget.registerUser.profileImage == null)
                              ? "assets/icon/add_photo_icon.png"
                              : "assets/icon/cancel_photo_icon.png",
                        )),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      );

  // TODO: FORM INPUT NAMA
  Widget formInputNama() => TextFormField(
        style: blackRalewayMedium,
        keyboardType: TextInputType.name,
        controller: nameController,
        decoration: InputDecoration(
          labelStyle:
              blackRalewayRegular.copyWith(fontSize: 14, color: grayColor),
          labelText: "Nama Lengkap",
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: grayColor)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

  // TODO: FORM EMAIL ADDRESS
  Widget formInputEmail() => TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      style: blackRalewayMedium,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: grayColor)),
        labelStyle: blackRalewayRegular.copyWith(
          fontSize: 14,
          color: grayColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Alamat Email",
      ));

  // TODO: FORM INPUT PASSWORD
  Widget formInputPassword() => TextFormField(
      controller: passwordController,
      style: blackRalewayMedium,
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: grayColor)),
        labelStyle: blackRalewayRegular.copyWith(
          fontSize: 14,
          color: grayColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Password",
      ));

  // TODO: FORM KONFIRMASI PASSWORD
  Widget formKonfirmasiPassword() => TextFormField(
      controller: reTypePasswordController,
      obscureText: true,
      style: blackRalewayMedium,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: grayColor)),
        labelStyle: blackRalewayRegular.copyWith(
          fontSize: 14,
          color: grayColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Konfirmasi Password",
      ));

  // TODO: VALIDASI BUTTON KE PREFERENCE PAGE
  Widget buttonValidasiAndKePreference() => Align(
      alignment: Alignment.center,
      child: FloatingActionButton(
        backgroundColor: mainColor,
        child: Image.asset(
          "assets/icon/arrow_right_icon.png",
          width: 24,
          height: 24,
        ),
        onPressed: () {
          // TODO: implement logic semua field harus keisi
          if (!(nameController.text.trim() != "" &&
              emailController.text.trim() != "" &&
              passwordController.text.trim() != "" &&
              reTypePasswordController.text.trim() != "")) {
            Flushbar(
                duration: Duration(milliseconds: 1500),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: redColor,
                message: "Isi semua field")
              ..show(context);
          }
          // TODO: password dan retype harus sama
          else if (passwordController.text != reTypePasswordController.text) {
            Flushbar(
                duration: Duration(milliseconds: 1500),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: redColor,
                message: "password tidak sama")
              ..show(context);
          }
          // TODO: password harus lebih dari 6
          else if (passwordController.text.length < 6) {
            Flushbar(
                duration: Duration(milliseconds: 1500),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: redColor,
                message: "password harus lebih dari 6")
              ..show(context);
          }
          // TODO: format email harus benar
          else if (!EmailValidator.validate(emailController.text)) {
            Flushbar(
                duration: Duration(milliseconds: 1500),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: redColor,
                message: "Format email tidak benar")
              ..show(context);
          }
          // TODO: data sudah benar
          else {
            widget.registerUser.name = nameController.text;
            widget.registerUser.email = emailController.text;
            widget.registerUser.password = passwordController.text;

            // TODO: goto preference page
            context
                .read<PageBloc>()
                .add(GoToPreferencePage(widget.registerUser));
          }
        },
        elevation: 0,
      ));
}
