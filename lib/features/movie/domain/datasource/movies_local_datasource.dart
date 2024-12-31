import 'package:popular_movies/features/movie/infrastructure/models/movie_local.dart';

abstract class MovieLocalDataSource {
  // Guarda una lista de películas en la base de datos local
  Future<void> saveCacheMovies(List<MovieLocal> movies);

  // Obtiene todas las películas almacenadas localmente
  Future<List<MovieLocal>> getCachedMovies();

  // Elimina películas más antiguas que 30 días
  Future<void> clearOldCache();
}
