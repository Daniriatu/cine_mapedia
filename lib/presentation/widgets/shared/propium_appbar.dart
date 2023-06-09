import 'package:cine_mapedia/domain/entities/movie.dart';
import 'package:cine_mapedia/presentation/delegates/quaerare_movie_delegate.dart';
import 'package:cine_mapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:cine_mapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PropriumAppbar extends ConsumerWidget {
  const PropriumAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorum = Theme.of(context).colorScheme;
    final titulusStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(Icons.movie_outlined, color: colorum.primary),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Cinemapedia",
                  style: titulusStyle,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      final quaerareMovies = ref.read(quaerareMoviesProvider);

                      final quaerareQuery = ref.read(quaerareQueryProvider);

                      showSearch<Movie?>(
                              context: context,
                              query: quaerareQuery,
                              delegate: QuaerareMovieDelegate(
                                  initialMovies: quaerareMovies,
                                  quaerareMovies: ref
                                      .read(quaerareMoviesProvider.notifier)
                                      .quaerareMoviesPerQuery))
                          .then((movie) {
                        if (movie == null) return;
                        context.push("/movie/${movie.id}");
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }
}
