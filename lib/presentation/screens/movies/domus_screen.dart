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
  }

  @override
  Widget build(BuildContext context) {
    final inpraesensMovies = ref.watch(inPraesensMoviesProvider);
    final slideshowMovies = ref.watch(moviesSlidesshowProvider);

    return Column(
      children: [
        PropriumAppbar(),
        MoviesSlideshow(movies: slideshowMovies),
        MovieHorizontalemListView(
          movies: inpraesensMovies,
          titulus: "En Cines",
          subTitulus: "Lunes 15",
        )
      ],
    );
    // ;
  }
}
