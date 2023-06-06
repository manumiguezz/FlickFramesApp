
import 'package:app_cinema/domain/entities/actor.dart';
import 'package:app_cinema/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {

  static Actor castToEntity(Cast cast) => 
    Actor(
      id: cast.id, 
      name: cast.name, 
      profilePath: cast.profilePath != null
      ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
      : 'https://pcafalcons.com/wp-content/uploads/2019/08/no-profile-picture-icon-female-0-e1564976045606.jpg', 
      character: cast.character
    );
}