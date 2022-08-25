part of 'genre_cubit.dart';

@immutable
abstract class GenreState {}

class GenreInitial extends GenreState {}

class GenreLoadingState extends GenreState {}

class GenreLoadedState extends GenreState {
  final List items;
  final bool loadingMore;

  GenreLoadedState({
    required this.items,
    required this.loadingMore,
  });
}

class GenreErrorState extends GenreState {
  final String message;

  GenreErrorState(this.message);
}
