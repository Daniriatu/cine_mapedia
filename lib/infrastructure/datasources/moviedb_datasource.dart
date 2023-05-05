import 'package:cine_mapedia/config/constants/enviroments.dart';
import 'package:cine_mapedia/domain/datasource/movies_datasource.dart';
import 'package:cine_mapedia/domain/entities/movie.dart';
import 'package:cine_mapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:dio/dio.dart';

import '../models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Enviroment.theMovieDbKey,
    'language': 'es_ES',
  }));
  @override
  Future<List<Movie>> getInPraesens({int pagina = 1}) async {
    // TODO: implement getInPraesens
    // throw UnimplementedError();
    final responsio = await dio.get('/movie/now_playing');
    final movieDBResponse = MovieDbResponse.fromJson(responsio.data);
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }
}
