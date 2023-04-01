import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

@immutable
class Movie {
  final String id;
  final String name;
  final String description;
  final bool isFavorite;

  const Movie({
    required this.id,
    required this.name,
    required this.description,
    required this.isFavorite,
  });

  Movie copy({required bool isFavorite}) => Movie(
        id: id,
        name: name,
        description: description,
        isFavorite: isFavorite,
      );

  String get displayDescription => "Description for $name";

  @override
  bool operator ==(covariant Movie other) =>
      id == other.id && isFavorite == other.isFavorite;

  @override
  int get hashCode => Object.hashAll(
        [
          id,
          isFavorite,
        ],
      );

  @override
  String toString() =>
      'Movie (name: $name, description: $description, isFavorite: $isFavorite)';
}

var allFilms = [
  Movie(
    id: const Uuid().v4(),
    name: 'Harry Potter',
    description: 'Description for Harry Potter',
    isFavorite: false,
  ),
  Movie(
    id: const Uuid().v4(),
    name: 'Spiderman',
    description: 'Description for Spiderman',
    isFavorite: false,
  ),
  Movie(
    id: const Uuid().v4(),
    name: 'Home Alone',
    description: 'Description for Home Alone',
    isFavorite: false,
  ),
  Movie(
    id: const Uuid().v4(),
    name: 'Night Agent',
    description: 'Description for Night Agent',
    isFavorite: false,
  ),
];


