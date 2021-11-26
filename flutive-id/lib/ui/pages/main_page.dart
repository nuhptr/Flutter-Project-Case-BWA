import 'package:flutter/material.dart';

import '/bloc/page_bloc.dart';
import '/ui/pages/topup_page.dart';
import '/theme.dart';
import 'movie_page.dart';
import 'ticket_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // TODO: properties class
  static int bottomNavBarIndex = 0;

  static List<Widget> _pageList = [
    MoviePage(),
    TopUpPage(GoToMainPage()),
    TicketPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: NAVBAR
      bottomNavigationBar: bottomNavBar(),
      body: _pageList[bottomNavBarIndex],
    );
  }

  // TODO: WIDGET NAVBAR
  Widget bottomNavBar() => BottomNavigationBar(
        elevation: 24.0,
        selectedItemColor: mainColor,
        unselectedItemColor: grayColor,
        unselectedLabelStyle: blackRalewayMedium.copyWith(fontSize: 12),
        selectedLabelStyle: blackRalewayMedium.copyWith(fontSize: 12),
        currentIndex: bottomNavBarIndex,
        onTap: (value) {
          setState(() {
            bottomNavBarIndex = value;
          });
        },
        backgroundColor: Colors.white,
        items: [
          // TODO: item 0 -> film
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 24,
                height: 18,

                // TODO: logic icon
                child: (bottomNavBarIndex == 0)
                    ? Image.asset('assets/icon/movie_icon.png')
                    : Image.asset('assets/icon/movie_gray_icon.png'),
              ),
            ),
            // TODO: logic title
            label: "Film",
          ),

          // TODO: item 1 -> unduh
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 24,
                height: 18,

                // TODO: logic icon
                child: (bottomNavBarIndex == 1)
                    ? Image.asset('assets/icon/unduh_icon.png')
                    : Image.asset('assets/icon/unduh_gray_icon.png'),
              ),
            ),
            label: "Top Up",
          ),

          // TODO: item 2 -> tiket
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 24,
                height: 18,
                child: (bottomNavBarIndex == 2)
                    ? Image.asset('assets/icon/ticket_icon.png')
                    : Image.asset('assets/icon/ticket_gray_icon.png'),
              ),
            ),
            label: "Tiket",
          ),
        ],
      );
}
