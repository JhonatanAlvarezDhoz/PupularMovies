import 'package:popular_movies/features/movie/domain/entities/movie.dart';
import 'package:popular_movies/features/movie/infrastructure/models/movie_local.dart';
import 'package:popular_movies/features/movie/infrastructure/models/moviedb_model.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDb movieDb) => Movie(
        adult: movieDb.adult ?? false,
        backdropPath: (movieDb.backdropPath != null)
            ? "https://image.tmdb.org/t/p/w500${movieDb.backdropPath}"
            : "https://asean.org/wp-content/uploads/2022/07/No-Image-Placeholder.svg.png",
        genreIds: movieDb.genreIds!.map((movie) => movie).toList(),
        tmdbId: movieDb.id!,
        originalLanguage: movieDb.originalLanguage ?? "",
        originalTitle: movieDb.originalTitle ?? "",
        overview: movieDb.overview ?? "",
        popularity: movieDb.popularity ?? 0.0,
        posterPath: (movieDb.posterPath != null)
            ? "https://image.tmdb.org/t/p/w500${movieDb.posterPath}"
            : "https://asean.org/wp-content/uploads/2022/07/No-Image-Placeholder.svg.png",
        releaseDate: movieDb.releaseDate ?? DateTime(2024),
        title: movieDb.title ?? "",
        video: movieDb.video ?? false,
        voteAverage: movieDb.voteAverage ?? 0.0,
        voteCount: movieDb.voteCount ?? 0,
        savedAt: DateTime.now(),
      );

  static MovieLocal movieDbToLocalMovie(MovieMovieDb moviedb) {
    return MovieLocal(
      tmdbId: moviedb.id!,
      adult: moviedb.adult!,
      backdropPath: moviedb.backdropPath != null
          ? "https://image.tmdb.org/t/p/w500${moviedb.backdropPath}"
          : "https://asean.org/wp-content/uploads/2022/07/No-Image-Placeholder.svg.png",
      genreIds: moviedb.genreIds ?? [1],
      originalLanguage: moviedb.originalLanguage ?? "no language",
      originalTitle: moviedb.originalTitle ?? "no original title",
      overview: moviedb.overview ?? "no overview",
      popularity: moviedb.popularity ?? 0.0,
      posterPath: moviedb.posterPath != null
          ? "https://image.tmdb.org/t/p/w500${moviedb.posterPath}"
          : "https://asean.org/wp-content/uploads/2022/07/No-Image-Placeholder.svg.png",
      releaseDate: moviedb.releaseDate!,
      title: moviedb.title ?? "no title",
      video: moviedb.video ?? false,
      voteAverage: moviedb.voteAverage ?? 0.0,
      voteCount: moviedb.voteCount ?? 0,
      savedAt: DateTime.now(),
    );
  }

  static Movie movieLocalToMovie(MovieLocal movielocal) {
    return Movie(
      tmdbId: movielocal.tmdbId,
      adult: movielocal.adult,
      backdropPath: movielocal.localBackdropPath ?? movielocal.backdropPath,
      genreIds: movielocal.genreIds,
      originalLanguage: movielocal.originalLanguage,
      originalTitle: movielocal.originalTitle,
      overview: movielocal.overview,
      popularity: movielocal.popularity,
      posterPath: movielocal.localPosterPath ?? movielocal.posterPath,
      releaseDate: movielocal.releaseDate,
      title: movielocal.title,
      video: movielocal.video,
      voteAverage: movielocal.voteAverage,
      voteCount: movielocal.voteCount,
      savedAt: movielocal.savedAt,
      localBackdropPath: movielocal.localBackdropPath,
      localPosterPath: movielocal.localPosterPath,
    );
  }
}
