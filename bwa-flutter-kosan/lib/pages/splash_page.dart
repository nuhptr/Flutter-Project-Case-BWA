import 'package:bwa_cozy/pages/home_page.dart';
import 'package:bwa_cozy/theme.dart';

import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        // todo: supaya bisa ditumpuk tampilannya
        child: Stack(
          children: [
            // todo: interface of splash screen
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/splash_image.png',
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Temukan Kosan\nNyaman untuk\nTinggal dan Belajar',
                    style: blackTextStyle.copyWith(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Stop membuang banyak waktu\npada tempat yang tidak habitable',
                    style:
                        greyTextStyle.copyWith(fontSize: 15, wordSpacing: 0.25),
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 50,
                    width: 210,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: purpleColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: Text(
                        'Lanjutkan',
                        style: whiteTextStyle.copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 23),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
