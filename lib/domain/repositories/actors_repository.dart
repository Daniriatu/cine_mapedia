import 'package:cine_mapedia/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsPerMovie(String movieId);
}
