import 'package:app_cinema/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/actor.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);
  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
});

typedef GetActorsCallBack = Future<List<Actor>>Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier <Map<String, List<Actor>>> {

  final GetActorsCallBack getActors;
  ActorsByMovieNotifier({
    required this.getActors
    }): super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null ) return;

    final actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }

}