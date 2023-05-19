import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:app_cinema/config/helpers/human_formats.dart';
import 'package:app_cinema/presentation/widgets/shared/movie_rating_stars.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';


typedef SearchMoviesCallback = Future <List <Movie>> Function (String query);

class SearchMovieDelegate extends SearchDelegate<Movie?>{

  final SearchMoviesCallback searchMovies;
  StreamController <List <Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies
    });

  void clearStreams() {
    debounceMovies.close();
  }

  void _onQueryChanged( String query ) {
    if ( _debounceTimer?.isActive ?? false ) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty){
        debounceMovies.add([]);
        return;
      }

      final movies = await searchMovies(query);
      debounceMovies.add(movies);

     });
  }
  
  @override
  String? get searchFieldLabel => 'Search Movies';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
        FadeIn(
          animate: query.isNotEmpty,
          child: IconButton(onPressed: () => query = '', 
          icon: const Icon(Icons.clear_rounded)
          ),
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        clearStreams();
        close(context, null); 
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('build results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);

    return StreamBuilder(
      stream: debounceMovies.stream,
      builder: (context, snapshot) {

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              onMovieSelected: (context, movie){
                clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;
  
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    
    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
    
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
    
            const SizedBox(width: 10,),
    
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium,),
                  
                  (movie.overview.length > 60)
                    ? Text('${movie.overview.substring(0,60)}...')
                    : Text(movie.overview),
    
                  Row(
                    children: [
                      // MovieIconAverage(movie: movie),
                      MovieRatingStars(movie: movie),
                      const SizedBox(width: 3,),
                      if (movie.voteAverage != 0)  
                      Text(
                        HumanFormats.number(movie.voteAverage, 1), 
                        style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade900),
                      ),
                    ],
                  )
                  
                ],
              ),
            )
          ],
        ),
      ),
    ); 
  }
}

