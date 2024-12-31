import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_movies/core/config/theme/app_colors.dart';
import 'package:popular_movies/core/widgets/widgets.dart';
import 'package:popular_movies/features/movie/domain/entities/movie.dart';
import 'package:popular_movies/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:popular_movies/features/movie/presentation/widgets/custom_card.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(GetPopularMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return BlocConsumer<MovieBloc, MovieState>(
          listener: (BuildContext context, MovieState state) {
            if (state.movieStatus == MovieStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                  message: state.errorText, color: AppColors.error));
            }
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: ListView.builder(
                  itemCount: state.popularMovies.length,
                  itemBuilder: (context, index) {
                    final Movie movie = state.popularMovies[index];
                    return AnimatedEntryWidget(
                      type: AnimationType.slideInFromLeft,
                      duration: const Duration(seconds: 1),
                      child: CustomCard(
                        movie: movie,
                        constraints: constraints,
                      ),
                    );
                  }),
            );
          },
        );
      }),
    );
  }
}
