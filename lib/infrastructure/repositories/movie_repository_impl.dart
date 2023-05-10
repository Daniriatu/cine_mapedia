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
}
