part of 'explore_cubit.dart';

@immutable
abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ExploreLoadingState extends ExploreState {}

class ExploreLoadedState extends ExploreState {
  final CategoryFeed top;
  final CategoryFeed recent;

  ExploreLoadedState({required this.top, required this.recent});
}

class ExploreErrorState extends ExploreState {
  final String message;

  ExploreErrorState(this.message);
}
