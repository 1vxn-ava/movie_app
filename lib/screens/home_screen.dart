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
      appBar: AppBar(title: Text('Movie App'), backgroundColor: Colors.indigo),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSwipper(movies: providerOfMovie.popularMovies),
            SizedBox(height: 30),
            CustomListView(movies: providerOfMovie.nowPlayingMovies, title: 'Now Playing',),
            SizedBox(height: 10),
            CustomListView(movies: providerOfMovie.popularMovies, title: 'Popular',),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}