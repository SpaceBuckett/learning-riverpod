import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movies_list/core/enums.dart';
import 'package:movies_list/core/movie_model.dart';
import 'package:movies_list/main.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Column(
        children: [
          const FilterWidget(),
          Consumer(
            builder: (context, ref, child) {
              final filter = ref.watch(favoriteStatusProvider);
              switch (filter) {
                case FavoriteStatus.all:
                  return MoviesList(
                    provider: allFilmsProvider,
                  );
                case FavoriteStatus.favorites:
                  return MoviesList(
                    provider: favFilmsProvider,
                  );
                case FavoriteStatus.nonFavorites:
                  return MoviesList(
                    provider: nonFavFilmsProvider,
                  );
              }
            },
          )
        ],
      ),
    );
  }
}

class MoviesList extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Movie>> provider;
  const MoviesList({
    required this.provider,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(provider);
    return Expanded(
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies.elementAt(index);
          final movieIcon = movie.isFavorite
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border);
          return ListTile(
            title: Text(movie.name),
            subtitle: Text(movie.description),
            trailing: IconButton(
              onPressed: () {
                final isFavorite = !movie.isFavorite;
                ref
                    .read(
                      allFilmsProvider.notifier,
                    )
                    .updateFilm(
                      movie,
                      isFavorite,
                    );
              },
              icon: movieIcon,
            ),
          );
        },
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return DropdownButton(
          value: ref.watch(favoriteStatusProvider),
          items: FavoriteStatus.values
              .map(
                (fs) => DropdownMenuItem(
                  value: fs,
                  child: Text(
                    fs.toString().split('.').last,
                  ),
                ),
              )
              .toList(),
          onChanged: (FavoriteStatus? fs) {
            ref.read(favoriteStatusProvider.notifier).state = fs!;
          },
        );
      },
    );
  }
}
