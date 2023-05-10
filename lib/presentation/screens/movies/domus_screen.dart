import 'package:cine_mapedia/presentation/providers/movies/movies_provider.dart';
import 'package:cine_mapedia/presentation/widgets/shared/propium_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/widgets.dart';

class DomusScreen extends StatelessWidget {
  static const String nomen = "domus-screen";
  const DomusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _DomusVisum());
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
    final praesensMovies = ref.watch(inPraesensMoviesProvider);
    return Column(
      children: [PropriumAppbar(), MoviesSlideshow(movies: praesensMovies)],
    );
    // ;
  }
}
