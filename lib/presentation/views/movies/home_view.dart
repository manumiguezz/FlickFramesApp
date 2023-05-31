import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app_cinema/config/theme/app_theme.dart';
import 'package:app_cinema/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../delegates/search_movie_delegate.dart';
import '../../providers/movies/movies_slideshow_provider.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';
import '../views.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> with AutomaticKeepAliveClientMixin{

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
    super.build(context);

    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    // final viewRoutes = const <Widget> [
    //   HomeView(),
    //   FavouritesView(),
    //   CategoryView(),
    // ];

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
    }

    return Scaffold(
      // visible: !initialLoading,
      body: CustomScrollView(
        slivers: [
        
          SliverPadding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            sliver: SliverAppBar(
              title: const Text('FLICKFRAMES', style: TextStyle(fontWeight: FontWeight.bold),),
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
                      context.push('/home/0/movie/${movie.id}');
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

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ThemeSwitchingArea(
              child: Builder(builder: (context) {
                return Drawer(
                  child: Column(
                    children: [
                      const Text('Theme Changer'),

                      const SizedBox(height: 50,),

                      IconButton(
                        onPressed: () => ThemeSwitcher.of(context).changeTheme(
                          theme: AppTheme().getThemeDark()
                        ), 
                        icon: const Icon(Icons.nights_stay)
                      )
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}