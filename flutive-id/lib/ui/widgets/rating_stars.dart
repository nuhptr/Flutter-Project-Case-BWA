import 'package:bwa_flutix/theme.dart';
import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;
  final Color ratingColor;

  const RatingStars(
      {this.voteAverage = 0,
      this.starSize = 14,
      this.fontSize = 12,
      this.ratingColor});

  @override
  Widget build(BuildContext context) {
    // TODO: jumlah bintang hidup karena vote nilainya sampe 10
    int n = (voteAverage / 2).round();

    // TODO: generate icons hidup
    List<Widget> widgets = List.generate(
        5,
        (index) => Icon(
              index < n ? Icons.star : Icons.star_border,
              color: yellowColor,
              size: starSize,
            ));

    widgets.add(SizedBox(
      width: 3,
    ));

    widgets.add(Text(
      "$voteAverage/10",
      style: blackOpenSansRegular.copyWith(
        fontSize: fontSize,
        color: ratingColor,
      ),
    ));

    return Row(
      children: widgets,
    );
  }
}
