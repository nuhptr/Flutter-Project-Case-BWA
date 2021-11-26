import 'package:bwa_flutix/bloc/page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/ticket_bloc.dart';
import '/shared/shared_value.dart';
import '/theme.dart';
import '/model/ticket.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTicket = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
          body: Stack(
        children: [
          Container(color: mainColor),
          SafeArea(
              child: Container(
            color: Colors.white,
          )),
          const SizedBox(height: 44),
          Container(
            margin: EdgeInsets.only(top: 70),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: textTicketKu(),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            margin: EdgeInsets.only(top: 130),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: tabBarTicket(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 157),
            child: ticketViewer(),
          ),
        ],
      )),
    );
  }

  Widget textTicketKu() => Text(
        "Ticket-ku",
        style: blackRalewayMedium.copyWith(fontSize: 20),
      );

  Widget tabBarTicket() => GestureDetector(
        onTap: () {
          setState(() {
            isExpiredTicket = !isExpiredTicket;
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  height: 34,
                  child: Text(
                    "Terbaru",
                    style: blackRalewayMedium.copyWith(
                      fontSize: 16,
                      color: !isExpiredTicket ? mainColor : grayColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 4,
                    width: MediaQuery.of(context).size.width / 2 - 50,
                    color: !isExpiredTicket ? yellowColor : Colors.transparent,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 50,
                  height: 34,
                  child: Text(
                    "Lama",
                    style: blackRalewayMedium.copyWith(
                      fontSize: 16,
                      color: !isExpiredTicket ? grayColor : mainColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 4,
                    width: MediaQuery.of(context).size.width / 2 - 50,
                    color: !isExpiredTicket ? Colors.transparent : yellowColor,
                  ),
                ),
              ],
            )
          ],
        ),
      );

  Widget ticketViewer() => BlocBuilder<TicketBloc, TicketState>(
        builder: (_, state) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: CheckTicket(isExpiredTicket
                ? state.tickets
                    .where((ticket) => ticket.time.isBefore(DateTime.now()))
                    .toList()
                : state.tickets
                    .where((ticket) => !ticket.time.isBefore(DateTime.now()))
                    .toList()),
          );
        },
      );
}

class CheckTicket extends StatelessWidget {
  final List<Ticket> ticket;

  CheckTicket(this.ticket);

  @override
  Widget build(BuildContext context) {
    var sortedTicket = ticket;
    sortedTicket.sort(
      (ticket1, ticket2) => ticket1.time.compareTo(ticket2.time),
    );

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: sortedTicket.length,
      itemBuilder: (_, index) => GestureDetector(
        onTap: () {
          context
              .read<PageBloc>()
              .add(GoToTicketDetailPage(sortedTicket[index]));
        },
        child: Container(
            margin: EdgeInsets.only(top: index == 0 ? defaultMargin : 20),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageKey +
                          "w500" +
                          sortedTicket[index].movieDetail.posterPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      2 * defaultMargin -
                      70 -
                      16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sortedTicket[index].movieDetail.title,
                        maxLines: 2,
                        style: blackRalewayMedium.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        sortedTicket[index].movieDetail.genresAndLanguage,
                        style: blackRalewayRegular.copyWith(
                          fontSize: 12,
                          color: grayColor,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        sortedTicket[index].theater.name,
                        style: blackRalewayRegular.copyWith(
                          fontSize: 12,
                          color: grayColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
