import 'package:movie_app/models/models.dart';

class AppState {
  final List<Movie> popularMovies;
  final List<Movie> nowPlayingMovies;
  final bool isLoading;
  final String? error;

  AppState({
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.isLoading,
    this.error,
  });

  factory AppState.initial() {
    return AppState(
      popularMovies: [],
      nowPlayingMovies: [],
      isLoading: false,
      error: null,
    );
  }

  AppState copyWith({
    List<Movie>? popularMovies,
    List<Movie>? nowPlayingMovies,
    bool? isLoading,
    String? error,
  }) {
    return AppState(
      popularMovies: popularMovies ?? this.popularMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}