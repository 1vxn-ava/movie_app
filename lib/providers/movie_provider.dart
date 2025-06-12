import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movie_app/models/models.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> popularMovies = [];
  List<Movie> nowPlayingMovies = [];
  final urlm = 'api.themoviedb.org';
  final apiKey = '6a5e3da21d7663dea92cebc324ea8da4';
  final popularSeg = '/3/movie/popular';
  final nowPlayingSeg = '/3/movie/now_playing'; 

  MovieProvider() {
    getMoviesByPopular();
    getMoviesNowPlaying();
  }

  Future<String> getPopularMovies({String? seg}) async {
    final url = Uri.https(urlm, popularSeg, {'api_key': apiKey, });
    var response = await http.get(url);
    return response.body;
  }
  
  // Funcion async para traer las peliculas en now_playing de la API
  Future<String> getNowPlayingMovies() async { 
    final url = Uri.https(urlm, nowPlayingSeg, {
      'api_key': apiKey,
      'page': '1',
      'region': 'MX'
    });
    var response = await http.get(url);
    print(response);
    return response.body;
  }

  void getMoviesByPopular() async {
    final resp = await getPopularMovies();
    final data = convert.jsonDecode(resp) as Map<String, dynamic>;
    final popularResponse = MovieResponse.fromJson(data);
    popularMovies = popularResponse.results;
    notifyListeners(); 
  }
  
  // Nueva funcion para traer las peliculas en now_playing
  void getMoviesNowPlaying() async { 
    final resp = await getNowPlayingMovies();
    final data = convert.jsonDecode(resp) as Map<String, dynamic>;
    final nowPlayingResponse = MovieResponse.fromJson(data);
    nowPlayingMovies = nowPlayingResponse.results;
    notifyListeners(); 
  }
}