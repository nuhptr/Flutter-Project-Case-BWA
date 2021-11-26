import 'dart:convert';
import 'package:http/http.dart' as http;

import '/model/actor.dart';
import '/model/movie_detail.dart';
import '/model/movie.dart';
import '/shared/shared_value.dart';

class MovieServices {
  // TODO: get all data using http.Client
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";

    //* check client if null fill with object client
    client ??= http.Client();

    var response = await client.get(url);
    if (response.statusCode == 200) {
      print(response.body);
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  // TODO: get details movie using http.client
  static Future<MovieDetail> getDetails(Movie movie,
      {int movieId, http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/${movieId ?? movie.id}?api_key=$apiKey&language=en_US";

    //* check client if null fill with object client
    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    List genres = (data as Map<String, dynamic>)["genres"];
    String language;

    //* Konvert language
    switch ((data as Map<String, dynamic>)["original_language"].toString()) {
      case "ja":
        language = "Japanese";
        break;
      case "ko":
        language = "Korean";
        break;
      case "id":
        language = "Indonesia";
        break;
      case "en":
        language = "English";
        break;
      default:
    }

    return movieId != null
        ? MovieDetail(Movie.fromJson(data),
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)["name"].toString())
                .toList())
        : MovieDetail(movie,
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)["name"].toString())
                .toList());
  }

  // TODO: get actor detail from API using client
  static Future<List<Actor>> getActor(int movieId, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey";

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    return ((data as Map<String, dynamic>)["cast"] as List)
        .map((e) => Actor(
              name: (e as Map<String, dynamic>)["name"],
              profilePath: (e as Map<String, dynamic>)["profile_path"],
            ))
        //* diambil 8 aja actornya
        .take(8)
        .toList();
  }
}
