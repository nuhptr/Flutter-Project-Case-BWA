import 'package:airplane/shared/theme.dart';
import 'package:flutter/material.dart';

class SeatStatus extends StatelessWidget {
  SeatStatus({
    Key? key,
    required this.imageUrl,
    required this.status,
  }) : super(key: key);

  final String? status;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          margin: EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageUrl ?? ''),
            ),
          ),
        ),
        Text(
          status ?? '',
          style: blackTextStyle,
        )
      ],
    );
  }
}
