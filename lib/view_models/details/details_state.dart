part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoadingState extends DetailsState {}

class DetailsLoadedState extends DetailsState {
  // final List items;
  final bool faved;
  final bool loading;
  final bool downloaded;
  CategoryFeed related = CategoryFeed();

  DetailsLoadedState({
    // required this.items,
    required this.faved,
    required this.related,
    required this.loading,
    required this.downloaded,
  });
}

class DetailsErrorState extends DetailsState {
  final String message;

  DetailsErrorState(this.message);
}
