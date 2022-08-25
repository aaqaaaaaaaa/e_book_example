import 'dart:async';

import 'package:e_book_example/components/book_list_item.dart';
import 'package:e_book_example/components/loading_widget.dart';
import 'package:e_book_example/models/category.dart';
import 'package:e_book_example/view_models/genre/genre_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Genre extends StatefulWidget {
  final String title;
  final String url;

  Genre({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (!context.read<GenreCubit>().loadingMore) {
          context.read<GenreCubit>().paginate(widget.url);
          // Animate to bottom of list
          Timer(Duration(milliseconds: 100), () {
            controller.animateTo(
              controller.position.maxScrollExtent,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeIn,
            );
          });
        }
      }
    });
    // SchedulerBinding.instance.addPostFrameCallback(
    //   (_) => Provider.of<GenreProvider>(context, listen: false)
    //       .getFeed(widget.url),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenreCubit(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('${widget.title}'),
        ),
        body: BlocBuilder<GenreCubit, GenreState>(
          builder: (context, state) {
            if (state is GenreInitial) {
              context.read<GenreCubit>().getFeed(widget.url);
            } else if (state is GenreLoadedState) {
              return ListView(
                controller: controller,
                children: <Widget>[
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    shrinkWrap: true,
                    itemCount: state.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      Entry entry = state.items[index];
                      return Padding(
                        padding: EdgeInsets.all(5.0),
                        child: BookListItem(
                          entry: entry,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.0),
                  state.loadingMore
                      ? Container(
                          height: 80.0,
                          child: _buildProgressIndicator(),
                        )
                      : SizedBox(),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  // Widget _buildBody(GenreProvider provider) {
  //   return BodyBuilder(
  //     apiRequestStatus: provider.apiRequestStatus,
  //     child: _buildBodyList(provider),
  //     reload: () => provider.getFeed(widget.url),
  //   );
  // }
  //
  // _buildBodyList(GenreProvider provider) {
  //   return ListView(
  //     controller: provider.controller,
  //     children: <Widget>[
  //       ListView.builder(
  //         physics: NeverScrollableScrollPhysics(),
  //         padding: EdgeInsets.symmetric(horizontal: 10.0),
  //         shrinkWrap: true,
  //         itemCount: provider.items.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           Entry entry = provider.items[index];
  //           return Padding(
  //             padding: EdgeInsets.all(5.0),
  //             child: BookListItem(
  //               entry: entry,
  //             ),
  //           );
  //         },
  //       ),
  //       SizedBox(height: 10.0),
  //       provider.loadingMore
  //           ? Container(
  //               height: 80.0,
  //               child: _buildProgressIndicator(),
  //             )
  //           : SizedBox(),
  //     ],
  //   );
  // }

  _buildProgressIndicator() {
    return LoadingWidget();
  }
}
