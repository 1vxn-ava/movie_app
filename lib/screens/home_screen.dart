import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:movie_app/redux/app_state.dart';
import 'package:movie_app/redux/middleware.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:movie_app/models/models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar películas al inicializar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      StoreProvider.of<AppState>(context).dispatch(loadAllMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
        backgroundColor: Colors.indigo,
      ),
      body: StoreConnector<AppState, _HomeScreenViewModel>(
        converter: (Store<AppState> store) => _HomeScreenViewModel.fromStore(store),
        builder: (context, viewModel) {
          if (viewModel.isLoading && viewModel.popularMovies.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            );
          }

          if (viewModel.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Error: ${viewModel.error}',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.retryLoading(),
                    child: Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              viewModel.retryLoading();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (viewModel.popularMovies.isNotEmpty)
                    CustomSwipper(movies: viewModel.popularMovies),
                  SizedBox(height: 30),
                  
                  if (viewModel.nowPlayingMovies.isNotEmpty)
                    CustomListView(
                      movies: viewModel.nowPlayingMovies,
                      title: 'Now Playing - En Cartelera',
                    ),
                  SizedBox(height: 10),
                  
                  if (viewModel.popularMovies.isNotEmpty)
                    CustomListView(
                      movies: viewModel.popularMovies,
                      title: 'Popular Movies',
                    ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ViewModel para separar la lógica de la UI
class _HomeScreenViewModel {
  final List<Movie> popularMovies;
  final List<Movie> nowPlayingMovies;
  final bool isLoading;
  final String? error;
  final Function() retryLoading;

  _HomeScreenViewModel({
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.isLoading,
    this.error,
    required this.retryLoading,
  });

  static _HomeScreenViewModel fromStore(Store<AppState> store) {
    return _HomeScreenViewModel(
      popularMovies: store.state.popularMovies,
      nowPlayingMovies: store.state.nowPlayingMovies,
      isLoading: store.state.isLoading,
      error: store.state.error,
      retryLoading: () {
        store.dispatch(loadAllMovies());
      },
    );
  }
}