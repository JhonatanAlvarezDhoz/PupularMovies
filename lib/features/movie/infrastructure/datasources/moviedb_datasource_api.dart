import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:popular_movies/core/constants/enviroment.dart';
import 'package:popular_movies/core/constants/languaje.dart';
import 'package:popular_movies/core/exceptions/exceptions.dart';
import 'package:popular_movies/core/services/services.dart';
import 'package:popular_movies/features/movie/domain/datasource/movies_datasource.dart';
import 'package:popular_movies/features/movie/domain/entities/movie.dart';
import 'package:popular_movies/features/movie/infrastructure/datasources/movies_local_datasource_storage.dart';
import 'package:popular_movies/features/movie/infrastructure/mappers/movie_mapper.dart';
import 'package:popular_movies/features/movie/infrastructure/models/moviedb_response.dart';

class MovieDbDatasourceApi extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.themoviedbBaseUrl,
      queryParameters: {
        'Authorization': 'Bearer ${Enviroment.tokenTMDB}',
        'api_key': Enviroment.apiKeyTMDB,
        'language': Language.spanish,
        'page': 2,
      },
    ),
  );

  final MoviesLocalDatasourceStorage moviesLocalDatasourceStorage =
      MoviesLocalDatasourceStorage();

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final MovieDbResponse movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results!
        .where((movieDb) => movieDb.backdropPath != null)
        .map((movie) => MovieMapper.movieDbToEntity(movie))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getPopularMovies({int? page}) async {
    final connectivityService = ConnectivityService(Connectivity());

    final isConnected = await connectivityService.isConnectedToInternet();
    if (isConnected) {
      try {
        final response = await dio.get('popular');

        if (response.statusCode == 404) {
          throw NotFoundException('La consulta o la url no existe');
        }

        if (response.statusCode == 400) {
          throw BadRequestException('Error del servidor',
              code: response.statusCode.toString(), details: response.data);
        }

        if (response.statusCode == 401) {
          throw UnauthorizedException(
              'Usted no cuenta con la credenciales necesarias',
              code: response.statusCode.toString(),
              details: response.data);
        }

        // Obtener solo los IDs existentes usando el nuevo método
        final existingIds = await moviesLocalDatasourceStorage.getExistingIds();

        final movieDbList = MovieDbResponse.fromJson(response.data);

        // Filtrar películas nuevas
        final newMovies = movieDbList.results!
            .where((movie) => !existingIds.contains(movie.id))
            .toList();

        // Guardar películas en la base de datos local si no existen
        if (newMovies.isNotEmpty) {
          final moviesToSave = newMovies.map((movie) {
            return MovieMapper.movieDbToLocalMovie(movie);
          }).toList();

          await moviesLocalDatasourceStorage.saveCacheMovies(moviesToSave);
          log('Se guardaron ${newMovies.length} películas nuevas');
        }

        final movies = _jsonToMovies(response.data);
        return movies;
      } catch (e, s) {
        log("Conectivity ${e.toString()}", stackTrace: s);
      }
    } else {
      try {
        final movieLocals =
            await moviesLocalDatasourceStorage.getCachedMovies();
        final movies = movieLocals
            .map((movie) => MovieMapper.movieLocalToMovie(movie))
            .toList();

        return movies;
      } catch (e) {
        log("Error to ${e.toString()}");
      }
    }
    return [];
  }
}
