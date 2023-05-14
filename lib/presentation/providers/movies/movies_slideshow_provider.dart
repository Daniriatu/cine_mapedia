import 'package:cine_mapedia/domain/entities/movie.dart';
import 'package:cine_mapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlidesshowProvider = Provider<List<Movie>>((ref) {
  final praesensMovies = ref.watch(inPraesensMoviesProvider);
  if (praesensMovies.isEmpty) return [];
  return praesensMovies.sublist(0, 6);
});
