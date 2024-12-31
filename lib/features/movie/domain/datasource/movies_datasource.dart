import 'package:popular_movies/features/movie/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getPopularMovies({int page});
}
