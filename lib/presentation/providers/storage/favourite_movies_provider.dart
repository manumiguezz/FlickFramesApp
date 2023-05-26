

import 'package:app_cinema/domain/repositories/local_storage_repository.dart';
import 'package:app_cinema/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

final favouriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});


class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>>{
  
  int page = 0;
  final LocalStorageRepository localStorageRepository;
  
  StorageMoviesNotifier({
    required this.localStorageRepository
  }):super({});

  Future <List <Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(offset: page * 10, limit: 20);
    page++;

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies){
      tempMoviesMap[movie.id] = movie;
    }
    state = {...state, ...tempMoviesMap};

    return movies;
  }

  Future<void> toggleFavourite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavourites = state[movie.id] != null;

    if (isMovieInFavourites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
  

}