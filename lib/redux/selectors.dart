import 'package:movie_app/models/models.dart';
import 'package:movie_app/redux/app_state.dart';

class MovieSelectors {
  static List<Movie> getPopularMovies(AppState state) => state.popularMovies;
  
  static List<Movie> getNowPlayingMovies(AppState state) => state.nowPlayingMovies;
  
  static bool isLoading(AppState state) => state.isLoading;
  
  static String? getErrorMessage(AppState state) => state.errorMessage;
  
  static bool hasMovies(AppState state) => 
      state.popularMovies.isNotEmpty || state.nowPlayingMovies.isNotEmpty;
}