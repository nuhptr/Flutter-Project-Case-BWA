import 'package:flutter/material.dart';

import '/theme.dart';
import '/extension/date_time_extension.dart';

class DateCard extends StatelessWidget {
  final bool isSelected;
  final double width;
  final double height;
  final DateTime date;
  final Function onTap;

  DateCard(
    this.date, {
    this.isSelected = false,
    this.width = 70,
    this.height = 90,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      // TODO: CARD
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isSelected ? yellowColor : Colors.transparent,
            border:
                Border.all(color: isSelected ? Colors.transparent : grayColor)),

        // MAIN CONTENT
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Nama Hari
            Text(
              date.shortDayName,
              style: blackRalewayRegular.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 6),
            // TODO: Tanggal
            Text(
              date.day.toString(),
              style: blackOpenSansRegular.copyWith(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
