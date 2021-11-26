import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/model/flutive_transaction.dart';
import '/bloc/user_bloc.dart';
import '/bloc/page_bloc.dart';
import '/shared/shared_value.dart';
import '/theme.dart';
import '/ui/widgets/rating_stars.dart';
import '/extension/date_time_extension.dart';
import '/model/ticket.dart';

class CheckOutPage extends StatefulWidget {
  final Ticket ticket;

  CheckOutPage(this.ticket);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          context.read<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
          return;
        },
        child: Scaffold(
            body: Stack(
          children: [
            Container(color: mainColor),
            SafeArea(
              child: Container(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 60),
                  header(),
                  const SizedBox(height: 20),
                  keteranganPoster(),
                  const SizedBox(height: 20),
                  Divider(thickness: 1),
                  const SizedBox(height: 20),
                  bookingId(),
                  const SizedBox(height: 10),
                  cinemaName(),
                  const SizedBox(height: 10),
                  tanggalPesan(),
                  const SizedBox(height: 10),
                  pilihanKursi(),
                  const SizedBox(height: 10),
                  hargaTiket(),
                  const SizedBox(height: 10),
                  biayaAdmin(),
                  const SizedBox(height: 10),
                  total(),
                  const SizedBox(height: 20),
                  Divider(thickness: 1),
                  const SizedBox(height: 20),
                  dompetUser(),
                  const SizedBox(height: 36),
                  buttonCheckout(),
                  const SizedBox(height: 50),
                ],
              ),
            )
          ],
        )));
  }

  // TODO: HEADER
  Widget header() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // TODO: Icon Back
          IconButton(
            onPressed: () {
              context.read<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
            },
            icon: Image.asset(
              "assets/icon/arrow_left_icon.png",
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(width: 70),
          Text(
            "Pembelian\nTiket",
            textAlign: TextAlign.center,
            style: blackRalewayMedium.copyWith(fontSize: 20, height: 1.4),
          )
        ],
      );

  // TODO: IMAGE DAN KETERANGAN POSTER
  Widget keteranganPoster() => Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
                imageKey + "w342" + widget.ticket.movieDetail.posterPath,
                height: 90,
                width: 70),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    2 * defaultMargin -
                    70 -
                    20,
                child: Text(
                  widget.ticket.movieDetail.title,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: blackRalewayMedium.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    2 * defaultMargin -
                    70 -
                    20,
                child: Text(
                  widget.ticket.movieDetail.genresAndLanguage,
                  style: blackRalewayRegular.copyWith(
                      fontSize: 12, color: grayColor),
                ),
              ),
              const SizedBox(height: 8),
              RatingStars(
                voteAverage: widget.ticket.movieDetail.voteAverage,
                starSize: 20,
                ratingColor: grayColor,
                fontSize: 14,
              )
            ],
          )
        ],
      );

  // TODO: TEXT BOOKINGID DAN IDNYA
  Widget bookingId() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ID Order",
            style: blackRalewayRegular.copyWith(fontSize: 16, color: grayColor),
          ),
          Text(
            widget.ticket.bookingCode,
            style: blackOpenSansRegular.copyWith(fontSize: 16),
          )
        ],
      );

  // TODO: TEXT CINEMA DAN NAMENYA
  Widget cinemaName() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Cinema",
            style: blackRalewayRegular.copyWith(fontSize: 16, color: grayColor),
          ),
          Text(
            widget.ticket.theater.name,
            style: blackOpenSansRegular.copyWith(fontSize: 16),
          )
        ],
      );

  // TODO: TEXT TANGGAL DAN TANGGALNYA
  Widget tanggalPesan() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Tanggal",
            style: blackRalewayRegular.copyWith(fontSize: 16, color: grayColor),
          ),
          Text(
            widget.ticket.time.dateAndTime,
            style: blackOpenSansRegular.copyWith(fontSize: 16),
          )
        ],
      );

  // TODO: TEXT KURSI DAN PILIHAN KURSI
  Widget pilihanKursi() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Kursi",
            style: blackRalewayRegular.copyWith(fontSize: 16, color: grayColor),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Text(
              widget.ticket.seatsInString,
              textAlign: TextAlign.end,
              style: blackOpenSansRegular.copyWith(fontSize: 16),
            ),
          )
        ],
      );

  // TODO: TEXT HARGA DAN HARGANYA
  Widget hargaTiket() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Harga",
            style: blackRalewayRegular.copyWith(fontSize: 16, color: grayColor),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Text(
              "IDR 25.000 x ${widget.ticket.seats.length}",
              textAlign: TextAlign.end,
              style: blackOpenSansRegular.copyWith(fontSize: 16),
            ),
          )
        ],
      );

  // TODO: TEXT BIAYA ADMIN DAN BIAYANYA
  Widget biayaAdmin() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Biaya Admin",
            style: blackRalewayRegular.copyWith(fontSize: 16, color: grayColor),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Text(
              "IDR 1.500 x ${widget.ticket.seats.length}",
              textAlign: TextAlign.end,
              style: blackOpenSansRegular.copyWith(fontSize: 16),
            ),
          )
        ],
      );

  // TODO: TEXT TOTAL DAN BIAYA TOTAL
  Widget total() {
    int total = 26500 * widget.ticket.seats.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Total",
          style: blackRalewayRegular.copyWith(fontSize: 16, color: grayColor),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
          child: Text(
            NumberFormat.currency(
              locale: "id_ID",
              decimalDigits: 0,
              symbol: "IDR ",
            ).format(total),
            textAlign: TextAlign.end,
            style: blackOpenSansRegular.copyWith(
              fontSize: 16,
              color: redColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  // TODO: TEXT DOMPETKU DAN BALANCENYA
  Widget dompetUser() => BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          int total = 26500 * widget.ticket.seats.length;
          var user = (state as UserLoaded).user;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dompet-mu",
                style: blackRalewayRegular.copyWith(
                    fontSize: 16, color: grayColor),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Text(
                  NumberFormat.currency(
                    locale: "id_ID",
                    symbol: "IDR ",
                    decimalDigits: 0,
                  ).format(user.balance),
                  textAlign: TextAlign.end,
                  style: blackOpenSansRegular.copyWith(
                    fontSize: 16,
                    color: user.balance >= total ? greenColor : redColor,
                  ),
                ),
              )
            ],
          );
        },
      );

  Widget buttonCheckout() => BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          var user = (state as UserLoaded).user;
          int total = 26500 * widget.ticket.seats.length;

          return Center(
            child: Container(
                width: 250,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: user.balance >= total ? mainColor : yellowColor,
                  ),
                  child: Text(
                    (user.balance >= total)
                        ? "Beli Ticket"
                        : "Top Up Dompet-mu",
                    style: user.balance >= total
                        ? blackRalewayMedium.copyWith(
                            fontSize: 16, color: Colors.white)
                        : blackRalewayMedium.copyWith(fontSize: 16),
                  ),
                  onPressed: () {
                    // TODO: uang cukup
                    if (user.balance >= total) {
                      var transaction = FlutiveTransaction(
                          userId: user.id,
                          title: widget.ticket.movieDetail.title,
                          subtitle: widget.ticket.theater.name,
                          time: DateTime.now(),
                          amount: -total,
                          picture: widget.ticket.movieDetail.posterPath);

                      // TODO: lempar data
                      context.read<PageBloc>().add(GoToSuccessPage(
                            widget.ticket.copyWith(totalPrice: total),
                            transaction,
                          ));
                    } else {
                      // TODO: uang kurang
                      if (user.balance <= total) {
                        Flushbar(
                          message: "Saldo Tidak Cukup, Yuk Top-Up",
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: redColor,
                          duration: Duration(seconds: 4),
                        )..show(context);
                      }
                    }
                  },
                )),
          );
        },
      );
}
