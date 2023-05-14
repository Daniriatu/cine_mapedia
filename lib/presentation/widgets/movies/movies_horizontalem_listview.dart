import 'package:animate_do/animate_do.dart';
import 'package:cine_mapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalemListView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 355,
      child: Column(children: [
        if (titulus != null || subTitulus != null)
          _Titulus(titulus: titulus, subTitulus: subTitulus),
        Expanded(
            child: ListView.builder(
          itemCount: movies.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return _Slide(movie: movies[index]);
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
                return FadeIn(child: child);
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
              style: textStilus.bodyMedium,
            )
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
