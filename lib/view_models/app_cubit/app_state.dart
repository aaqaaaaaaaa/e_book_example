part of 'app_bloc.dart';

@immutable
class AppState extends Equatable {
  ThemeData theme;

  AppState(this.theme);

  @override
  List<Object?> get props => [theme];
}
