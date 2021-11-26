import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../services/http/movie_services.dart';
import '/model/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc(MovieState initialState) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchMovie) {
      List<Movie> movies = await MovieServices.getMovies(2);

      yield MovieLoaded(movies: movies);
    }
  }
}
