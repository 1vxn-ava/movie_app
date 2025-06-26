import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:movie_app/redux/app_state.dart';
import 'package:movie_app/redux/actions.dart';
import 'package:movie_app/services/movie_service.dart';

// Thunk para cargar películas populares
ThunkAction<AppState> loadPopularMovies() {
  return (Store<AppState> store) async {
    store.dispatch(LoadPopularMoviesAction());
    
    try {
      final movies = await MovieService.getPopularMovies();
      store.dispatch(LoadPopularMoviesSuccessAction(movies));
    } catch (error) {
      store.dispatch(LoadPopularMoviesFailAction(error.toString()));
    }
  };
}

// Thunk para cargar películas Now Playing
ThunkAction<AppState> loadNowPlayingMovies() {
  return (Store<AppState> store) async {
    store.dispatch(LoadNowPlayingMoviesAction());
    
    try {
      final movies = await MovieService.getNowPlayingMovies();
      store.dispatch(LoadNowPlayingMoviesSuccessAction(movies));
    } catch (error) {
      store.dispatch(LoadNowPlayingMoviesFailAction(error.toString()));
    }
  };
}

// Thunk para cargar todas las películas al inicio
ThunkAction<AppState> loadAllMovies() {
  return (Store<AppState> store) async {
    store.dispatch(SetLoadingAction(true));
   
    try {
      // Crear los futures directamente de los servicios
      await Future.wait([
        MovieService.getPopularMovies().then((movies) {
          store.dispatch(LoadPopularMoviesSuccessAction(movies));
        }).catchError((error) {
          store.dispatch(LoadPopularMoviesFailAction(error.toString()));
        }),
        MovieService.getNowPlayingMovies().then((movies) {
          store.dispatch(LoadNowPlayingMoviesSuccessAction(movies));
        }).catchError((error) {
          store.dispatch(LoadNowPlayingMoviesFailAction(error.toString()));
        }),
      ]);
    } catch (error) {
      store.dispatch(LoadPopularMoviesFailAction(error.toString()));
    } finally {
      store.dispatch(SetLoadingAction(false));
    }
  };
}