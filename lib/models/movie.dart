import 'dart:convert';

class Movie {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    adult: json["adult"],
    backdropPath: json["backdrop_path"] ?? 'bardok.png',
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalLanguage: "es",
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"] ?? 'krilin.png',
    releaseDate: DateTime.parse(json["release_date"]),
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  get getPosterPath {
    if (posterPath == null) {
      return 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png';
    }
    print('https://image.tmdb.org/t/p/w300$posterPath');
    return 'https://image.tmdb.org/t/p/w300$posterPath';
  }

  get getBackdropPath {
    return 'https://image.tmdb.org/t/p/w300$backdropPath';
  }

  
}