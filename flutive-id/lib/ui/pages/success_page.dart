import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/page_bloc.dart';
import '/bloc/ticket_bloc.dart';
import '/bloc/user_bloc.dart';
import '/model/flutive_transaction.dart';
import '/model/ticket.dart';
import '/services/firebase/flutive_transaction_service.dart';
import '/theme.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutiveTransaction flutiveTransaction;

  SuccessPage(this.ticket, this.flutiveTransaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          context.read<PageBloc>().add(GoToCheckoutPage(ticket));
          return;
        },
        child: Scaffold(
          body: FutureBuilder(
            future: ticket != null
                ? processingTicketOrder(context)
                : processingTopUp(context),
            builder: (_, snapshot) =>
                (snapshot.connectionState == ConnectionState.done)
                    ? successWidget(context)
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
          ),
        ));
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    context.read<UserBloc>().add(Purchase(ticket.totalPrice));
    context
        .read<TicketBloc>()
        .add(BuyTicket(flutiveTransaction.userId, ticket));

    await FlutiveTransactionService.saveTransaction(flutiveTransaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    context.read<UserBloc>().add(TopUp(flutiveTransaction.amount));

    await FlutiveTransactionService.saveTransaction(flutiveTransaction);
  }

  Widget successWidget(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 110),
          Container(
              height: 150,
              width: 150,
              child: Image.asset(
                (ticket != null)
                    ? "assets/image/succes_image.png"
                    : "assets/image/top_up_image.png",
              )),
          const SizedBox(height: 70),
          Text(
            (ticket == null) ? "Top Up Berhasil" : "Selamat Menonton",
            style: blackRalewayMedium.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 16),
          Text(
            (ticket == null)
                ? "Kamu sudah berhasil\nmelakukan Top-Up"
                : "Kamu berhasil membeli\nticket",
            style: blackRalewayLight.copyWith(fontSize: 16, color: grayColor),
          ),
          const SizedBox(height: 70),
          Container(
            width: 250,
            height: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: mainColor),
                  onPressed: () {
                    if (ticket == null) {
                      context
                          .read<PageBloc>()
                          .add(GoToWalletPage(GoToMainPage()));
                    } else {
                      context.read<PageBloc>().add(GoToTicketPage());
                    }
                  },
                  child: Text((ticket == null) ? "Dompet-ku" : "Ticket-ku",
                      style: blackRalewayMedium.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ))),
            ),
          ),
          const SizedBox(height: 90),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Cari Film Baru?",
                  style: blackRalewayRegular.copyWith(
                    fontSize: 14,
                    color: grayColor,
                  )),
              const SizedBox(width: 3),
              GestureDetector(
                  onTap: () {
                    context.read<PageBloc>().add(GoToMainPage());
                  },
                  child: Text(
                    "Home",
                    style: blackRalewayRegular.copyWith(
                      fontSize: 14,
                      color: orangeColor,
                    ),
                  ))
            ],
          )
        ],
      );
}
