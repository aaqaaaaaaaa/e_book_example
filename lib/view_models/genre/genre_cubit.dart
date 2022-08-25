import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../models/category.dart';
import '../../util/api.dart';
import '../../util/functions.dart';

part 'genre_state.dart';

class GenreCubit extends Cubit<GenreState> {
  GenreCubit() : super(GenreInitial());
  bool loadingMore = false;
  bool loadMore = true;
  final Api api = Api();
  int page = 1;

  listener(url) {
    // controller.addListener(() {
    //   if (controller.position.pixels == controller.position.maxScrollExtent) {
    //     if (!loadingMore) {
    //       paginate(url);
    //       // Animate to bottom of list
    //       Timer(Duration(milliseconds: 100), () {
    //         controller.animateTo(
    //           controller.position.maxScrollExtent,
    //           duration: Duration(milliseconds: 100),
    //           curve: Curves.easeIn,
    //         );
    //       });
    //     }
    //   }
    // });
  }

  getFeed(String url) async {
    emit(GenreLoadingState());
    // setApiRequestStatus(APIRequestStatus.loading);
    print(url);
    try {
      CategoryFeed feed = await api.getCategory(url);
      // setApiRequestStatus(APIRequestStatus.loaded);
      emit(GenreLoadedState(
        items: feed.feed!.entry!,
        loadingMore: loadingMore,
      ));
      listener(url);
    } catch (e) {
      checkError(e);
      throw (e);
    }
  }

  paginate(String url) async {
    if (state is GenreLoadingState && !loadingMore && loadMore) {
      // Timer(Duration(milliseconds: 100), () {
      //   controller.jumpTo(controller.position.maxScrollExtent);
      // });
      loadingMore = true;
      page = page + 1;
      try {
        CategoryFeed feed = await api.getCategory(url + '&page=$page');
        emit(GenreLoadedState(
            items: [...feed.feed!.entry!], loadingMore: loadingMore));
        loadingMore = false;
        // notifyListeners();
      } catch (e) {
        loadMore = false;
        loadingMore = false;
        // notifyListeners();
        throw (e);
      }
    }
  }

  void checkError(e) {
    if (Functions.checkConnectionError(e)) {
      emit(GenreErrorState(e));
      // setApiRequestStatus(APIRequestStatus.connectionError);
      showToast('Connection error');
    } else {
      emit(GenreErrorState('Hatolik'));
      // setApiRequestStatus(APIRequestStatus.error);
      showToast('Something went wrong, please try again');
    }
  }

  showToast(msg) {
    Fluttertoast.showToast(
      msg: '$msg',
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
    );
  }

  // void setApiRequestStatus(APIRequestStatus value) {
  //   apiRequestStatus = value;
  //   // notifyListeners();
  // }
}
