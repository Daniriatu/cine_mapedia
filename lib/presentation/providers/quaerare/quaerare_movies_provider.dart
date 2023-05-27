import 'package:cine_mapedia/domain/entities/movie.dart';
import 'package:cine_mapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quaerareQueryProvider = StateProvider<String>(
  (ref) => "",
);

final quaerareMoviesProvider =
    StateNotifierProvider<QuaerareMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return QuaerareMoviesNotifier(
      ref: ref, quaerareMovies: movieRepository.quaerareMovies);
});

typedef QuaerareMoviesCallback = Future<List<Movie>> Function(String query);

class QuaerareMoviesNotifier extends StateNotifier<List<Movie>> {
  final QuaerareMoviesCallback quaerareMovies;

  final Ref ref;

  QuaerareMoviesNotifier({required this.ref, required this.quaerareMovies})
      : super([]);

  Future<List<Movie>> quaerareMoviesPerQuery(String query) async {
    final List<Movie> movies = await quaerareMovies(query);

    ref.read(quaerareQueryProvider.notifier).update((state) => query);

    state = movies;

    return movies;
  }
}
