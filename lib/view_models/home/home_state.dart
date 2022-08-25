part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final CategoryFeed top;
  final CategoryFeed recent;

  HomeLoadedState({required this.top, required this.recent});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
