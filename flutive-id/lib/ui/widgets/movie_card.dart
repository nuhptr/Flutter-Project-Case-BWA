import 'package:bwa_flutix/theme.dart';
import 'package:bwa_flutix/ui/widgets/rating_stars.dart';
import 'package:flutter/material.dart';

import '/shared/shared_value.dart';
import '/model/movie.dart';

class MovieCard extends StatelessWidget {
  // TODO: properties kelas
  final Movie movies;
  final Function onTap;

  MovieCard(this.movies, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },

      // TODO: MAIN CONTENT
      child: Container(
        height: 140,
        width: 210,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(imageKey + "w780" + movies.backdropPath),
              fit: BoxFit.cover,
            )),
        child: Container(
          height: 140,
          width: 210,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.61),
                  Colors.black.withOpacity(0)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* untuk judul film
              Text(
                movies.title,
                style: blackRalewayMedium.copyWith(
                    fontSize: 14, color: Colors.white, height: 1.4),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              //* untuk rating dengan widget buatan sendiri
              RatingStars(
                voteAverage: movies.voteAverage,
                ratingColor: yellowColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
