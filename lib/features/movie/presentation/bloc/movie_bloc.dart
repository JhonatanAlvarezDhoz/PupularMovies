import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:popular_movies/core/exceptions/exceptions.dart';
import 'package:popular_movies/features/movie/domain/entities/movie.dart';
import 'package:popular_movies/features/movie/infrastructure/usecases/uc_get_popular_movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final UcGetPopularMoviesNoParams ucGetPopularmoviesNoParams;
  MovieBloc({required this.ucGetPopularmoviesNoParams})
      : super(const MovieState()) {
    on<GetPopularMoviesEvent>(_getPopularMoviess);
  }

  void _getPopularMoviess(
      GetPopularMoviesEvent event, Emitter<MovieState> emit) async {
    try {
      emit(state.copyWith(movieStatus: MovieStatus.loading));
      final List<Movie> popularMovies = await ucGetPopularmoviesNoParams.call();
      if (popularMovies.runtimeType == List<Movie>) {
        emit(state.copyWith(
            popularMovies: popularMovies, movieStatus: MovieStatus.success));
      }
    } on NotFoundException catch (e) {
      emit(state.copyWith(
          movieStatus: MovieStatus.error, errorText: e.toString()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(
          movieStatus: MovieStatus.error, errorText: e.toString()));
    } on UnauthorizedException catch (e) {
      emit(state.copyWith(
          movieStatus: MovieStatus.error, errorText: e.toString()));
    } catch (e) {
      emit(state.copyWith(
          movieStatus: MovieStatus.error, errorText: e.toString()));
    }
  }
}
