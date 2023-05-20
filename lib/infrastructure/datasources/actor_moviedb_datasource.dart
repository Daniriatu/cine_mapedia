import 'package:cine_mapedia/config/constants/enviroments.dart';
import 'package:cine_mapedia/domain/datasource/actors_datasource.dart';
import 'package:cine_mapedia/domain/entities/actor.dart';
import 'package:cine_mapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cine_mapedia/infrastructure/models/moviedb/coetus_responsio.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Enviroment.theMovieDbKey,
    'language': 'es_ES',
  }));
  @override
  Future<List<Actor>> getActorsPerMovie(String movieId) async {
    final response = await dio.get("/movie/$movieId/credits");

    final coetusRespone = CoetusResponsio.fromJson(response.data);

    List<Actor> actors = coetusRespone.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
