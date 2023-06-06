
import '../../../domain/entities/movie.dart';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviePosterLink extends StatelessWidget {

  final Movie movie;
  const MoviePosterLink({
    super.key, 
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final int randomNumber = Random().nextInt(500);

    return FadeInUp(
      delay: Duration(milliseconds: randomNumber),
      child: GestureDetector(
        onTap: () => context.push('/home/0/movie/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.posterPath),
        ),
      ),
    );
  }
}