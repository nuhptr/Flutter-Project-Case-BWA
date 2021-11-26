import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '/shared/shared_value.dart';
import '/theme.dart';
import '/ui/widgets/rating_stars.dart';
import '/bloc/page_bloc.dart';
import '/model/ticket.dart';
import 'package:bwa_flutix/extension/date_time_extension.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  TicketDetailPage(this.ticket);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.read<PageBloc>().add(GoToMainPage());
          return;
        },
        child: Scaffold(
            backgroundColor: mainColor,
            body: SafeArea(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 40),
                      header(context),
                      const SizedBox(height: 40),
                      photoMovie(),
                      const SizedBox(height: 16),
                      titleMovie(),
                      const SizedBox(height: 10),
                      genreLanguage(),
                      const SizedBox(height: 10),
                      ratingStar(),
                      const SizedBox(height: 20),
                      cinemaName(),
                      const SizedBox(height: 10),
                      tanggal(),
                      const SizedBox(height: 10),
                      nomorKursi(),
                      const SizedBox(height: 10),
                      idOrder(),
                      const SizedBox(height: 20),
                      Divider(thickness: 1),
                      const SizedBox(height: 20),
                      footer(),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget header(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                context.read<PageBloc>().add(GoToMainPage());
              },
              icon: Image.asset(
                "assets/icon/arrow_left_icon.png",
                width: 24,
                height: 24,
              )),
          const SizedBox(width: 58),
          Text(
            "Detail Ticket",
            style: blackRalewayMedium.copyWith(fontSize: 20),
          )
        ],
      );

  Widget photoMovie() => ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: Container(
          width: 277,
          height: 170,
          child: Image.network(
            imageKey + "w1280" + ticket.movieDetail.posterPath,
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget titleMovie() => Container(
        child: Text(
          ticket.movieDetail.title,
          style: blackRalewayMedium.copyWith(fontSize: 18, height: 1.4),
          maxLines: 2,
        ),
      );

  Widget genreLanguage() => Text(
        ticket.movieDetail.genresAndLanguage,
        style: blackRalewayRegular.copyWith(fontSize: 12, color: grayColor),
      );

  Widget ratingStar() => RatingStars(
        voteAverage: ticket.movieDetail.voteAverage,
        starSize: 20,
        fontSize: 14,
        ratingColor: grayColor,
      );

  Widget cinemaName() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Cinema",
            style: blackRalewayRegular.copyWith(fontSize: 14, color: grayColor),
          ),
          Text(
            ticket.theater.name,
            style: blackOpenSansRegular.copyWith(fontSize: 14),
          ),
        ],
      );

  Widget tanggal() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Tanggal",
            style: blackRalewayRegular.copyWith(fontSize: 14, color: grayColor),
          ),
          Text(
            ticket.time.dateAndTime,
            style: blackOpenSansRegular.copyWith(fontSize: 14),
          ),
        ],
      );

  Widget nomorKursi() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Nomor Kursi",
            style: blackRalewayRegular.copyWith(fontSize: 14, color: grayColor),
          ),
          Text(
            ticket.seatsInString,
            style: blackOpenSansRegular.copyWith(fontSize: 14),
          ),
        ],
      );

  Widget idOrder() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ID Order",
            style: blackRalewayRegular.copyWith(fontSize: 14, color: grayColor),
          ),
          Text(
            ticket.bookingCode,
            style: blackOpenSansRegular.copyWith(fontSize: 14),
          ),
        ],
      );

  Widget footer() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama",
                style: blackRalewayRegular.copyWith(
                  fontSize: 14,
                  color: grayColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                ticket.name,
                style: blackOpenSansRegular.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "Terbayar",
                style: blackRalewayRegular.copyWith(
                  fontSize: 14,
                  color: grayColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Rp " + ticket.totalPrice.toString(),
                style: blackOpenSansRegular.copyWith(fontSize: 16),
              ),
            ],
          ),
          QrImage(
            data: ticket.bookingCode,
            version: QrVersions.auto,
            size: 100,
          ),
        ],
      );
}
