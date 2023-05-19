import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Swiper(
        outer: true,
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsetsDirectional.only(bottom: 0),
          builder: DotSwiperPaginationBuilder(
            size: 7,
            activeSize: 10,
            activeColor: colors.primary,
            color: colors.secondary 
          )
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index])
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;
  
  const _Slide({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 5,
          offset: Offset(0, 10)
      )
      ]
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black),
                  child: Center(child: CircularProgressIndicator())
                );
              }
              return FadeIn(child: child);
            },
          )
        )
      ),
    );
  }
}