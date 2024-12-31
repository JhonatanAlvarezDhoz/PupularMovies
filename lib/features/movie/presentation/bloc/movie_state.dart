part of 'movie_bloc.dart';

enum MovieStatus {
  initial,
  success,
  loading,
  error,
}

class MovieState extends Equatable {
  final MovieStatus movieStatus;
  final List<Movie> popularMovies;
  final String message;
  final String errorText;

  const MovieState({
    this.movieStatus = MovieStatus.initial,
    this.popularMovies = const [],
    this.message = "",
    this.errorText = "",
  });

  MovieState copyWith({
    MovieStatus? movieStatus,
    List<Movie>? popularMovies,
    String? message,
    String? errorText,
  }) =>
      MovieState(
          movieStatus: movieStatus ?? this.movieStatus,
          popularMovies: popularMovies ?? this.popularMovies,
          message: message ?? this.message,
          errorText: errorText ?? this.errorText);

  @override
  List<Object?> get props => [
        movieStatus,
        popularMovies,
        message,
        errorText,
      ];
}
