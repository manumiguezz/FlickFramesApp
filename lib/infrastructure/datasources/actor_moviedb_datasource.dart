
import 'package:app_cinema/config/constants/environment.dart';
import 'package:app_cinema/domain/datasources/actors_datasource.dart';
import 'package:app_cinema/domain/entities/actor.dart';
import 'package:app_cinema/infrastructure/mappers/actor_mapper.dart';
import 'package:app_cinema/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {

  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
      } 
    )
  );


  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
  final response = await dio.get('/movie/$movieId/credits');
  final creditsResponse = CreditsResponse.fromJson(response.data);

  List<Actor> actors = creditsResponse.cast.map((cast) {
    return ActorMapper.castToEntity(cast);
  }).toList();

  return actors;
  } 
}