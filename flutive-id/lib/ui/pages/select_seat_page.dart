import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/shared/shared_value.dart';
import '/ui/widgets/selectable_box.dart';
import '/theme.dart';
import '/bloc/page_bloc.dart';
import '/model/ticket.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  SelectSeatPage(this.ticket);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  // TODO: Properties kelas
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context
            .read<PageBloc>()
            .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: mainColor),
            SafeArea(
              child: Container(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 60),
                  header(),
                  const SizedBox(height: 40),
                  cinemaScreen(),
                  const SizedBox(height: 10),
                  seats(),
                  const SizedBox(height: 30),
                  keteranganSeat(),
                  const SizedBox(height: 40),
                  buttonNext(),
                  const SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget header() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // TODO: Icon Back
          IconButton(
            onPressed: () {
              context
                  .read<PageBloc>()
                  .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
            },
            icon: Image.asset(
              "assets/icon/arrow_left_icon.png",
              height: 24,
              width: 24,
            ),
          ),
          // TODO: Title dan Gambar
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  widget.ticket.movieDetail.title,
                  style: blackRalewayMedium.copyWith(fontSize: 20, height: 1.4),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(width: 18),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 60,
                  height: 60,
                  child: Image.network(
                    imageKey + "w154" + widget.ticket.movieDetail.posterPath,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          )
        ],
      );

  Widget cinemaScreen() => Center(
        child: Container(
          width: 277,
          height: 84,
          child: Image.asset("assets/image/screen.png"),
        ),
      );

  Column seats() {
    List<int> numberOfSeats = [3, 5, 5, 5, 5];
    List<Widget> widget = [];

    for (int i = 0; i < numberOfSeats.length; i++) {
      widget.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          numberOfSeats[i],
          (index) => Padding(
              padding: EdgeInsets.only(
                right: index < numberOfSeats[i] - 1 ? 16 : 0,
                bottom: 16,
              ),

              // TODO: Generate textnya pake kode ascii
              child: SelectableBox(
                "${String.fromCharCode(i + 65)}${index + 1}",
                width: 40,
                height: 40,
                textStyle: blackOpenSansRegular.copyWith(fontSize: 16),
                isSelected: selectedSeats.contains(
                  "${String.fromCharCode(i + 65)}${index + 1}",
                ),
                onTap: () {
                  String seatNumber =
                      "${String.fromCharCode(i + 65)}${index + 1}";
                  setState(() {
                    if (selectedSeats.contains(seatNumber)) {
                      selectedSeats.remove(seatNumber);
                    } else {
                      selectedSeats.add(seatNumber);
                    }
                  });
                },
                isEnabled: index != 0,
              )),
        ),
      ));
    }

    return Column(
      children: widget,
    );
  }

  Widget keteranganSeat() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: grayColor)),
              ),
              const SizedBox(width: 8),
              Text(
                "Tersedia",
                style: blackRalewayRegular.copyWith(fontSize: 10),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: grayColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Dipesan",
                style: blackRalewayRegular.copyWith(fontSize: 10),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: yellowColor,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Dipilih",
                style: blackRalewayRegular.copyWith(fontSize: 10),
              ),
            ],
          )
        ],
      );

  Widget buttonNext() => Center(
        child: FloatingActionButton(
          onPressed: selectedSeats.length > 0
              ? () {
                  context
                      .read<PageBloc>()
                      .add(GoToCheckoutPage(widget.ticket.copyWith(
                        seats: selectedSeats,
                      )));
                }
              : null,
          elevation: 0,
          backgroundColor: selectedSeats.length > 0 ? mainColor : grayColor,
          child: Image.asset(
            "assets/icon/arrow_right_icon.png",
            width: 24,
            height: 24,
          ),
        ),
      );
}
