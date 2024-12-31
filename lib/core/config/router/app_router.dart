// config/routes/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:popular_movies/core/config/ui/pages/base_page.dart';
import 'package:popular_movies/core/config/ui/pages/splash_page.dart';
import 'package:popular_movies/features/movie/domain/entities/movie.dart';
import 'package:popular_movies/features/movie/presentation/pages/detail_movie.dart';
import 'package:popular_movies/features/movie/presentation/pages/movies.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/base',
        builder: (context, state) => const BasePage(),
        routes: [
          GoRoute(
              path: '/movies',
              builder: (context, state) => const MoviePage(),
              routes: [
                GoRoute(
                    path: '/detailsMovie',
                    builder: (context, state) {
                      final Movie movie = state.extra as Movie;
                      return DetailMovie(movie: movie);
                    }),
              ]),
          // GoRoute(
          //   path: 'feature2',
          //   builder: (context, state) => Feature2Page(),
          // ),
        ],
      ),
    ],
  );
}
