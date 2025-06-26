class HomeScreenWithSelectors extends StatelessWidget {
  const HomeScreenWithSelectors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'), 
        backgroundColor: Colors.indigo,
        actions: [
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
      body: Column(
        children: [
          // Loading indicator
          StoreConnector<AppState, bool>(
            converter: (store) => MovieSelectors.isLoading(store.state),
            builder: (context, isLoading) {
              return isLoading 
                ? LinearProgressIndicator()
                : SizedBox.shrink();
            },
          ),
          
          // Content
          Expanded(
            child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) {
                if (state.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text('Error: ${state.errorMessage}'),
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
                      if (state.popularMovies.isNotEmpty)
                        CustomSwipper(movies: state.popularMovies),
                      SizedBox(height: 30),
                      
                      if (state.nowPlayingMovies.isNotEmpty)
                        CustomListView(
                          movies: state.nowPlayingMovies,
                          title: 'Now Playing - En Cartelera',
                        ),
                      SizedBox(height: 10),
                      
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
          ),
        ],
      ),
    );
  }
}