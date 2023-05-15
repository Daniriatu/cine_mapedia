import 'package:cine_mapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/widgets.dart';

class DomusScreen extends StatelessWidget {
  static const String nomen = "domus-screen";
  const DomusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _DomusVisum(), bottomNavigationBar: PropriumBottomNavigation());
  }
}

class _DomusVisum extends ConsumerStatefulWidget {
  // const _DomusVisum({
  //   super.key,
  // });

  @override
  _DomusVisumState createState() => _DomusVisumState();
}

class _DomusVisumState extends ConsumerState<_DomusVisum> {
  @override
  void initState() {
    super.initState();

    ref.read(inPraesensMoviesProvider.notifier).proximaPagina();
    ref.read(popularibusMoviesProvider.notifier).proximaPagina();
    ref.read(moxMoviesProvider.notifier).proximaPagina();
    ref.read(maximumPunctaMoviesProvider.notifier).proximaPagina();
  }

  @override
  Widget build(BuildContext context) {
    final inpraesensMovies = ref.watch(inPraesensMoviesProvider);
    final slideshowMovies = ref.watch(moviesSlidesshowProvider);
    final popularibusMovies = ref.watch(popularibusMoviesProvider);
    final moxMovies = ref.watch(moxMoviesProvider);
    final maximumPunctaMovies = ref.watch(maximumPunctaMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(title: PropriumAppbar()),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideshow(movies: slideshowMovies),
            MovieHorizontalemListView(
              movies: inpraesensMovies,
              titulus: "En Cines",
              subTitulus: "Lunes 15",
              adProximamPaginam: () =>
                  ref.read(inPraesensMoviesProvider.notifier).proximaPagina(),
            ),
            MovieHorizontalemListView(
              movies: moxMovies,
              titulus: "Próximamente",
              subTitulus: "En este mes",
              adProximamPaginam: () =>
                  ref.read(moxMoviesProvider.notifier).proximaPagina(),
            ),
            MovieHorizontalemListView(
              movies: popularibusMovies,
              titulus: "Populares",
              subTitulus: "En este mes",
              adProximamPaginam: () =>
                  ref.read(popularibusMoviesProvider.notifier).proximaPagina(),
            ),
            MovieHorizontalemListView(
              movies: maximumPunctaMovies,
              titulus: "Mejor calificadas",
              subTitulus: "De siempre",
              adProximamPaginam: () => ref
                  .read(maximumPunctaMoviesProvider.notifier)
                  .proximaPagina(),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      }, childCount: 1))
    ]);
    // ;
  }
}
