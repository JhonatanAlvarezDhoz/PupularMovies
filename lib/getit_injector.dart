import 'package:get_it/get_it.dart';
import 'package:popular_movies/features/movie/movie_injector.dart';

final dependencyManager = GetIt.instance;

void setupInjector() {
  // Configuración global
  // Aquí puedes agregar dependencias compartidas (core, servicios, etc.)

  // Configuración por feature
  setupMovieInjector();
}
