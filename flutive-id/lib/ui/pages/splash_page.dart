import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/model/register_user.dart';
import '/bloc/page_bloc.dart';
import '/theme.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              headerImage(),
              const SizedBox(height: 70),
              textPengalamanBaru(),
              const SizedBox(height: 16),
              textSubtitle(),
              const SizedBox(height: 70),
              buttonMasuk(context),
              const SizedBox(height: 55),
              footerSignIn(context),
            ],
          ),
        ),
      ),
    );
  }

  // TODO: IMAGE
  Widget headerImage() => Container(
        height: 136,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/image/logo.png"),
        )),
      );

  // TODO: TEXT PENGALAMAN BARU
  Widget textPengalamanBaru() => Text(
        "Pengalaman Baru",
        style: blackRalewayMedium.copyWith(color: Colors.black, fontSize: 20),
      );

  // TODO: TEXT SUBTITLE
  Widget textSubtitle() => Text(
        "Menonton Film Baru\n lebih mudah dari sebelumnya",
        textAlign: TextAlign.center,
        style: blackRalewayLight.copyWith(
            color: grayColor, fontSize: 16, height: 1.4),
      );

  // TODO: BUTTON MASUK
  Widget buttonMasuk(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 250,
          height: 46,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: mainColor),
              onPressed: () {
                context
                    .read<PageBloc>()
                    .add(GotoRegistrationPage(RegisterUser()));
              },
              child: Text(
                "Mulai",
                style: blackRalewayMedium.copyWith(fontSize: 16),
              )),
        ),
      );

  // TODO: footer
  Widget footerSignIn(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "sudah ada akun?",
            style: blackRalewayRegular.copyWith(color: grayColor, fontSize: 14),
          ),
          const SizedBox(width: 3),
          GestureDetector(
            onTap: () {
              context.read<PageBloc>().add(GoToSignInPage());
            },
            child: Text(
              'Masuk',
              style: blackRalewayMedium.copyWith(
                color: orangeColor,
                fontSize: 14,
              ),
            ),
          )
        ],
      );
}
