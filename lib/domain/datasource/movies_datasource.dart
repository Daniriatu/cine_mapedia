import 'package:cine_mapedia/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getInPraesens({int pagina = 1});

  Future<List<Movie>> getPopularibus({int pagina = 1});

  Future<List<Movie>> getMox({int pagina = 1});

  Future<List<Movie>> getMaximumPuncta({int pagina = 1});

  Future<Movie> getMoviePerId(String id);
}
//