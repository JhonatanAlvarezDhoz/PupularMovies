import 'dart:developer';

import 'package:popular_movies/core/usecases/use_case.dart';
import 'package:popular_movies/features/movie/domain/entities/movie.dart';
import 'package:popular_movies/features/movie/domain/repositories/movies_repository.dart';

class UcGetPopularMoviesNoParams extends UseCaseNoParams<List<Movie>> {
  final MoviesRepository moviesRepository;

  UcGetPopularMoviesNoParams({required this.moviesRepository});
  @override
  Future<List<Movie>> call() async {
    final popularmovies = await moviesRepository.getPopularMovies();
    log(popularmovies.length.toString());

    return popularmovies;
  }
}
