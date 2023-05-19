import 'package:app_cinema/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../delegates/search_movie_delegate.dart';
import '../../providers/movies/movies_slideshow_provider.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(
        slivers: [
        
          SliverPadding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            sliver: SliverAppBar(
              leading: const Icon(Icons.more_horiz_outlined),
              title: const Text('MOBILE CINEMA', style: TextStyle(fontWeight: FontWeight.bold),),
              centerTitle: true,
              pinned: false,
              actions: [ 
                IconButton(
                  onPressed: (){
                    final searchQuery = ref.read(searchQueryProvider);
                    showSearch<Movie?>(
                      query: searchQuery,
                      context: context,
                      delegate: SearchMovieDelegate(
                        searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery
                      )
                    ).then((movie) {
                      if (movie == null) return;
                      context.push('/movie/${movie.id}');
                    });


                  }, 
                  icon: const Icon(Icons.search),
                ),
              ],
            )
          ),
        
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    
                    MoviesSlideshow(movies: slideShowMovies),
              
                    MovieHorizontalListView(
                      movies: nowPlayingMovies,
                      title: 'On Billboard',
                      subTitle: 'On time',
                      loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
                    ),
        
                    MovieHorizontalListView(
                      movies: topRatedMovies,
                      title: 'Best Rated',
                      // subTitle: 'This year',
                      loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage()
                    ),
              
                    MovieHorizontalListView(
                      movies: upcomingMovies,
                      title: 'Coming Soon',
                      // subTitle: 'This year',
                      loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage()
                    ),
              
                    MovieHorizontalListView(
                      movies: popularMovies,
                      title: 'Popular',
                      // subTitle: 'This year',
                      loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage()
                    ),
              
                    const SizedBox(height: 10,)
                  ],
                );
              },
              childCount: 1
            )
          )
        ],
      ),
    );
  }
}