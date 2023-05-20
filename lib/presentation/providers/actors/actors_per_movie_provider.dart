import 'package:cine_mapedia/domain/entities/actor.dart';
import 'package:cine_mapedia/presentation/providers/actors/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsPerMovieProvider =
    StateNotifierProvider<ActorsPerMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsPerMovieNotifier(getActors: actorsRepository.getActorsPerMovie);
});

typedef VenitActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsPerMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final VenitActorsCallback getActors;

  ActorsPerMovieNotifier({required this.getActors}) : super({});

  Future<void> venitActors(String movieId) async {
    if (state[movieId] != null) return;

    print("realizando peticion http");

    final actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}
