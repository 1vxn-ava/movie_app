import 'package:movie_app/models/models.dart';

// Acciones para Popular Movies
class LoadPopularMoviesAction {}

class LoadPopularMoviesSuccessAction {
  final List<Movie> movies;
  LoadPopularMoviesSuccessAction(this.movies);
}

class LoadPopularMoviesFailAction {
  final String error;
  LoadPopularMoviesFailAction(this.error);
}

// Acciones para Now Playing Movies
class LoadNowPlayingMoviesAction {}

class LoadNowPlayingMoviesSuccessAction {
  final List<Movie> movies;
  LoadNowPlayingMoviesSuccessAction(this.movies);
}

class LoadNowPlayingMoviesFailAction {
  final String error;
  LoadNowPlayingMoviesFailAction(this.error);
}

// Acciones de UI
class SetLoadingAction {
  final bool isLoading;
  SetLoadingAction(this.isLoading);
}

class ClearErrorAction {}