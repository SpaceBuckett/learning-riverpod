import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movies_list/core/enums.dart';
import 'package:movies_list/core/movie_model.dart';
import 'package:movies_list/home.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class FilmsNotifier extends StateNotifier<List<Movie>> {
  FilmsNotifier() : super(allFilms);

  void updateFilm(Movie movie, bool isFavorite) {
    state = state
        .map(
          (thisMovie) => thisMovie.id == movie.id
              ? thisMovie.copy(
                  isFavorite: isFavorite,
                )
              : thisMovie,
        )
        .toList();
  }
}

final favoriteStatusProvider = StateProvider<FavoriteStatus>(
  (_) => FavoriteStatus.all,
);

final allFilmsProvider = StateNotifierProvider<FilmsNotifier, List<Movie>>(
  (_) => FilmsNotifier(),
);

final favFilmsProvider = Provider<Iterable<Movie>>(
  (ref) => ref
      .watch(
        allFilmsProvider,
      )
      .where(
        (movie) => movie.isFavorite,
      ),
);

final nonFavFilmsProvider = Provider<Iterable<Movie>>(
  (ref) => ref
      .watch(
        allFilmsProvider,
      )
      .where(
        (movie) => movie.isFavorite == false,
      ),
);
