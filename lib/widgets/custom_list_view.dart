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
        crossAxisAlignment: CrossAxisAlignment.start, // MEJORAR ALINEACIÓN
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // AUMENTAR PADDING
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18, // AUMENTAR TAMAÑO DE FUENTE
                color: Colors.indigoAccent,
              ),
            ),
          ),
          SizedBox(height: 8), 
          SizedBox(
            height: 280, // AUMENTAR ALTURA PARA MEJOR VISUALIZACIÓN
            width: double.infinity,
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8), // AGREGAR PADDING
              itemBuilder: (_, i) {
                final movie = movies[i];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    'details',
                    arguments: movie,
                  ),
                  child: Container(
                    width: 130, // AUMENTAR ANCHO
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IMAGEN DEL PÓSTER
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FadeInImage(
                            height: 190, // AUMENTAR ALTURA
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: AssetImage('assets/images/loading.gif'),
                            image: NetworkImage(movie.getPosterPath),
                          ),
                        ),
                        SizedBox(height: 8),
                        
                        // TÍTULO DE LA PELÍCULA
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
                        
                        // FECHA DE ESTRENO
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
