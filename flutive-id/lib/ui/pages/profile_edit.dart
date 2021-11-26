import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:bwa_flutix/services/firebase/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '/bloc/page_bloc.dart';
import '/shared/shared_method.dart';
import '/bloc/user_bloc.dart';
import '../../theme.dart';
import '/model/user.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // TODO: properties kelas
  var nameController = TextEditingController();
  String profilePath;
  bool isDataEdited = false;
  File profileImageFile;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    profilePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<PageBloc>().add(GoToProfilePage(widget.user));
        return;
      },
      child: Scaffold(
        backgroundColor: mainColor,
        body: SafeArea(
            child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                const SizedBox(height: 44),
                header(context),
                const SizedBox(height: 35),
                photoUser(),
                const SizedBox(height: 35),
                idUser(),
                const SizedBox(height: 20),
                emailUser(),
                const SizedBox(height: 20),
                nameUser(),
                const SizedBox(height: 30),
                buttonReset(context),
                const SizedBox(height: 20),
                buttonSave(context),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget header(BuildContext context) => BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  context
                      .read<PageBloc>()
                      .add(GoToProfilePage((state as UserLoaded).user));
                },
                icon: Image.asset(
                  "assets/icon/arrow_left_icon.png",
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 60),
              Text(
                "Edit Profile",
                style: blackRalewayMedium.copyWith(fontSize: 20),
              )
            ],
          );
        },
      );

  Widget photoUser() => Center(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Container(
                width: 100,
                height: 100,
                child: (profileImageFile != null)
                    ? FileImage(profileImageFile)
                    : (profilePath == "")
                        ? Image.network(widget.user.profilePicture,
                            fit: BoxFit.cover)
                        : Image.asset("assets/image/user_pic.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36, top: 80),
              child: GestureDetector(
                onTap: () async {
                  if (profilePath == "") {
                    File profileImageFile = await getImage();

                    if (profileImageFile != null) {
                      profilePath = basename(profileImageFile.path);
                    }
                  } else {
                    profileImageFile = null;
                    profilePath = "";
                  }

                  setState(() {
                    isDataEdited =
                        (nameController.text.trim() != widget.user.name ||
                                profilePath != widget.user.profilePicture)
                            ? true
                            : false;
                  });
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage((profilePath == "")
                              ? "assets/icon/add_photo_icon.png"
                              : "assets/icon/cancel_photo_icon.png"))),
                ),
              ),
            )
          ],
        ),
      );

  Widget idUser() => AbsorbPointer(
        child: TextFormField(
            controller: TextEditingController(text: widget.user.id),
            style: blackRalewayRegular.copyWith(fontSize: 16),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "User Id",
              labelStyle:
                  blackRalewayRegular.copyWith(fontSize: 16, color: grayColor),
            )),
      );

  Widget emailUser() => AbsorbPointer(
        child: TextFormField(
            controller: TextEditingController(text: widget.user.email),
            style: blackRalewayRegular.copyWith(fontSize: 16),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "Email User",
              labelStyle:
                  blackRalewayRegular.copyWith(fontSize: 16, color: grayColor),
            )),
      );

  Widget nameUser() => TextFormField(
      controller: nameController,
      onChanged: (text) {
        setState(() {
          isDataEdited = (text.trim() != widget.user.name ||
                  profilePath != widget.user.profilePicture)
              ? true
              : false;
        });
      },
      style: blackRalewayRegular.copyWith(fontSize: 16),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: grayColor),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Name",
        labelStyle:
            blackRalewayRegular.copyWith(fontSize: 16, color: grayColor),
      ));

  Widget buttonReset(BuildContext context) => Container(
        width: 250,
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: redColor),
            onPressed: (isUpdating)
                ? null
                : () async {
                    await AuthServices.resetPassword(widget.user.email);

                    Flushbar(
                      duration: Duration(milliseconds: 2000),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: greenColor,
                      message: "Reset Password Dikirim ke emailmu",
                    )..show(context);
                  },
            child: Text("Ubah Password",
                style: blackRalewayMedium.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                )),
          ),
        ),
      );

  Widget buttonSave(BuildContext context) => BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          return Container(
            width: 250,
            height: 45,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: mainColor),
                onPressed: (isDataEdited)
                    ? () async {
                        setState(() {
                          isUpdating = true;
                        });

                        if (profileImageFile != null) {
                          profilePath = await uploadImage(profileImageFile);
                        }

                        context.read<UserBloc>().add(UpdateData(
                            name: nameController.text,
                            uploadImage: profilePath));

                        context.read<PageBloc>().add(
                              GoToProfilePage((state as UserLoaded).user),
                            );
                      }
                    : null,
                child: Text("Simpan",
                    style: blackRalewayMedium.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    )),
              ),
            ),
          );
        },
      );
}
