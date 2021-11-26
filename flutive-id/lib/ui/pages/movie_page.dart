import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/bloc/page_bloc.dart';
import '/model/promo.dart';
import '/ui/widgets/promo_card.dart';
import '/ui/widgets/comingsoon_card.dart';
import '/ui/widgets/browse_button.dart';
import '/ui/widgets/movie_card.dart';
import '/bloc/movie_bloc.dart';
import '/model/movie.dart';
import '/shared/shared_method.dart';
import '/shared/shared_value.dart';
import '/bloc/user_bloc.dart';
import '/theme.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 45),
              header(context),
              const SizedBox(height: 60),
              textSekarangTayang(),
              const SizedBox(height: 12),
              listMovieTayang(context),
              const SizedBox(height: 30),
              textCariFilm(),
              const SizedBox(height: 12),
              listSelectedGenre(),
              const SizedBox(height: 30),
              textAkanHadir(),
              const SizedBox(height: 12),
              listComingSoonMovie(),
              const SizedBox(height: 30),
              textPromo(),
              const SizedBox(height: 15),
              listPromo(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // TODO: HEADER : Profil Image, name, and balance
  Widget header(BuildContext context) => BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          if (state is UserLoaded) {
            if (imageFileToUpload != null) {
              uploadImage(imageFileToUpload).then((downloadUrl) {
                imageFileToUpload = null;
                context
                    .read<UserBloc>()
                    .add(UpdateData(uploadImage: downloadUrl));
              });
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                children: [
                  //* foto profile
                  GestureDetector(
                    onTap: () {
                      context.read<PageBloc>().add(GoToProfilePage(state.user));
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: mainColor, width: 1),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: yellowColor,
                              strokeWidth: 2,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (state.user.profilePicture == "")
                                      ? AssetImage("assets/image/user_pic.png")
                                          as ImageProvider
                                      : NetworkImage(
                                          state.user.profilePicture)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // TODO: nama dan balance
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* NAME
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin -
                            78,
                        child: Text(
                          state.user.name,
                          style: blackRalewayMedium.copyWith(
                              fontSize: 18, color: mainColor),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      const SizedBox(height: 6),

                      //* BALANCE
                      GestureDetector(
                        onTap: () {
                          context
                              .read<PageBloc>()
                              .add(GoToWalletPage(GoToMainPage()));
                        },
                        child: Text(
                          NumberFormat.currency(
                                  locale: "id_ID",
                                  decimalDigits: 0,
                                  symbol: "IDR ")
                              .format(state.user.balance)
                              .toString(),
                          style: blackOpenSansRegular.copyWith(
                              fontSize: 14, color: grayColor),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      );

  // TODO: TEXT SEKARANG TAYANG
  Widget textSekarangTayang() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Text(
          "Sekarang Tayang",
          style: blackRalewayMedium.copyWith(fontSize: 16),
        ),
      );

  // TODO: LIST MOVIE TAYANG
  Widget listMovieTayang(BuildContext context) => SizedBox(
        height: 140,
        child: BlocBuilder<MovieBloc, MovieState>(builder: (_, state) {
          if (state is MovieLoaded) {
            List<Movie> movies = state.movies.sublist(0, 10);

            return ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 0,
                        right:
                            (index == movies.length - 1) ? defaultMargin : 16,
                      ),
                      child: MovieCard(
                        movies[index],
                        onTap: () {
                          context
                              .read<PageBloc>()
                              .add(GoToMovieDetailPage(movies[index]));
                        },
                      ),
                    ));
          } else {
            return Container();
          }
        }),
      );

  // TODO: TEXT CARI FILM
  Widget textCariFilm() => Padding(
        padding: const EdgeInsets.only(left: defaultMargin),
        child: Text(
          "Cari Film",
          style: blackRalewayMedium.copyWith(fontSize: 16),
        ),
      );

  //TODO LIST GENRE SELECTED
  Widget listSelectedGenre() => BlocBuilder<UserBloc, UserState>(
        builder: (_, userState) {
          if (userState is UserLoaded) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  userState.user.selectedGenres.length,
                  (index) => BrowseButton(userState.user.selectedGenres[index]),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      );

  // TODO: TEXT AKAN HADIR
  Widget textAkanHadir() => Padding(
        padding: EdgeInsets.only(left: defaultMargin),
        child: Text(
          "Akan Hadir",
          style: blackRalewayMedium.copyWith(fontSize: 16),
        ),
      );

  // TODO: LIST COMINGSOON MOVIE
  Widget listComingSoonMovie() => SizedBox(
        height: 140,
        child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
          if (movieState is MovieLoaded) {
            List<Movie> movies = movieState.movies.sublist(10);

            return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: movies.length,
                itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 0,
                        right:
                            (index == movies.length - 1) ? defaultMargin : 16,
                      ),
                      child: ComingsoonCard(movies[index]),
                    ));
          } else {
            return Container();
          }
        }),
      );

  // TODO: TEXT PROMO
  Widget textPromo() => Padding(
        padding: EdgeInsets.only(left: defaultMargin),
        child: Text(
          "Ambil Keberuntunganmu",
          style: blackRalewayMedium.copyWith(fontSize: 16),
        ),
      );

  // TODO: LIST PROMO
  Widget listPromo() => Column(
        children: dummyPromo
            .map((e) => Padding(
                  padding: const EdgeInsets.only(
                      left: defaultMargin, right: defaultMargin, bottom: 26),
                  child: PromoCard(e),
                ))
            .toList(),
      );
}
