
import 'package:flutter/material.dart';
import '../../../domain/entities/movie.dart';


class MovieRatingStars extends StatelessWidget {

final Movie movie;

  const MovieRatingStars({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final double voteAverage = movie.voteAverage;
    final fullStars = (voteAverage / 2).floor();
    final hasHalfStar = (voteAverage % 2 != 0);

    if (voteAverage == 0) {
      return Text(
        'No Rated', 
        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.yellow.shade800)
      ); 
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
          for (var i = 0; i < fullStars; i++)
            Icon(Icons.star, color: Colors.yellow.shade800, size: 20,),
          if (hasHalfStar) 
            Icon(Icons.star_half, color: Colors.yellow.shade800, size: 20,),
          for (var i = 0; i < (5 - fullStars - (hasHalfStar ? 1 : 0)); i++)
            Icon(Icons.star_border, color: Colors.yellow.shade800, size: 20,),
      ],
    );
  }
}