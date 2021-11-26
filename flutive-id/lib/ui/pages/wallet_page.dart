import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/ui/widgets/transaction_card.dart';
import '/model/flutive_transaction.dart';
import '/services/firebase/flutive_transaction_service.dart';
import '/bloc/user_bloc.dart';
import '/theme.dart';
import '/bloc/page_bloc.dart';

class WalletPage extends StatelessWidget {
  final PageEvent pageEvent;

  WalletPage(this.pageEvent);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<PageBloc>().add(pageEvent);
        return;
      },
      child: Scaffold(
        backgroundColor: mainColor,
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Stack(
                children: [
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 45),
                      header(context),
                      const SizedBox(height: 20),
                      dompetSection(context),
                      const SizedBox(height: 20),
                      textBaruBaruIni(),
                      const SizedBox(height: 20),
                      recentTransaction(),
                    ],
                  ),
                  Container(
                    child: buttonTopUp(context),
                    margin: EdgeInsets.only(bottom: 50),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TODO: back button
  Widget header(BuildContext context) => BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          return Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      context
                          .read<PageBloc>()
                          .add(GoToProfilePage((state as UserLoaded).user));
                    },
                    icon: Image.asset(
                      "assets/icon/arrow_left_icon.png",
                      width: 24,
                      height: 24,
                    )),
              ),
              const SizedBox(width: 65),
              Text(
                "Dompet-ku",
                style: blackRalewayMedium.copyWith(fontSize: 20),
              )
            ],
          );
        },
      );

  Widget dompetSection(BuildContext context) =>
      BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          return Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/bg_card.png"))),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 15),
                    child: Image.asset(
                      "assets/image/circle_image.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 70),
                    child: Text(
                      NumberFormat.currency(
                        locale: "id_ID",
                        symbol: "IDR ",
                        decimalDigits: 0,
                      ).format((state as UserLoaded).user.balance),
                      maxLines: 1,
                      style: blackOpenSansSemiBold.copyWith(
                          fontSize: 28, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 125),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pemilik",
                              style: blackRalewayLight.copyWith(
                                  fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width -
                                      2 * defaultMargin -
                                      220,
                                  child: Text(
                                    (state as UserLoaded).user.name,
                                    maxLines: 1,
                                    style: blackRalewayMedium.copyWith(
                                      fontSize: 14,
                                      height: 1.4,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 0),
                                Image.asset(
                                  "assets/icon/check_icon.png",
                                  width: 14,
                                  height: 14,
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ID Kartu",
                              style: blackRalewayLight.copyWith(
                                  fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width -
                                  2 * defaultMargin -
                                  200,
                              child: Text(
                                (state as UserLoaded).user.id,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: blackRalewayMedium.copyWith(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ));
        },
      );

  Widget textBaruBaruIni() => Padding(
        padding: EdgeInsets.only(left: 15),
        child: Text(
          "Transaksi Baru-baru Ini",
          style: blackRalewayMedium.copyWith(fontSize: 14),
        ),
      );

  Widget recentTransaction() => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return FutureBuilder(
              future: FlutiveTransactionService.getTransaction(
                  (state as UserLoaded).user.id),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: generateTransactionList(
                      snapshot.data,
                      MediaQuery.of(context).size.width -
                          2 * defaultMargin -
                          20,
                    ),
                  );
                } else {
                  return SizedBox();
                }
              });
        },
      );

  Column generateTransactionList(
      List<FlutiveTransaction> transaksi, double width) {
    transaksi.sort(
      (transaksi1, transaksi2) => transaksi2.time.compareTo(transaksi1.time),
    );

    return Column(
      children: transaksi
          .map(
            (e) => Container(
              margin: EdgeInsets.only(bottom: 15),
              child: TransactionCard(e, width),
            ),
          )
          .toList(),
    );
  }

  Widget buttonTopUp(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          backgroundColor: mainColor,
          child: Image.asset(
            "assets/icon/unduh_icon.png",
            width: 24,
            height: 24,
          ),
          onPressed: () {
            context
                .read<PageBloc>()
                .add(GoToTopUpPage(GoToWalletPage(pageEvent)));
          },
          elevation: 0,
        ),
      );
}
