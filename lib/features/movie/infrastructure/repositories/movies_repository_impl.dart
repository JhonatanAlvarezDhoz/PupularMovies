import 'package:popular_movies/features/movie/domain/datasource/movies_datasource.dart';
import 'package:popular_movies/features/movie/domain/entities/movie.dart';
import 'package:popular_movies/features/movie/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDatasource moviesDatasource;

  MoviesRepositoryImpl({required this.moviesDatasource});
  @override
  Future<List<Movie>> getPopularMovies() {
    return moviesDatasource.getPopularMovies();
  }
}
