import 'package:animate_do/animate_do.dart';
import 'package:cine_mapedia/config/helpers/intelligibilis_forma.dart';
import 'package:cine_mapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalemListView extends StatefulWidget {
  final List<Movie> movies;
  final String? titulus;
  final String? subTitulus;

  final VoidCallback? adProximamPaginam;

  const MovieHorizontalemListView(
      {super.key,
      required this.movies,
      this.titulus,
      this.subTitulus,
      this.adProximamPaginam});

  @override
  State<MovieHorizontalemListView> createState() =>
      _MovieHorizontalemListViewState();
}

class _MovieHorizontalemListViewState extends State<MovieHorizontalemListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.adProximamPaginam == null) return;

      if (scrollController.position.pixels + 200 >=
          scrollController.position.maxScrollExtent) {
        // print("Carga las proxima pelicula");
        widget.adProximamPaginam!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 355,
      child: Column(children: [
        if (widget.titulus != null || widget.subTitulus != null)
          _Titulus(titulus: widget.titulus, subTitulus: widget.subTitulus),
        Expanded(
            child: ListView.builder(
          itemCount: widget.movies.length,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return FadeIn(child: _Slide(movie: widget.movies[index]));
          },
        ))
      ]),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStilus = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.expositaPath,
              width: 150,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
                }
                // return FadeIn(child: child);
                return GestureDetector(
                  onTap: () => context.push("/movie/${movie.id}"),
                  child: child,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 3),
        SizedBox(
          width: 150,
          child: Text(
            movie.titulus,
            maxLines: 2,
            style: textStilus.titleSmall,
          ),
        ),
        SizedBox(
          width: 150,
          child: Row(children: [
            Icon(
              Icons.star_half_outlined,
              color: Colors.yellow.shade800,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              "${movie.mediocrisValorem}",
              style: textStilus.bodyMedium
                  ?.copyWith(color: Colors.yellow.shade800),
            ),
            const Spacer(),
            Text(
              IntelligibilisForma.navaFormaNumeri(movie.popularis),
              style: textStilus.bodySmall,
            ),
          ]),
        )
      ]),
    );
  }
}

class _Titulus extends StatelessWidget {
  final String? titulus;
  final String? subTitulus;

  const _Titulus({required this.titulus, required this.subTitulus});

  @override
  Widget build(BuildContext context) {
    final titulusStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(children: [
        if (titulus != null)
          Text(
            titulus!,
            style: titulusStyle,
          ),
        Spacer(),
        if (subTitulus != null)
          // Text(
          //   subTitulus!,
          //   style: titulusStyle,
          // ),
          FilledButton.tonal(
              onPressed: () {},
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text(subTitulus!))
      ]),
    );
  }
}
