import 'package:movie_app/models/models.dart';

class AppState {
  final List<Movie> popularMovies;
  final List<Movie> nowPlayingMovies;
  final bool isLoading;
  final String? errorMessage;

  AppState({
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.isLoading,
    this.errorMessage,
  });

  factory AppState.initial() {
    return AppState(
      popularMovies: [],
      nowPlayingMovies: [],
      isLoading: false,
      errorMessage: null,
    );
  }

  AppState copyWith({
    List<Movie>? popularMovies,
    List<Movie>? nowPlayingMovies,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AppState(
      popularMovies: popularMovies ?? this.popularMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'AppState{popularMovies: ${popularMovies.length}, nowPlayingMovies: ${nowPlayingMovies.length}, isLoading: $isLoading}';
  }
}