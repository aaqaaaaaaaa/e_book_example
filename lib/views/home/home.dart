import 'package:e_book_example/components/loading_widget.dart';
import 'package:e_book_example/models/category.dart';
import 'package:e_book_example/view_models/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/book_card.dart';
import '../../components/book_list_item.dart';
import '../../util/consts.dart';
import '../../util/router.dart';
import '../genre/genre.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          context.read<HomeCubit>().getFeeds();
        } else if (state is HomeLoadingState) {
          return Center(child: LoadingWidget());
        } else if (state is HomeLoadedState) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '${Constants.appName}',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().getFeeds(),
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    child: Center(
                      child: ListView.builder(
                        primary: false,
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.top.feed?.entry?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          Entry entry = state.top.feed!.entry![index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 10.0),
                            child: BookCard(
                              img: entry.link![1].href!,
                              entry: entry,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _buildSectionTitle('Categories'),
                  SizedBox(height: 10.0),
                  Container(
                    height: 50.0,
                    child: Center(
                      child: ListView.builder(
                        primary: false,
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.top.feed?.link?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          Link link = state.top.feed!.link![index];

                          // We don't need the tags from 0-9 because
                          // they are not categories
                          if (index < 10) {
                            return SizedBox();
                          }

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                onTap: () {
                                  MyRouter.pushPage(
                                    context,
                                    Genre(
                                      title: '${link.title}',
                                      url: link.href!,
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      '${link.title}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // _buildGenreSection(homeProvider),
                  SizedBox(height: 20.0),
                  _buildSectionTitle('Recently Added'),
                  SizedBox(height: 20.0),
                  ListView.builder(
                    primary: false,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.recent.feed?.entry?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Entry entry = state.recent.feed!.entry![index];

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        child: BookListItem(
                          entry: entry,
                        ),
                      );
                    },
                  )
                  // _buildNewSection(homeProvider),
                ],
              ),
            ),
          );
        } else if (state is HomeErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        return Container();
      },
      // ),
    );
  }

  // Widget _buildBodyList(HomeProvider homeProvider) {
  //   return RefreshIndicator(
  //     onRefresh: () => homeProvider.getFeeds(),
  //     child: ListView(
  //       children: <Widget>[
  //         _buildFeaturedSection(homeProvider),
  //         SizedBox(height: 20.0),
  //         _buildSectionTitle('Categories'),
  //         SizedBox(height: 10.0),
  //         _buildGenreSection(homeProvider),
  //         SizedBox(height: 20.0),
  //         _buildSectionTitle('Recently Added'),
  //         SizedBox(height: 20.0),
  //         _buildNewSection(homeProvider),
  //       ],
  //     ),
  //   );
  // }

  _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

// _buildFeaturedSection(HomeProvider homeProvider) {
//   return Container(
//     height: 200.0,
//     child: Center(
//       child: ListView.builder(
//         primary: false,
//         padding: EdgeInsets.symmetric(horizontal: 15.0),
//         scrollDirection: Axis.horizontal,
//         itemCount: homeProvider.top.feed?.entry?.length ?? 0,
//         shrinkWrap: true,
//         itemBuilder: (BuildContext context, int index) {
//           Entry entry = homeProvider.top.feed!.entry![index];
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
//             child: BookCard(
//               img: entry.link![1].href!,
//               entry: entry,
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }

// _buildGenreSection(HomeProvider homeProvider) {
//   return Container(
//     height: 50.0,
//     child: Center(
//       child: ListView.builder(
//         primary: false,
//         padding: EdgeInsets.symmetric(horizontal: 15.0),
//         scrollDirection: Axis.horizontal,
//         itemCount: homeProvider.top.feed?.link?.length ?? 0,
//         shrinkWrap: true,
//         itemBuilder: (BuildContext context, int index) {
//           Link link = homeProvider.top.feed!.link![index];
//
//           // We don't need the tags from 0-9 because
//           // they are not categories
//           if (index < 10) {
//             return SizedBox();
//           }
//
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.secondary,
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(20.0),
//                 ),
//               ),
//               child: InkWell(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(20.0),
//                 ),
//                 onTap: () {
//                   MyRouter.pushPage(
//                     context,
//                     Genre(
//                       title: '${link.title}',
//                       url: link.href!,
//                     ),
//                   );
//                 },
//                 child: Center(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Text(
//                       '${link.title}',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }

// _buildNewSection(HomeProvider homeProvider) {
//   return ListView.builder(
//     primary: false,
//     padding: EdgeInsets.symmetric(horizontal: 15.0),
//     shrinkWrap: true,
//     physics: NeverScrollableScrollPhysics(),
//     itemCount: homeProvider.recent.feed?.entry?.length ?? 0,
//     itemBuilder: (BuildContext context, int index) {
//       Entry entry = homeProvider.recent.feed!.entry![index];
//
//       return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
//         child: BookListItem(
//           entry: entry,
//         ),
//       );
//     },
//   );
// }
}
