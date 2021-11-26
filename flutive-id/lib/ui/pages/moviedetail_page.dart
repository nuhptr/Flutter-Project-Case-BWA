import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/ui/widgets/actor_card.dart';
import '/shared/shared_value.dart';
import '/theme.dart';
import '/ui/widgets/rating_stars.dart';
import '/bloc/page_bloc.dart';
import '/model/actor.dart';
import '/model/movie.dart';
import '/model/movie_detail.dart';
import '/services/http/movie_services.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;

    return WillPopScope(
        onWillPop: () async {
          context.read<PageBloc>().add(GoToMainPage());
          return;
        },

        // TODO: MAIN CONTENT
        child: Scaffold(
          backgroundColor: mainColor,

          // TODO: Movie Data
          body: SafeArea(
            child: Container(
              color: Colors.white,
              child: FutureBuilder(
                  future: MovieServices.getDetails(movie),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      movieDetail = snapshot.data;

                      return Stack(
                        children: [
                          headerPhoto(movieDetail),
                          buttonBack(context),
                          // TODO: CONTENT SECTION
                          Padding(
                              padding: const EdgeInsets.only(top: 245),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                                child: Container(
                                  color: Colors.white,
                                  child: ListView(
                                    physics: BouncingScrollPhysics(),
                                    children: [
                                      const SizedBox(height: 15),
                                      textMovieDetailTitle(movieDetail),
                                      const SizedBox(height: 10),
                                      // TODO: GENRE AND LANGUAGE
                                      (snapshot.hasData)
                                          ? Center(
                                              child: Text(
                                                movieDetail.genresAndLanguage,
                                                style: blackRalewayRegular
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: grayColor),
                                              ),
                                            )
                                          : CircularProgressIndicator(),

                                      const SizedBox(height: 10),
                                      ratingStars(movieDetail),
                                      const SizedBox(height: 20),
                                      textPemeran(),
                                      const SizedBox(height: 12),
                                      listPemeran(),
                                      const SizedBox(height: 20),
                                      textTitleSinopsis(),
                                      const SizedBox(height: 8),
                                      sinopsis(),
                                      const SizedBox(height: 35),
                                      buttonPilihJadwal(context, movieDetail),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ),
        ));
  }

  // TODO: HEADER FOTO
  Widget headerPhoto(MovieDetail movieDetail) => Container(
        height: 254,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageKey + "w1280" + movie.backdropPath ??
                  movieDetail.posterPath)),
        ),
        child: Stack(
          children: [
            Container(
              height: 254,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.5), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
            ),
          ],
        ),
      );

  // TODO:  BUTTON BACK
  Widget buttonBack(BuildContext context) => Container(
      margin: EdgeInsets.only(
        left: defaultMargin,
        top: 60,
      ),
      child: IconButton(
          onPressed: () {
            context.read<PageBloc>().add(GoToMainPage());
          },
          icon: Image.asset(
            "assets/icon/arrow_left_icon.png",
            color: Colors.white,
            width: 24,
            height: 24,
          )));

  // TODO: MOVIE DETAIL TITLE
  Widget textMovieDetailTitle(MovieDetail movieDetail) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55),
        child: Text(
          movieDetail.title,
          textAlign: TextAlign.center,
          style: blackRalewayMedium.copyWith(fontSize: 24, height: 1.3),
          maxLines: 3,
        ),
      );

  // TODO: RATING STARS
  Widget ratingStars(MovieDetail movieDetail) => Container(
        margin: EdgeInsets.symmetric(
          horizontal: 120,
        ),
        child: RatingStars(
          voteAverage: movieDetail.voteAverage,
          ratingColor: grayColor,
        ),
      );

  // TODO: TEXT PEMERAN
  Widget textPemeran() => Padding(
        padding: EdgeInsets.only(left: defaultMargin),
        child: Text(
          "Pemeran",
          style: blackRalewayMedium.copyWith(
            fontSize: 14,
          ),
        ),
      );

  // TODO: LIST PEMERAN -> Actor Data
  Widget listPemeran({List<Actor> actor}) => FutureBuilder(
      future: MovieServices.getActor(movie.id),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          actor = snapshot.data;

          return Container(
            height: 115,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: actor.length,
                itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                          left: (index == 0) ? defaultMargin : 0,
                          right:
                              (index == actor.length - 1) ? defaultMargin : 16),
                      child: ActorCard(actor[index]),
                    )),
          );
        } else {
          return SizedBox();
        }
      });

  // TODO: TEXT SINOPSIS
  Widget textTitleSinopsis() => Padding(
        padding: EdgeInsets.only(left: defaultMargin),
        child: Text(
          "Sinopsis",
          style: blackRalewayMedium.copyWith(
            fontSize: 14,
          ),
        ),
      );

  // TODO: SINOPSIS
  Widget sinopsis() => Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Text(
          movie.overview,
          textAlign: TextAlign.justify,
          style: blackRalewayRegular.copyWith(
              fontSize: 14, color: grayColor, height: 1.5),
        ),
      );

  // TODO: BUTTON NEXT
  Widget buttonPilihJadwal(BuildContext context, MovieDetail movieDetail) =>
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 55,
        ),
        width: 250,
        height: 45,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: mainColor,
              ),
              onPressed: () {
                context
                    .read<PageBloc>()
                    .add(GoToSelectSchedulePage(movieDetail));
              },
              child: Text(
                "Pesan Tiket",
                style: blackRalewayMedium.copyWith(
                    fontSize: 16, color: Colors.white),
              )),
        ),
      );
}
