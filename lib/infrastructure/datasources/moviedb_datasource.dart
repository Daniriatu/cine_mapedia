import 'package:cine_mapedia/config/constants/enviroments.dart';
import 'package:cine_mapedia/domain/datasource/movies_datasource.dart';
import 'package:cine_mapedia/domain/entities/movie.dart';
import 'package:cine_mapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cine_mapedia/infrastructure/models/moviedb/movie_singula.dart';
import 'package:dio/dio.dart';

import '../models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Enviroment.theMovieDbKey,
    'language': 'es_ES',
  }));

  List<Movie> _jsonVolviturInMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getInPraesens({int pagina = 1}) async {
    // throw UnimplementedError();
    final responsio =
        await dio.get('/movie/now_playing', queryParameters: {"page": pagina});

    return _jsonVolviturInMovies(responsio.data);
  }

  @override
  Future<List<Movie>> getPopularibus({int pagina = 1}) async {
    final responsio =
        await dio.get('/movie/popular', queryParameters: {"page": pagina});

    return _jsonVolviturInMovies(responsio.data);
  }

  @override
  Future<List<Movie>> getMaximumPuncta({int pagina = 1}) async {
    final responsio =
        await dio.get('/movie/upcoming', queryParameters: {"page": pagina});

    return _jsonVolviturInMovies(responsio.data);
  }

  @override
  Future<List<Movie>> getMox({int pagina = 1}) async {
    final responsio =
        await dio.get('/movie/top_rated', queryParameters: {"page": pagina});

    return _jsonVolviturInMovies(responsio.data);
  }

  @override
  Future<Movie> getMoviePerId(String id) async {
    final responsio = await dio.get("/movie/${id}");

    if (responsio.statusCode != 200)
      throw Exception("Movie with id: ${id} not found");

    final movieSingula = MovieSingula.fromJson(responsio.data);

    final Movie movie = MovieMapper.movieSingulaToEntity(movieSingula);

    return movie;
  }
}
