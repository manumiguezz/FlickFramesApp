


import 'package:app_cinema/domain/datasources/local_storage_datasource.dart';
import 'package:app_cinema/domain/entities/movie.dart';
import 'package:app_cinema/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {  @override
  
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);
  
  @override
  Future<bool> isMovieFavourite(int movieId) {
    return datasource.isMovieFavourite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }
}
