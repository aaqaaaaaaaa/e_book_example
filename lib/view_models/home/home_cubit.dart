import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/category.dart';
import '../../util/api.dart';
import '../../util/enum/api_request_status.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  CategoryFeed top = CategoryFeed();
  CategoryFeed recent = CategoryFeed();
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  Api api = Api();

  getFeeds() async {
    emit(HomeLoadingState());
    try {
      CategoryFeed popular = await api.getCategory(Api.popular);
      CategoryFeed newReleases = await api.getCategory(Api.recent);
      emit(HomeLoadedState(top: popular, recent: newReleases));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

}
