import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '/bloc/user_bloc.dart';
import '/model/ticket.dart';
import '/model/theater.dart';
import '/ui/widgets/selectable_box.dart';
import '/theme.dart';
import '/ui/widgets/date_card.dart';
import '/bloc/page_bloc.dart';
import '/model/movie_detail.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;

  SelectSchedulePage(this.movieDetail);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  // TODO: PROPERTIES KELAS
  List<DateTime> dates;
  DateTime selectedDate;
  int selectedTime;
  Theater selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    dates = List.generate(
      7,
      (index) => DateTime.now().add(Duration(days: index)),
    );
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: BACK SWAP
    return WillPopScope(
        onWillPop: () {
          context.read<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));
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
                    buttonBack(context),
                    const SizedBox(height: 20),
                    textDay(),
                    const SizedBox(height: 16),
                    listDate(),
                    const SizedBox(height: defaultMargin),
                    generateTimeTable(),
                    const SizedBox(height: 30),
                    buttonPilihBangku(context),
                    const SizedBox(height: 50)
                  ],
                ),
              )
            ],
          ),
        ));
  }

  // TODO: BUTTON BACK
  Widget buttonBack(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context
                  .read<PageBloc>()
                  .add(GoToMovieDetailPage(widget.movieDetail));
            },
            child: Image.asset(
              "assets/icon/arrow_left_icon.png",
              height: 24,
              width: 24,
            ),
          ),
        ],
      );

  // TODO: PILIH TANGGAL
  Widget textDay() => Text(
        "Pilih Tanggal",
        style: blackRalewayMedium.copyWith(fontSize: 20),
      );

  // TODO: LIST VIEW SELECT DATE
  Widget listDate() => Container(
        height: 90,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: dates.length,
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.only(
              right: (index == dates.length - 1) ? defaultMargin : 16,
            ),
            child: DateCard(
              dates[index],
              isSelected: selectedDate == dates[index],
              onTap: () {
                setState(() {
                  selectedDate = dates[index];
                });
              },
            ),
          ),
        ),
      );

  // TODO: GENERATE TIME TABLE
  Column generateTimeTable() {
    //* generate schedule dengan 10, 12, 14, 16, 18, 20, 22
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widget = [];

    for (var theater in dummyTheater) {
      widget.add(
        Container(
          margin: EdgeInsets.only(
            right: defaultMargin,
            bottom: 16,
          ),
          child: Text(
            theater.name,
            style: blackRalewayMedium.copyWith(fontSize: 20),
          ),
        ),
      );

      widget.add(Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: schedule.length,
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.only(
              right: (index < schedule.length - 1) ? 16 : defaultMargin,
            ),
            child: SelectableBox(
              "${schedule[index]}:00",
              height: 50,
              width: 90,
              isSelected:
                  selectedTheater == theater && selectedTime == schedule[index],
              isEnabled: schedule[index] > DateTime.now().hour ||
                  selectedDate.day != DateTime.now().day,
              onTap: () {
                setState(() {
                  selectedTheater = theater;
                  selectedTime = schedule[index];
                  isValid = true;
                });
              },
            ),
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget,
    );
  }

  Widget buttonPilihBangku(BuildContext context) =>
      BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<PageBloc>().add(GoToSelectSeatPage(Ticket(
                    widget.movieDetail,
                    selectedTheater,
                    DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime,
                    ),
                    randomAlphaNumeric(12).toUpperCase(),
                    null,
                    (state as UserLoaded).user.name,
                    null,
                  )));
            },
            elevation: 0,
            backgroundColor: (isValid) ? mainColor : grayColor,
            child: Image.asset(
              "assets/icon/arrow_right_icon.png",
              height: 24,
              width: 24,
            ),
          );
        },
      );
}
