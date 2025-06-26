import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/redux/app_state.dart';
import 'package:movie_app/redux/actions.dart';
import 'package:movie_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'), 
        backgroundColor: Colors.indigo,
        actions: [
          // Botón para recargar datos
          StoreConnector<AppState, VoidCallback>(
            converter: (store) => () {
              store.dispatch(fetchPopularMoviesAction());
              store.dispatch(fetchNowPlayingMoviesAction());
            },
            builder: (context, callback) {
              return IconButton(
                icon: Icon(Icons.refresh),
                onPressed: callback,
              );
            },
          ),
        ],
      ),
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          if (state.isLoading && 
              state.popularMovies.isEmpty && 
              state.nowPlayingMovies.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Error: ${state.errorMessage}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final store = StoreProvider.of<AppState>(context);
                      store.dispatch(fetchPopularMoviesAction());
                      store.dispatch(fetchNowPlayingMoviesAction());
                    },
                    child: Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Swiper con películas populares
                if (state.popularMovies.isNotEmpty)
                  CustomSwipper(movies: state.popularMovies),
                SizedBox(height: 30),
                
                // Now Playing Movies
                if (state.nowPlayingMovies.isNotEmpty)
                  CustomListView(
                    movies: state.nowPlayingMovies, 
                    title: 'Now Playing - En Cartelera',
                  ),
                SizedBox(height: 10),
                
                // Popular Movies
                if (state.popularMovies.isNotEmpty)
                  CustomListView(
                    movies: state.popularMovies, 
                    title: 'Popular Movies',
                  ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}