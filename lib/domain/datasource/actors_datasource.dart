import 'package:cine_mapedia/domain/entities/actor.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActorsPerMovie(String movieId);
}
