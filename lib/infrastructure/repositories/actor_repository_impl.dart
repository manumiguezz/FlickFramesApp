

import 'package:app_cinema/domain/datasources/actors_datasource.dart';
import 'package:app_cinema/domain/entities/actor.dart';
import 'package:app_cinema/domain/repositories/actor_repository.dart';

class ActorRepositoryImpl extends ActorRepository {
  
  final ActorsDatasource datasource;
  ActorRepositoryImpl(this.datasource);
  
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }


}