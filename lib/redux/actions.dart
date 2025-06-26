import 'package:movie_app/models/models.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:movie_app/redux/app_state.dart';
import 'package:movie_app/services/movie_service.dart';

// Actions síncronas
class SetLoadingAction {
  final bool isLoading;
  SetLoadingAction(this.isLoading);
}

class SetPopularMoviesAction {
  final List<Movie> movies;
  SetPopularMoviesAction(this.movies);
}

class SetNowPlayingMoviesAction {
  final List<Movie> movies;
  SetNowPlayingMoviesAction(this.movies);
}

class SetErrorAction {
  final String error;
  SetErrorAction(this.error);
}

// Actions asíncronas (Thunk Actions)
ThunkAction<AppState> fetchPopularMoviesAction() {
  return (Store<AppState> store) async {
    store.dispatch(SetLoadingAction(true));
    try {
      final movieService = MovieService();
      final movies = await movieService.getPopularMovies();
      store.dispatch(SetPopularMoviesAction(movies));
    } catch (error) {
      store.dispatch(SetErrorAction(error.toString()));
    } finally {
      store.dispatch(SetLoadingAction(false));
    }
  };
}

ThunkAction<AppState> fetchNowPlayingMoviesAction() {
  return (Store<AppState> store) async {
    store.dispatch(SetLoadingAction(true));
    try {
      final movieService = MovieService();
      final movies = await movieService.getNowPlayingMovies();
      store.dispatch(SetNowPlayingMoviesAction(movies));
    } catch (error) {
      store.dispatch(SetErrorAction(error.toString()));
    } finally {
      store.dispatch(SetLoadingAction(false));
    }
  };
}
