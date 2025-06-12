import 'dart:convert';
import 'package:movie_app/models/models.dart';

class MovieResponse {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  MovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponse.fromRawJson(String str) =>
      MovieResponse.fromJson(json.decode(str));


  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      MovieResponse(
        page: json["page"],
        results: List<Movie>.from(
          json["results"].map((x) => Movie.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}