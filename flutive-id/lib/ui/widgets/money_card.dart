import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme.dart';

class MoneyCard extends StatelessWidget {
  final double width;
  final bool isSelected;
  final int amount;
  final Function onTap;

  MoneyCard({
    this.width = 90,
    this.isSelected = false,
    this.amount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        (onTap != null) ? onTap() : null;
      },
      child: Container(
          width: width,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border:
                Border.all(color: isSelected ? Colors.transparent : grayColor),
            color: isSelected ? yellowColor : Colors.transparent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "IDR",
                style: blackRalewayRegular.copyWith(
                    fontSize: 16, color: grayColor),
              ),
              const SizedBox(height: 5),
              Text(
                NumberFormat.currency(
                  locale: "id_ID",
                  symbol: "",
                  decimalDigits: 0,
                ).format(amount),
                style: blackOpenSansRegular.copyWith(fontSize: 16),
              )
            ],
          )),
    );
  }
}
