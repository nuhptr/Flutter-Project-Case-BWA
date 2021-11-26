import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final double voteAverage;
  final String overview;
  final String posterPath;
  final String backdropPath;

  Movie({
    @required this.id,
    @required this.title,
    @required this.voteAverage,
    @required this.overview,
    @required this.posterPath,
    @required this.backdropPath,
  });

  // TODO: function yang mengambil data dari json
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"],
      title: json["title"],
      voteAverage: (json["vote_average"] as num).toDouble(),
      overview: json["overview"],
      posterPath: json["poster_path"],
      backdropPath: json["backdrop_path"],
    );
  }

  @override
  // TODO: implement props
  List<Object> get props =>
      [id, title, voteAverage, overview, posterPath, backdropPath];
}
