import 'package:animate_do/animate_do.dart';
import 'package:cine_mapedia/domain/entities/movie.dart';
import 'package:cine_mapedia/presentation/providers/actors/actors_per_movie_provider.dart';
import 'package:cine_mapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String nomen = "movie-screen";
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.read(movieInfoProvider.notifier).venitMovie(widget.movieId);

    ref.read(actorsPerMovieProvider.notifier).venitActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _PropriumSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieParticularum(movie: movie),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieParticularum extends StatelessWidget {
  final Movie movie;

  const _MovieParticularum({required this.movie});

  @override
  Widget build(BuildContext context) {
    final magnitudine = MediaQuery.of(context).size;

    final faciesTextus = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.expositaPath,
                  width: magnitudine.width * 0.3,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (magnitudine.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.titulus,
                      style: faciesTextus.titleLarge,
                    ),
                    Text(
                      movie.summarium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(children: [
            ...movie.genusIds.map(
              (genus) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(genus),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            )
          ]),
        ),
        _ActorsPerMovie(movieId: movie.id.toString()),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}

class _ActorsPerMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsPerMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsPerMovie = ref.watch(actorsPerMovieProvider);

    if (actorsPerMovie[movieId] == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }

    final actors = actorsPerMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            final actor = actors[index];
            return Container(
              padding: const EdgeInsets.all(8),
              width: 135,
              child: Column(children: [
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.effigies,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  actor.nomen,
                  maxLines: 2,
                ),
                Text(
                  actor.character ?? "",
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                )
              ]),
            );
          }),
    );
  }
}

class _PropriumSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _PropriumSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final magnitudine = MediaQuery.of(context).size;

    return SliverAppBar(
      expandedHeight: magnitudine.height * 0.7,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        // title: Text(
        //   movie.titulus,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.expositaPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.7, 1.0],
                          colors: [Colors.transparent, Colors.black87]))),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          stops: [0.0, 0.3],
                          colors: [Colors.black87, Colors.transparent]))),
            )
          ],
        ),
      ),
    );
  }
}
