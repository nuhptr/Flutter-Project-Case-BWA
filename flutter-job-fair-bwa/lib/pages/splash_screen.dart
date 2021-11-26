import 'dart:async';

import 'package:bwa_flutter_jobs/pages/onboarding_page.dart';
import 'package:bwa_flutter_jobs/theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoardingPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashColorBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 59,
              height: 76,
              child: Image.asset("assets/logo.png"),
            ),
            SizedBox(
              height: 50,
            ),
            Text('FUTURE JOB',
                style: poppinsSemiBold.copyWith(
                  fontSize: 32,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
