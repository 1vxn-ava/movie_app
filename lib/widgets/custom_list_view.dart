import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

class CustomListView extends StatelessWidget {
  final List<Movie> movies;
  final String title;
  
  const CustomListView({
    super.key, 
    required this.movies, 
    this.title = 'Movies',
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.indigoAccent,
              ),
            ),
          ),
          SizedBox(height: 8), 
          SizedBox(
            height: 280,
            width: double.infinity,
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (_, i) {
                final movie = movies[i];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    'details',
                    arguments: movie,
                  ),
                  child: Container(
                    width: 130,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagen de la pelicula (póster)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FadeInImage(
                            height: 190,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: AssetImage('assets/images/loading.gif'),
                            image: NetworkImage(movie.getPosterPath),
                          ),
                        ),
                        SizedBox(height: 8),
                        
                        // Título de la película
                        Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        
                        // Fecha de estreno
                        Text(
                          'Estreno: ${movie.releaseDate.toLocal().toString().split(" ")[0]}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
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
