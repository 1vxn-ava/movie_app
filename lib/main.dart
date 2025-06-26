import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:movie_app/redux/app_state.dart';
import 'package:movie_app/redux/reducers.dart';
import 'package:movie_app/redux/actions.dart';
import 'package:movie_app/screens/details_screen.dart';
import 'package:movie_app/screens/home_screen.dart';

void main() {
  runApp(AppProvider());
}

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    // Crear el store de Redux
    final store = Store<AppState>(
      appReducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware], // Para acciones asíncronas
    );

    // Cargar datos iniciales
    store.dispatch(fetchPopularMoviesAction());
    store.dispatch(fetchNowPlayingMoviesAction());

    return StoreProvider<AppState>(
      store: store,
      child: MovieApp(),
    );
  }
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(), 
        'details': (_) => DetailsScreen()
      },
    );
  }
}