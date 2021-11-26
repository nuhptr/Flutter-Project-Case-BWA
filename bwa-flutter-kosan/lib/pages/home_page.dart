import 'package:bwa_cozy/model/city.dart';
import 'package:bwa_cozy/model/space.dart';
import 'package:bwa_cozy/model/tips.dart';
import 'package:bwa_cozy/provider/space_provider.dart';

import 'package:bwa_cozy/theme.dart';

import 'package:bwa_cozy/widget/bottom_navbar_item.dart';
import 'package:bwa_cozy/widget/city_card.dart';
import 'package:bwa_cozy/widget/space_card.dart';
import 'package:bwa_cozy/widget/tips_card.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var spaceProvider = Provider.of<SpaceProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            SizedBox(height: edge),

            // todo: TITTLE / HEADER
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Jelajahi Sekarang',
                style: blackTextStyle.copyWith(fontSize: 24),
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Mencari kosan di berbagai kampus',
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 30),

            // todo: POPULAR CITIES
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Kota Populer',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 24),
                  // todo: menggunakan widget buatan CityCard
                  CityCard(
                    city: City(
                      id: 1,
                      name: 'Jakarta',
                      imageUrl: 'assets/city1.png',
                    ),
                  ),
                  SizedBox(width: 20),
                  CityCard(
                    city: City(
                      id: 2,
                      name: 'Lampung',
                      imageUrl: 'assets/city2.png',
                      isPopular: true,
                    ),
                  ),
                  SizedBox(width: 20),
                  CityCard(
                    city: City(
                      id: 3,
                      name: 'Bandung',
                      imageUrl: 'assets/city3.png',
                    ),
                  ),
                  SizedBox(width: 20),
                  CityCard(
                    city: City(
                      id: 4,
                      name: 'Palembang',
                      imageUrl: 'assets/city4.png',
                    ),
                  ),
                  SizedBox(width: 20),
                  CityCard(
                    city: City(
                      id: 5,
                      name: 'Aceh',
                      imageUrl: 'assets/city5.png',
                      isPopular: true,
                    ),
                  ),
                  SizedBox(width: 20),
                  CityCard(
                    city: City(
                      id: 6,
                      name: 'Bogor',
                      imageUrl: 'assets/city6.png',
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
            ),
            SizedBox(height: 30),

            // todo: RECOMMENDED SPACE
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Rekomendasi Kosan',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edge),
              // todo: future builder => widget pembangun asynchronous
              child: FutureBuilder(
                future: spaceProvider.getRecomendedSpace(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Space> data = snapshot.data as List<Space>;

                    int index = 0;

                    return Column(
                      children: data.map((item) {
                        index++;
                        return Container(
                          margin: EdgeInsets.only(top: index == 1 ? 0 : 30),
                          child: SpaceCard(item),
                        );
                      }).toList(),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            // todo: TIPS & GUIDANCE
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Tips dan Panduan',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edge),
              child: Column(
                children: [
                  // todo: menggunakan widget buatan TipsCard
                  TipsCard(
                    tips: Tips(
                        id: 1,
                        imageUrl: 'assets/tips1.png',
                        tittle: 'Panduan Kota',
                        updatedAt: '20 Apr 2021'),
                  ),
                  SizedBox(height: 20),
                  TipsCard(
                    tips: Tips(
                        id: 2,
                        imageUrl: 'assets/tips2.png',
                        tittle: 'Jakarta Fairship',
                        updatedAt: '11 Dec 2020'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),

      // todo: BottomNavigationbar
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - (2 * edge),
        height: 65,
        margin: EdgeInsets.symmetric(horizontal: edge),
        decoration: BoxDecoration(
          color: Color(0xfff6f7f8),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavbarItem(
              imageUrl: 'assets/icon_home.png',
              isActive: true,
            ),
            BottomNavbarItem(
              imageUrl: 'assets/icon_email.png',
              isActive: false,
            ),
            BottomNavbarItem(
              imageUrl: 'assets/icon_card.png',
              isActive: false,
            ),
            BottomNavbarItem(
              imageUrl: 'assets/icon_love.png',
              isActive: false,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
