import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../bloc/page_bloc.dart';
import '/model/register_user.dart';
import '/ui/widgets/selectable_box.dart';
import '/theme.dart';

class PreferenceGenreAndLanguagePage extends StatefulWidget {
  // TODO: properties kelas
  final RegisterUser registerUser;
  final List<String> genres = [
    "Horror",
    "Musik",
    "Bertarung",
    "Cinta",
    "Perang",
    "Kriminal"
  ];
  final List<String> languages = ["Indonesia", "English", "Japanese", "Korean"];

  PreferenceGenreAndLanguagePage(this.registerUser);

  @override
  _PreferenceGenreAndLanguagePageState createState() =>
      _PreferenceGenreAndLanguagePageState();
}

class _PreferenceGenreAndLanguagePageState
    extends State<PreferenceGenreAndLanguagePage> {
  // TODO: Properties kelas
  List<String> selectedGenres = [];
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    // TODO: ketika back
    return WillPopScope(
      onWillPop: () async {
        widget.registerUser.password = "";

        context.read<PageBloc>().add(GotoRegistrationPage(widget.registerUser));
        return;
      },

      // TODO: content
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  iconBack(context),
                  const SizedBox(height: 20),
                  textPilihGenre(),
                  const SizedBox(height: 16),
                  listGenre(),
                  const SizedBox(height: 24),
                  textPilihBahasaFilm(),
                  const SizedBox(height: 16),
                  listLanguage(),
                  const SizedBox(height: 40),
                  buttonKeKonfirmasiPage(),
                  const SizedBox(height: 50)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // TODO: ICON BACK
  Widget iconBack(BuildContext context) => IconButton(
        onPressed: () {
          widget.registerUser.password = "";

          context
              .read<PageBloc>()
              .add(GotoRegistrationPage(widget.registerUser));
        },
        icon: Image.asset(
          "assets/icon/arrow_left_icon.png",
          height: 24,
          width: 24,
        ),
      );

  // TODO: TEXT PILIH GENRE
  Widget textPilihGenre() => Text(
        "Pilih Genre\nFavorit Kamu",
        style: blackRalewayMedium.copyWith(fontSize: 20, height: 1.4),
      );

  // TODO: GENERATE LIST GENRE WIDGET
  Widget listGenre() => Wrap(
        spacing: 24,
        runSpacing: 24,
        children: generateGenreWidgets(context),
      );

  // TODO: TEXT PILIH BAHASA
  Widget textPilihBahasaFilm() => Text(
        "Bahasa Film\nYang Utama",
        style: blackRalewayMedium.copyWith(fontSize: 20, height: 1.4),
      );

  // TODO: LIST LANGUAGE
  Widget listLanguage() => Wrap(
        spacing: 24,
        runSpacing: 24,
        children: generateSelectLanguage(context),
      );

  // TODO: BUTTON NEXT KE KONFIRMASI
  Widget buttonKeKonfirmasiPage() => Center(
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: mainColor,
          onPressed: () {
            // TODO: check selectedGenres
            if (selectedGenres.length != 4) {
              Flushbar(
                duration: Duration(milliseconds: 1500),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: redColor,
                message: "Tolong Pilih 4 Genre",
              )..show(context);
            } else {
              // TODO: oper data
              widget.registerUser.selectedGenres = selectedGenres;
              widget.registerUser.selectedLanguage = selectedLanguage;

              context
                  .read<PageBloc>()
                  .add(GoToAccountConfirmationPage(widget.registerUser));
            }
          },
          child: Image.asset(
            "assets/icon/arrow_right_icon.png",
            width: 24,
            height: 24,
          ),
        ),
      );

  // TODO: Select Language
  List<Widget> generateSelectLanguage(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 2 * 38) / 2;
    return widget.languages
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedLanguage == e,
              onTap: () {
                setState(() {
                  selectedLanguage = e;
                });
              },
            ))
        .toList();
  }

// TODO: generateGenreWidgets
  List<Widget> generateGenreWidgets(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 2 * 38) / 2;

    return widget.genres
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedGenres.contains(e),
              onTap: () {
                onSelectGenres(e);
              },
            ))
        .toList();
  }

  // TODO: select genres
  void onSelectGenres(String genre) {
    //* jika kotak contains genre di remove
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    }
    //* jika selected genre kurang dari 4 ditambahkan ke variabel selectedGenres
    else {
      if (selectedGenres.length < 4) {
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}
