import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movie_app/models/models.dart';

class MovieService {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '6a5e3da21d7663dea92cebc324ea8da4';
  final String _popularEndpoint = '/3/movie/popular';
  final String _nowPlayingEndpoint = '/3/movie/now_playing';

  Future<List<Movie>> getPopularMovies() async {
    try {
      final url = Uri.https(_baseUrl, _popularEndpoint, {
        'api_key': _apiKey,
      });
      
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = convert.jsonDecode(response.body) as Map<String, dynamic>;
        final movieResponse = MovieResponse.fromJson(data);
        return movieResponse.results;
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (e) {
      throw Exception('Error fetching popular movies: $e');
    }
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final url = Uri.https(_baseUrl, _nowPlayingEndpoint, {
        'api_key': _apiKey,
        'page': '1',
        'region': 'MX',
      });
      
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = convert.jsonDecode(response.body) as Map<String, dynamic>;
        final movieResponse = MovieResponse.fromJson(data);
        return movieResponse.results;
      } else {
        throw Exception('Failed to load now playing movies');
      }
    } catch (e) {
      throw Exception('Error fetching now playing movies: $e');
    }
  }
}