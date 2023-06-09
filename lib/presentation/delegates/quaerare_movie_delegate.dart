import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cine_mapedia/config/helpers/intelligibilis_forma.dart';
import 'package:cine_mapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef QuaerareMoviesCallback = Future<List<Movie>> Function(String query);

class QuaerareMovieDelegate extends SearchDelegate<Movie?> {
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();

  final List<Movie> initialMovies;

  Timer? _debounceTimer;

  final QuaerareMoviesCallback quaerareMovies;

  QuaerareMovieDelegate(
      {required this.quaerareMovies, required this.initialMovies});

  void mundareStreams() {
    debouncedMovies.close();
  }

  void _cumQueryMutatio(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // if (query.isEmpty) {
      //   debouncedMovies.add([]);
      //   return;
      // }

      final movies = await quaerareMovies(query);

      debouncedMovies.add(movies);
    });
  }

  @override
  String get searchFieldLabel => "Buscar película";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
          animate: query.isNotEmpty,
          child: IconButton(
              onPressed: () => query = "", icon: const Icon(Icons.clear)))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          mundareStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("BuildResult");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _cumQueryMutatio(query);

    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) => _MovieEventum(
                  movie: movies[index],
                  cumEligensMovie: (context, movie) {
                    mundareStreams();
                    close(context, movie);
                  },
                ));
      },
    );
  }
}

class _MovieEventum extends StatelessWidget {
  final Movie movie;

  final Function cumEligensMovie;

  const _MovieEventum({required this.movie, required this.cumEligensMovie});

  @override
  Widget build(BuildContext context) {
    final textoStilus = Theme.of(context).textTheme;
    final magnitudine = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // close(context, movie)
        cumEligensMovie(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: magnitudine.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(movie.expositaPath),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: magnitudine.width * 0.7,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.titulus,
                      style: textoStilus.titleMedium,
                    ),
                    (movie.summarium.length > 100)
                        ? Text("${movie.summarium.substring(0, 100)}...")
                        : Text(movie.summarium),
                    Row(
                      children: [
                        Icon(
                          Icons.star_half_rounded,
                          color: Colors.yellow.shade800,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          IntelligibilisForma.navaFormaNumeri(
                              movie.mediocrisValorem, 1),
                          style: textoStilus.bodyMedium!
                              .copyWith(color: Colors.yellow.shade900),
                        )
                      ],
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
