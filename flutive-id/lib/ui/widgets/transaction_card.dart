import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/model/flutive_transaction.dart';
import '/theme.dart';
import '/shared/shared_value.dart';

class TransactionCard extends StatelessWidget {
  final FlutiveTransaction flutiveTransaction;
  final double width;

  TransactionCard(this.flutiveTransaction, this.width);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 90,
            width: 70,
            child: (flutiveTransaction.picture != null)
                ? Image.network(
                    imageKey + "w500" + flutiveTransaction.picture,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/image/top_up_image.png",
                  ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          children: [
            SizedBox(
              width: width - 86,
              child: Text(
                flutiveTransaction.title,
                style: blackRalewayMedium.copyWith(fontSize: 18, height: 1.4),
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: width - 86,
              child: Text(
                NumberFormat.currency(
                  locale: "id_ID",
                  decimalDigits: 0,
                  symbol: "IDR ",
                ).format(flutiveTransaction.amount < 0
                    ? -flutiveTransaction.amount
                    : flutiveTransaction.amount),
                style: blackOpenSansRegular.copyWith(
                  fontSize: 12,
                  color: flutiveTransaction.amount < 0 ? redColor : greenColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: width - 86,
              child: Text(
                flutiveTransaction.time.toString(),
                style: blackRalewayRegular.copyWith(
                    fontSize: 12, color: grayColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
