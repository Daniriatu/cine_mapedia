import 'package:cine_mapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cine_mapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
