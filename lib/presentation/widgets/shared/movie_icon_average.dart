import 'package:flutter/material.dart';
import '../../../domain/entities/movie.dart';

class MovieIconAverage extends StatelessWidget {

  final Movie movie;

  const MovieIconAverage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {

    if (movie.voteAverage < 6.5){
      return Icon(Icons.star_border_outlined, color: Colors.yellow.shade800,);
    } else if (movie.voteAverage < 8){
      return Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,);
    } else if (movie.voteAverage < 10){
      return Icon(Icons.star, color: Colors.yellow.shade800,); 
    } else {
      return Icon(Icons.abc, color: Colors.yellow.shade800,);
    }
  }
}