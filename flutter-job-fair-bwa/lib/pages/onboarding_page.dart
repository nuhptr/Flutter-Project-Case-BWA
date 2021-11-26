import 'package:bwa_flutter_jobs/theme.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget image() {
      return Container(
          decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.png'),
          fit: BoxFit.cover,
        ),
      ));
    }

    Widget body() {
      return Padding(
        padding: EdgeInsets.only(left: 30, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text('Build Your Next\nFuture Career Like\na Master',
                    style: poppinsRegular.copyWith(
                      color: Colors.white,
                      fontSize: 32,
                    ))),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                '18.000 jobs available',
                style: poppinsLight.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                width: 200,
                height: 45,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(66),
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign-up");
                  },
                  child: Text(
                    'Get Started',
                    style: poppinsMedium.copyWith(
                      fontSize: 14,
                      color: splashColorBg,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Container(
                width: 200,
                height: 45,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(66),
                    ),
                    side: BorderSide(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign-in');
                  },
                  child: Text(
                    'Sign In',
                    style: poppinsMedium.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      );
    }

    return Scaffold(
        body: Stack(
      children: [
        image(),
        body(),
      ],
    ));
  }
}
