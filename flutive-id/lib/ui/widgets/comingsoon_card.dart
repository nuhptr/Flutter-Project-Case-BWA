import 'package:flutter/material.dart';

import '/model/movie.dart';
import '/shared/shared_value.dart';
import '/theme.dart';

class ComingsoonCard extends StatelessWidget {
  final Movie movies;
  final Function onTap;

  ComingsoonCard(this.movies, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageKey + "w780" + movies.backdropPath)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  movies.title,
                  maxLines: 2,
                  style: blackRalewayMedium.copyWith(
                    height: 1.4,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                )),
          ],
        ));
  }
}
