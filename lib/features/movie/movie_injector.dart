import 'package:get_it/get_it.dart';
import 'package:popular_movies/features/movie/domain/repositories/movies_repository.dart';
import 'package:popular_movies/features/movie/infrastructure/datasources/moviedb_datasource_api.dart';
import 'package:popular_movies/features/movie/infrastructure/repositories/movies_repository_impl.dart';
import 'package:popular_movies/features/movie/infrastructure/usecases/uc_get_popular_movies.dart';
import 'package:popular_movies/features/movie/presentation/bloc/movie_bloc.dart';

final dependencyManager = GetIt.instance;

void setupMovieInjector() {
  // Repositorios
  dependencyManager.registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(moviesDatasource: MovieDbDatasourceApi()));

  // Casos de uso
  dependencyManager.registerLazySingleton(
      () => UcGetPopularMoviesNoParams(moviesRepository: dependencyManager()));

  // Bloc
  dependencyManager.registerFactory(
      () => MovieBloc(ucGetPopularmoviesNoParams: dependencyManager()));
}
