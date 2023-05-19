

// import 'package:app_cinema/infrastructure/repositories/movie_repository_impl.dart';
// import 'package:app_cinema/presentation/delegates/search_movie_delegate.dart';
// import 'package:app_cinema/presentation/providers/providers.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../../../domain/entities/movie.dart';

// class CustomSliverAppBar extends StatelessWidget {
//   const CustomSliverAppBar({
//     super.key,
//     required this.movieRepository, required this.searchQuery,
//   });

//   final MovieRepositoryImpl movieRepository;
//   final SearchMoviesProvider searchQuery;

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//         leading: const Icon(Icons.more_horiz_outlined),
//         title: const Text('MOBILE CINEMA', style: TextStyle(fontWeight: FontWeight.bold),),
//         centerTitle: true,
//         pinned: false,
//         actions: [
           
//           IconButton(
//             onPressed: (){

//               final searchQuery = ref
//               showSearch<Movie?>(
//                 query: 'antman',
//                 context: context, 
//                 delegate: SearchMovieDelegate(
//                   searchMovies: movieRepository.searchMovies
//                 )
//               ).then((movie) {
//                 if (movie == null) return;
//                 context.push('/movie/${movie.id}');
//               });
              
              
//             }, 
//             icon: const Icon(Icons.search))
//         ],
//       );
//   }
// }