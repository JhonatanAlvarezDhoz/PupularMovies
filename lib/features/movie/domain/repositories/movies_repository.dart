import 'package:popular_movies/features/movie/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getPopularMovies();
}
