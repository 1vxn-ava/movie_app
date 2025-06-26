import 'package:movie_app/redux/app_state.dart';
import 'package:movie_app/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  switch (action.runtimeType) {
    // Popular Movies
    case LoadPopularMoviesAction:
      return state.copyWith(isLoading: true, error: null);
    
    case LoadPopularMoviesSuccessAction:
      return state.copyWith(
        popularMovies: action.movies,
        isLoading: false,
        error: null,
      );
    
    case LoadPopularMoviesFailAction:
      return state.copyWith(
        isLoading: false,
        error: action.error,
      );

    // Now Playing Movies
    case LoadNowPlayingMoviesAction:
      return state.copyWith(isLoading: true, error: null);
    
    case LoadNowPlayingMoviesSuccessAction:
      return state.copyWith(
        nowPlayingMovies: action.movies,
        isLoading: false,
        error: null,
      );
    
    case LoadNowPlayingMoviesFailAction:
      return state.copyWith(
        isLoading: false,
        error: action.error,
      );

    // UI Actions
    case SetLoadingAction:
      return state.copyWith(isLoading: action.isLoading);
    
    case ClearErrorAction:
      return state.copyWith(error: null);
    
    default:
      return state;
  }
}