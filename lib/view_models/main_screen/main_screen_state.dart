part of 'main_screen_cubit.dart';

@immutable
abstract class MainScreenState {}

class MainScreenInitial extends MainScreenState {}

class MainScreenChangeIndexState extends MainScreenState {
  final int index;

  MainScreenChangeIndexState({required this.index});
}
