import 'package:e_book_example/components/book_card.dart';
import 'package:e_book_example/components/loading_widget.dart';
import 'package:e_book_example/models/category.dart';
import 'package:e_book_example/util/api.dart';
import 'package:e_book_example/util/router.dart';
import 'package:e_book_example/view_models/explore/explore_cubit.dart';
import 'package:e_book_example/views/genre/genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(builder: (context, state) {
      if (state is ExploreInitial) {
        context.read<ExploreCubit>().getFeeds();
      } else if (state is ExploreLoadingState) {
        return Center(child: LoadingWidget());
      } else if (state is ExploreLoadedState) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Explore'),
          ),
          body: ListView.builder(
            itemCount: state.top.feed?.link?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              Link link = state.top.feed!.link![index];
              if (index < 10) {
                return SizedBox();
              }

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    _buildSectionHeader(link),
                    SizedBox(height: 10.0),
                    _buildSectionBookList(link),
                  ],
                ),
              );
            },
          ),
        );
      }
      return Scaffold();
    });
  }

  _buildSectionHeader(Link link) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              '${link.title}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              MyRouter.pushPage(
                context,
                Genre(
                  title: '${link.title}',
                  url: link.href!,
                ),
              );
            },
            child: Text(
              'See All',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildSectionBookList(Link link) {
    return FutureBuilder<CategoryFeed>(
      future: api.getCategory(link.href!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          CategoryFeed category = snapshot.data!;

          return Container(
            height: 200.0,
            child: Center(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                scrollDirection: Axis.horizontal,
                itemCount: category.feed!.entry!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Entry entry = category.feed!.entry![index];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 10.0,
                    ),
                    child: BookCard(
                      img: entry.link![1].href!,
                      entry: entry,
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Container(
            height: 200.0,
            child: LoadingWidget(),
          );
        }
      },
    );
  }
}
