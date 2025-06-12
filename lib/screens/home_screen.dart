import 'package:flutter/material.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerOfMovie = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'), 
        backgroundColor: Colors.indigo
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Swiper con películas populares
            CustomSwipper(movies: providerOfMovie.popularMovies),
            SizedBox(height: 30),
            
            // Now Playing como nueva lista
            CustomListView(
              movies: providerOfMovie.nowPlayingMovies, 
              title: 'Now Playing - En Cartelera',
            ),
            SizedBox(height: 10),
            
            // Popular movies
            CustomListView(
              movies: providerOfMovie.popularMovies, 
              title: 'Popular Movies',
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
