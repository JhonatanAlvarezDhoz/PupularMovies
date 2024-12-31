// ignore_for_file: depend_on_referenced_packages

import 'package:popular_movies/features/movie/infrastructure/datasources/moviedb_datasource_api.dart';
import 'package:popular_movies/features/movie/infrastructure/repositories/movies_repository_impl.dart';
import 'package:popular_movies/features/movie/infrastructure/usecases/uc_get_popular_movies.dart';
import 'package:popular_movies/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Injector {
  static List<SingleChildWidget> dependencies = [
    BlocProvider(
        create: (_) => MovieBloc(
            ucGetPopularmoviesNoParams: UcGetPopularMoviesNoParams(
                moviesRepository: MoviesRepositoryImpl(
                    moviesDatasource: MovieDbDatasourceApi())))),
  ];
}
