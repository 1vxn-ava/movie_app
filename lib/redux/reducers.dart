import 'package:movie_app/redux/actions.dart';
import 'package:movie_app/redux/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is SetLoadingAction) {
    return state.copyWith(isLoading: action.isLoading);
  } else if (action is SetPopularMoviesAction) {
    return state.copyWith(popularMovies: action.movies);
  } else if (action is SetNowPlayingMoviesAction) {
    return state.copyWith(nowPlayingMovies: action.movies);
  } else if (action is SetErrorAction) {
    return state.copyWith(errorMessage: action.error);
  }
  
  return state;
}