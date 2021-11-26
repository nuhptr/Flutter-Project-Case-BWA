import 'package:bwa_cozy/model/space.dart';
import 'package:bwa_cozy/pages/detail_page.dart';

import 'package:flutter/material.dart';

import '../theme.dart';

class SpaceCard extends StatelessWidget {
  // todo: kita panggil kelas modelnya
  final Space space;

  SpaceCard(this.space);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(space),
          ),
        );
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: 130,
              height: 110,
              child: Stack(
                children: [
                  Image.network(
                    space.imageUrl!,
                    width: 130,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: purpleColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                          )),
                      width: 70,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icon_star.png',
                            width: 22,
                            height: 22,
                          ),
                          Text(
                            '${space.rating}/5',
                            style: whiteTextStyle.copyWith(fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          FittedBox(
            fit: BoxFit.contain,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  space.name!,
                  style: blackTextStyle.copyWith(fontSize: 18),
                ),
                SizedBox(height: 2),
                Text.rich(
                  TextSpan(
                    text: '\$ ${space.price} ',
                    style: purpleTextStyle.copyWith(fontSize: 16),
                    children: [
                      TextSpan(
                        text: '/ month',
                        style: greyTextStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '${space.city}, ${space.country}',
                  style: greyTextStyle.copyWith(fontSize: 14),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
