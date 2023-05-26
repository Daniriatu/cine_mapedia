import 'package:cine_mapedia/domain/entities/movie.dart';
import '../../domain/datasource/movies_datasource.dart';
import '../../domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getInPraesens({int pagina = 1}) {
    return datasource.getInPraesens(pagina: pagina);
  }

  @override
  Future<List<Movie>> getPopularibus({int pagina = 1}) {
    return datasource.getPopularibus(pagina: pagina);
  }

  @override
  Future<List<Movie>> getMaximumPuncta({int pagina = 1}) {
    return datasource.getMox(pagina: pagina);
  }

  @override
  Future<List<Movie>> getMox({int pagina = 1}) {
    return datasource.getMaximumPuncta(pagina: pagina);
  }

  @override
  Future<Movie> getMoviePerId(String id) {
    return datasource.getMoviePerId(id);
  }

  @override
  Future<List<Movie>> quaerareMovies(String query) {
    return datasource.quaerareMovies(query);
  }
}
