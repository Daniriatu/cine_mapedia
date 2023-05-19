import 'package:cine_mapedia/domain/entities/movie.dart';
import 'package:cine_mapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: movieRepository.getMoviePerId);
});

typedef VenitMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final VenitMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> venitMovie(String movieId) async {
    if (state[movieId] != null) return;

    print("realizando peticion http");

    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
