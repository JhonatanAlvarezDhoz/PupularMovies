import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:popular_movies/core/services/services.dart';
import 'package:popular_movies/features/movie/domain/datasource/movies_local_datasource.dart';
import 'package:popular_movies/features/movie/infrastructure/models/movie_local.dart';

class MoviesLocalDatasourceStorage extends MovieLocalDataSource {
  late final Isar isar;

  final Dio dio = Dio();
  late final ImageCacheService imageCacheService;

  MoviesLocalDatasourceStorage() {
    _initialize();
    imageCacheService = ImageCacheService(dio); // Inicialización aquí
  }

  Future<void> _initialize() async {
    isar = await IsarDatabaseService.getInstance('movies', [MovieLocalSchema]);
  }

  // Guarda una lista de películas en la base de datos local
  @override
  Future<void> saveCacheMovies(List<MovieLocal> movies) async {
    for (final movie in movies) {
      await saveMovie(movie);
    }
  }

  Future<Set<int>> getExistingIds() async {
    try {
      final movies = await isar.movieLocals.where().tmdbIdProperty().findAll();

      return movies.toSet();
    } catch (e) {
      log('Error obteniendo IDs existentes: ${e.toString()}');
      return {};
    }
  }

  Future<void> saveMovie(MovieLocal movie) async {
    // Cachear imágenes si no son placeholders

    try {
      movie.localPosterPath =
          await imageCacheService.cacheImage(movie.posterPath);
      log(movie.posterPath, name: "Remote");
      log(movie.localPosterPath.toString(), name: "local");
    } catch (e, s) {
      log('Error cacheando póster: $e ,', stackTrace: s);
    }

    try {
      movie.localBackdropPath =
          await imageCacheService.cacheImage(movie.backdropPath);
    } catch (e, s) {
      log('Error cacheando backdrop: $e', stackTrace: s);
    }

    await isar.writeTxn(() async {
      await isar.movieLocals.put(movie);
    });
  }

  // Obtiene todas las películas almacenadas localmente
  @override
  Future<List<MovieLocal>> getCachedMovies() async {
    return await isar.movieLocals.where().sortByTmdbId().findAll();
  }

  // Elimina películas más antiguas que 5 días
  @override
  Future<void> clearOldCache() async {
    final fiveDaysAgo = DateTime.now().subtract(const Duration(days: 5));
    await isar.writeTxn(() async {
      final oldMovies = await isar.movieLocals
          .where()
          .filter()
          .savedAtLessThan(fiveDaysAgo)
          .findAll();

      await isar.movieLocals.deleteAll(oldMovies.map((e) => e.id).toList());
    });
  }
}
