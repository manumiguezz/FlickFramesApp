
import 'package:app_cinema/presentation/providers/providers.dart';
import 'package:app_cinema/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class FavouritesView extends ConsumerStatefulWidget {
  const FavouritesView({super.key});

  @override
  FavouriteViewState createState() => FavouriteViewState();
}

class FavouriteViewState extends ConsumerState <FavouritesView> with AutomaticKeepAliveClientMixin {

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
    super.build(context);

    final favouriteMovies = ref.watch(favouriteMoviesProvider).values.toList();

    if (favouriteMovies.isEmpty){

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              child: Image.asset('assets/sad-face.png')
            ),
            const SizedBox(height: 20,),
            const Text('Oh no!', style: TextStyle(fontSize: 30),),
            const Text('You have no favourite movies on your list')
          ],
        )
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: favouriteMovies,
        loadNextPage: loadNextPage,
      ),
    );

  }
  
  @override
  bool get wantKeepAlive => true;

}


  