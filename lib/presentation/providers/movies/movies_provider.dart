import 'package:cine_mapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/movie.dart';

final inPraesensMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final hucPlusMovies = ref.watch(movieRepositoryProvider).getInPraesens;
  return MoviesNotifier(hucPlusMovies: hucPlusMovies);
});

typedef MovieCallback = Future<List<Movie>> Function({int pagina});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int nuncPagina = 0;

  MovieCallback hucPlusMovies;

  MoviesNotifier({required this.hucPlusMovies}) : super([]);

  Future<void> proximaPagina() async {
    nuncPagina++;

    final List<Movie> movies = await hucPlusMovies(pagina: nuncPagina);

    state = [...state, ...movies];
  }
}
