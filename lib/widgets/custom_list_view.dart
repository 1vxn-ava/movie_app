import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

class CustomListView extends StatelessWidget {
  final List<Movie> movies; // lista de peliculas 
  final String title; // el titulo
  const CustomListView({super.key, required this.movies, this.title = 'Movies',
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.indigoAccent,
              ),
            ),
          ),
          SizedBox(height: 8), 
          SizedBox(
            // Carrusel
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) {
                final movie = movies[i];
                return GestureDetector(
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        'details',
                        arguments: movie,
                      ),
                  child: Container(
                    width: 120,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            height: 180,
                            fit: BoxFit.cover,
                            placeholder: AssetImage(
                              'assets/images/loading.gif',
                            ),
                            image: NetworkImage(movie.getPosterPath),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${movie.releaseDate.toLocal().toString().split(" ")[0]}', // fecha de estreno de la pelicula 
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
