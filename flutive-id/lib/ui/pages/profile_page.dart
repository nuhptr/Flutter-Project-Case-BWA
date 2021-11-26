import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/user_bloc.dart';
import '/services/firebase/auth_services.dart';
import '../../theme.dart';
import '/model/user.dart';
import '/bloc/page_bloc.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage(this.user);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        backgroundColor: mainColor,
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 45),
                  backButton(context),
                  const SizedBox(height: 30),
                  photoUser(),
                  const SizedBox(height: 20),
                  nameUser(),
                  const SizedBox(height: 10),
                  emailUser(),
                  const SizedBox(height: 30),
                  editProfileUser(context),
                  const SizedBox(height: 12),
                  Divider(thickness: 1),
                  const SizedBox(height: 20),
                  dompetKu(context),
                  const SizedBox(height: 12),
                  Divider(thickness: 1),
                  const SizedBox(height: 20),
                  ubahBahasa(),
                  const SizedBox(height: 12),
                  Divider(thickness: 1),
                  const SizedBox(height: 20),
                  pusatBantuan(),
                  const SizedBox(height: 12),
                  Divider(thickness: 1),
                  const SizedBox(height: 20),
                  ratingApp(),
                  const SizedBox(height: 12),
                  Divider(thickness: 1),
                  const SizedBox(height: 20),
                  logOut(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TODO: back button
  Widget backButton(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
            onPressed: () {
              context.read<PageBloc>().add(GoToMainPage());
            },
            icon: Image.asset(
              "assets/icon/arrow_left_icon.png",
              width: 24,
              height: 24,
            )),
      );

  Widget photoUser() => Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 120,
            height: 120,
            child: Image.network(
              user.profilePicture,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  Widget nameUser() => Center(
        child: Text(
          user.name,
          style: blackRalewayMedium.copyWith(fontSize: 18),
        ),
      );

  Widget emailUser() => Center(
        child: Text(
          user.email,
          style: blackRalewayLight.copyWith(fontSize: 16, color: grayColor),
        ),
      );

  Widget editProfileUser(BuildContext context) =>
      BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          return GestureDetector(
            onTap: () {
              context
                  .read<PageBloc>()
                  .add(GoToEditProfilePage((state as UserLoaded).user));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icon/account_icon_outlined.png",
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  "Edit Profile",
                  style: blackRalewayMedium.copyWith(fontSize: 16),
                ),
              ],
            ),
          );
        },
      );

  Widget dompetKu(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
      return GestureDetector(
        onTap: () {
          context.read<PageBloc>().add(GoToWalletPage(
                GoToProfilePage((state as UserLoaded).user),
              ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icon/balance_icon_outlined.png",
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 10),
            Text(
              "Dompet-ku",
              style: blackRalewayMedium.copyWith(fontSize: 16),
            ),
          ],
        ),
      );
    });
  }

  Widget ubahBahasa() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/icon/language_icon_outlined.png",
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 10),
          Text(
            "Ubah Bahasa",
            style: blackRalewayMedium.copyWith(fontSize: 16),
          ),
        ],
      );

  Widget pusatBantuan() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/icon/verified_icon_outlined.png",
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 10),
          Text(
            "Pusat Bantuan",
            style: blackRalewayMedium.copyWith(fontSize: 16),
          ),
        ],
      );

  Widget ratingApp() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/icon/like_icon_outlined.png",
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 10),
          Text(
            "Rating Flutive ID",
            style: blackRalewayMedium.copyWith(fontSize: 16),
          ),
        ],
      );

  Widget logOut(BuildContext context) => GestureDetector(
        onTap: () {
          context.read<UserBloc>().add(SignOut());
          AuthServices.signOut();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icon/cancel_photo_icon.png",
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 10),
            Text(
              "Log Out",
              style: blackRalewayMedium.copyWith(fontSize: 16),
            ),
          ],
        ),
      );
}
