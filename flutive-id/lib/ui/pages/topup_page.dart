import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/model/flutive_transaction.dart';
import '/bloc/user_bloc.dart';
import '/ui/widgets/money_card.dart';
import '/theme.dart';
import '/bloc/page_bloc.dart';
import '/extension/string_extension.dart';
import '/extension/date_time_extension.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent event;

  TopUpPage(this.event);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  var amountController = TextEditingController();
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.read<PageBloc>().add(widget.event);
          return;
        },
        child: Scaffold(
          backgroundColor: mainColor,
          body: SafeArea(
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 45),
                      header(context, widget.event),
                      const SizedBox(height: 30),
                      fieldAmount(),
                      const SizedBox(height: 30),
                      textTemplate(),
                      const SizedBox(height: 15),
                      templateAmount(),
                      const SizedBox(height: 100),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: buttonTopUp(),
                      ),
                      const SizedBox(height: 100)
                    ],
                  ),
                )),
          ),
        ));
  }

  // TODO: back button
  Widget header(BuildContext context, PageEvent event) => Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  context.read<PageBloc>().add(event);
                },
                icon: Image.asset(
                  "assets/icon/arrow_left_icon.png",
                  width: 24,
                  height: 24,
                )),
          ),
          const SizedBox(width: 75),
          Text(
            "Top Up",
            style: blackRalewayMedium.copyWith(fontSize: 20),
          )
        ],
      );

  Widget fieldAmount() {
    return TextFormField(
      onChanged: (text) {
        String temp = "";

        for (int i = 0; i < text.length; i++) {
          temp += text.isDigit(i) ? text[i] : " ";
        }

        setState(() {
          selectedAmount = int.tryParse(temp) ?? 0;
        });

        amountController.text = NumberFormat.currency(
          locale: "id_ID",
          symbol: "IDR ",
          decimalDigits: 0,
        ).format(selectedAmount);

        amountController.selection = TextSelection.fromPosition(
            TextPosition(offset: amountController.text.length));
      },
      keyboardType: TextInputType.number,
      controller: amountController,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: grayColor),
          ),
          labelText: "Amount",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: grayColor),
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: blackRalewayRegular.copyWith(
            fontSize: 14,
            color: grayColor,
          )),
    );
  }

  Widget textTemplate() => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Pilih berdasarkan template",
          style: blackRalewayMedium.copyWith(fontSize: 14),
        ),
      );

  Widget templateAmount() {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) / 3;

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        makeMoneyCard(
          amount: 50000,
          width: width,
        ),
        makeMoneyCard(
          amount: 100000,
          width: width,
        ),
        makeMoneyCard(
          amount: 150000,
          width: width,
        ),
        makeMoneyCard(
          amount: 200000,
          width: width,
        ),
        makeMoneyCard(
          amount: 250000,
          width: width,
        ),
        makeMoneyCard(
          amount: 300000,
          width: width,
        ),
        makeMoneyCard(
          amount: 500000,
          width: width,
        ),
        makeMoneyCard(
          amount: 1000000,
          width: width,
        ),
      ],
    );
  }

  MoneyCard makeMoneyCard({int amount, double width}) {
    return MoneyCard(
      amount: amount,
      width: width,
      isSelected: amount == selectedAmount,
      onTap: () {
        setState(() {
          if (selectedAmount != amount) {
            selectedAmount = amount;
          } else {
            selectedAmount = 0;
          }

          amountController.text = NumberFormat.currency(
            locale: "id_ID",
            symbol: "IDR ",
            decimalDigits: 0,
          ).format(selectedAmount);

          amountController.selection = TextSelection.fromPosition(
              TextPosition(offset: amountController.text.length));
        });
      },
    );
  }

  Widget buttonTopUp() {
    return SizedBox(
      width: 250,
      height: 50,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          return ElevatedButton(
            onPressed: (selectedAmount > 0)
                ? () {
                    context.read<PageBloc>().add(
                          GoToSuccessPage(
                            null,
                            FlutiveTransaction(
                                userId: (state as UserLoaded).user.id,
                                title: "Top up Dompetku",
                                amount: selectedAmount,
                                subtitle:
                                    "${DateTime.now().shortDayName}, ${DateTime.now().day} ${DateTime.now().monthName}, ${DateTime.now().year}",
                                time: DateTime.now()),
                          ),
                        );
                  }
                : null,
            child: Text(
              "Isi Dompet-ku",
              style: blackRalewayMedium.copyWith(
                fontSize: 16,
                color: (selectedAmount > 0) ? Colors.white : grayColor,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: mainColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }
}
