import 'package:movie_app/redux/app_state.dart';
import 'package:movie_app/models/models.dart';

class MovieSelectors {
  static List<Movie> getPopularMovies(AppState state) => state.popularMovies;
  
  static List<Movie> getNowPlayingMovies(AppState state) => state.nowPlayingMovies;
  
  static bool isLoading(AppState state) => state.isLoading;
  
  static String? getError(AppState state) => state.error;
  
  static bool hasMovies(AppState state) => 
      state.popularMovies.isNotEmpty || state.nowPlayingMovies.isNotEmpty;
  
  static List<Movie> getAllMovies(AppState state) => 
      [...state.popularMovies, ...state.nowPlayingMovies];
}