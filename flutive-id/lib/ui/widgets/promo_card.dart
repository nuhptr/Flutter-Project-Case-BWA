import 'package:flutter/material.dart';

import '/theme.dart';
import '/model/promo.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;

  PromoCard(this.promo);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TODO: CONTENT
        Container(
            height: 90,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: promoColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TODO: title dan subtitle
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promo.title,
                      style: blackRalewayRegular.copyWith(
                          fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      promo.subtitle,
                      style: blackRalewayLight.copyWith(
                          color: Colors.white.withOpacity(0.8), fontSize: 12),
                    )
                  ],
                ),
                // TODO: Discount
                Row(
                  children: [
                    Text(
                      "OFF",
                      style: blackOpenSansRegular.copyWith(
                          fontSize: 24, color: yellowColor.withOpacity(0.6)),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${promo.discount}%",
                      style: blackOpenSansSemiBold.copyWith(
                          fontSize: 24, color: yellowColor),
                    )
                  ],
                ),
              ],
            )),

        // TODO: HIASAN 1
        Align(
          alignment: Alignment.topRight,
          child: ShaderMask(
            shaderCallback: (rectangle) {
              return LinearGradient(
                      colors: [yellowColor, yellowColor.withOpacity(0.1)],
                      end: Alignment.topRight,
                      begin: Alignment.bottomLeft)
                  .createShader(Rect.fromLTRB(0, 0, 96, 45));
            },
            blendMode: BlendMode.dstIn,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
              ),
              child: Container(
                width: 150,
                height: 45,
                child: Image.asset(
                  "assets/image/reflection1.png",
                ),
              ),
            ),
          ),
        ),

        // TODO: HIASAN 2
        Align(
          alignment: Alignment.topRight,
          child: ShaderMask(
            shaderCallback: (rectangle) {
              return LinearGradient(
                      colors: [yellowColor, yellowColor.withOpacity(0.1)],
                      end: Alignment.centerRight,
                      begin: Alignment.centerLeft)
                  .createShader(Rect.fromLTRB(0, 0, 96, 45));
            },
            blendMode: BlendMode.dstIn,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
              ),
              child: Container(
                width: 170,
                height: 60,
                child: Image.asset(
                  "assets/image/reflection2.png",
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
