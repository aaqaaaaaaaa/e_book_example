import 'package:bloc/bloc.dart';
import 'package:e_book_example/util/api.dart';
import 'package:meta/meta.dart';

import '../../models/category.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial());
  CategoryFeed top = CategoryFeed();
  CategoryFeed recent = CategoryFeed();
  Api api = Api();

  getFeeds() async {
    emit(ExploreLoadingState());
    try {
      CategoryFeed popular = await api.getCategory(Api.popular);
      CategoryFeed newReleases = await api.getCategory(Api.recent);
      emit(ExploreLoadedState(top: popular, recent: newReleases));
    } catch (e) {
      emit(ExploreErrorState(e.toString()));
    }
  }
}
