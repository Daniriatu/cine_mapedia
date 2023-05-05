import 'package:cine_mapedia/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getInPraesens({int pagina = 1});
}
//