import 'package:animate_do/animate_do.dart';
import 'package:app_cinema/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:app_cinema/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

class MovieScreen extends ConsumerStatefulWidget {
  
  static const name = 'movie_screen';
  final String movieId;
  
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);

  }

  @override
  Widget build(BuildContext context) {

    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    
    if (movie == null) {
      return const _LoadingMovie();
    }
    
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppbar(movie: movie,),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: movie),
            childCount: 1
            ))
        ],
      )
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 10,),

              SizedBox(
                width: (size.width -40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26), 
                    ),
                    Text(movie.overview,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 20, ), 
                    ),
                  ],
                ),
              )
            ],
          ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              children: [
                ...movie.genreIds.map((gender) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(gender),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ))
              ],
            ),
          ),

          _ActorsByMovie(movieId: movie.id.toString())
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {

  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null){
      return const CircularProgressIndicator(strokeWidth: 2,);
    }
    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (BuildContext context, int index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                Text(actor.name, maxLines: 2,),
                Text(actor.character ?? '',
                maxLines: 2,
                style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis))
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomSliverAppbar extends StatelessWidget {

  final Movie movie;
  
  const _CustomSliverAppbar({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            
          }, 
          icon: const Icon(Icons.favorite_border)
          // icon: const Icon(Icons.favorite, color: Colors.red,),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            children: [
              SizedBox.expand(
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null ) return const SizedBox();
                    return child;
                  },
                ),
              ),

              const _CustomGradient(
                begin: Alignment.topRight, 
                end: Alignment.bottomLeft, 
                stops: [0.1, 0.4], 
                colors: [
                  Colors.black12,
                  Colors.transparent,
                ]
              ),


              const _CustomGradient(
                begin: Alignment.topCenter, 
                end: Alignment.bottomCenter, 
                stops: [0.8, 1.0], 
                colors: [
                  Colors.transparent,
                  Colors.black12,
                ]
              ),
              
              const _CustomGradient(
                begin: Alignment.topLeft, 
                end: Alignment.bottomRight, 
                stops: [0.0, 0.7], 
                colors: [
                  Colors.black12,
                  Colors.transparent,
                ]
              ),
              
            ],
          ),
      ),
    );
  }
}

class _LoadingMovie extends StatelessWidget {
  const _LoadingMovie();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2,)));
  }
}

class _CustomGradient extends StatelessWidget {

  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List <double> stops;
  final List <Color> colors;

  const _CustomGradient({
    this.begin = Alignment.center, 
    this.end = Alignment.center, 
    required this.stops, 
    required this.colors
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          )
        )
      ),
    );
  }
}