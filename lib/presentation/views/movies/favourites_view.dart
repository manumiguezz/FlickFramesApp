
import 'package:app_cinema/presentation/providers/providers.dart';
import 'package:app_cinema/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class FavouritesView extends ConsumerStatefulWidget {
  const FavouritesView({super.key});

  @override
  FavouriteViewState createState() => FavouriteViewState();
}

class FavouriteViewState extends ConsumerState <FavouritesView> {

  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if ( isLoading || isLastPage ) return;
    isLoading = true;

    final movies = await ref.read(favouriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }

  }
  
  @override
  Widget build(BuildContext context) {

    final favouriteMovies = ref.watch(favouriteMoviesProvider).values.toList();

    return Scaffold(
      body: MovieMasonry(
        movies: favouriteMovies,
        loadNextPage: loadNextPage,
      ),
    );

  }

}


  