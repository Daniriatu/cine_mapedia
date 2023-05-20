import 'package:cine_mapedia/domain/datasource/actors_datasource.dart';
import 'package:cine_mapedia/domain/entities/actor.dart';
import 'package:cine_mapedia/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsPerMovie(String movieId) {
    return datasource.getActorsPerMovie(movieId);
  }
}
