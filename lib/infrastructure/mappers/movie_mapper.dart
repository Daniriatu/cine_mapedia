import 'package:cine_mapedia/domain/entities/movie.dart';
import 'package:cine_mapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adultus: moviedb.adult,
      // De la api solo me llega el final de la url de la imagen. Aquí la completamos
      contextusPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      // La lista de enteros que llega la transformo en lista de Strings
      genusIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originaliLingua: moviedb.originalLanguage,
      originaliTitulus: moviedb.originalTitle,
      summarium: moviedb.overview,
      popularis: moviedb.popularity,
      // De la api solo me llega el final de la url de la imagen. Aquí no pongo imagen de sustitución (lo resolveremos de otro modo)
      expositaPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://www.movienewz.com/img/films/poster-holder.jpg',
      exhibitionemDiem:
          moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now(),
      titulus: moviedb.title,
      video: moviedb.video,
      mediocrisValorem: moviedb.voteAverage,
      summaValorem: moviedb.voteCount);
}
