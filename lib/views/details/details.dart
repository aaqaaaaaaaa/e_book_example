// import 'package:cached_network_image/cached_network_image.dart';
//
// // import 'package:epub_viewer/epub_viewer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
//
// import 'package:flutter_icons/flutter_icons.dart';
//
// import 'package:provider/provider.dart';
// import 'package:share/share.dart';
//
// import '../../components/description_text.dart';
// import '../../components/loading_widget.dart';
// import '../../models/category.dart';
//
// class Details extends StatefulWidget {
//   final Entry entry;
//   final String imgTag;
//   final String titleTag;
//   final String authorTag;
//
//   Details({
//     Key? key,
//     required this.entry,
//     required this.imgTag,
//     required this.titleTag,
//     required this.authorTag,
//   }) : super(key: key);
//
//   @override
//   _DetailsState createState() => _DetailsState();
// }
//
// class _DetailsState extends State<Details> {
//   @override
//   void initState() {
//     super.initState();
//     // SchedulerBinding.instance.addPostFrameCallback(
//     //   (_) {
//     //     Provider.of<DetailsProvider>(context, listen: false)
//     //         .setEntry(widget.entry);
//     //     Provider.of<DetailsProvider>(context, listen: false)
//     //         .getFeed(widget.entry.author!.uri!.t!.replaceAll(r'\&lang=en', ''));
//     //   },
//     // );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: <Widget>[
//           IconButton(
//             onPressed: () async {
//               if (detailsProvider.faved) {
//                 detailsProvider.removeFav();
//               } else {
//                 detailsProvider.addFav();
//               }
//             },
//             icon: Icon(
//               detailsProvider.faved ? Icons.favorite : Feather.heart,
//               color: detailsProvider.faved
//                   ? Colors.red
//                   : Theme.of(context).iconTheme.color,
//             ),
//           ),
//           IconButton(
//             onPressed: () => _share(),
//             icon: Icon(
//               Feather.share,
//             ),
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: EdgeInsets.symmetric(horizontal: 20.0),
//         children: <Widget>[
//           SizedBox(height: 10.0),
//           _buildImageTitleSection(detailsProvider),
//           SizedBox(height: 30.0),
//           _buildSectionTitle('Book Description'),
//           _buildDivider(),
//           SizedBox(height: 10.0),
//           DescriptionTextWidget(
//             text: '${widget.entry.summary!.t}',
//           ),
//           SizedBox(height: 30.0),
//           _buildSectionTitle('More from Author'),
//           _buildDivider(),
//           SizedBox(height: 10.0),
//           _buildMoreBook(detailsProvider),
//         ],
//       ),
//     );
//   }
//
//   _buildDivider() {
//     return Divider(
//       color: Theme.of(context).textTheme.caption!.color,
//     );
//   }
//   //
//   _buildImageTitleSection(DetailsProvider detailsProvider) {
//     return Container(
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Hero(
//             tag: widget.imgTag,
//             child: CachedNetworkImage(
//               imageUrl: '${widget.entry.link![1].href}',
//               placeholder: (context, url) => Container(
//                 height: 200.0,
//                 width: 130.0,
//                 child: LoadingWidget(),
//               ),
//               errorWidget: (context, url, error) => Icon(Feather.x),
//               fit: BoxFit.cover,
//               height: 200.0,
//               width: 130.0,
//             ),
//           ),
//           SizedBox(width: 20.0),
//           Flexible(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(height: 5.0),
//                 Hero(
//                   tag: widget.titleTag,
//                   child: Material(
//                     type: MaterialType.transparency,
//                     child: Text(
//                       '${widget.entry.title!.t!.replaceAll(r'\', '')}',
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 3,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 5.0),
//                 Hero(
//                   tag: widget.authorTag,
//                   child: Material(
//                     type: MaterialType.transparency,
//                     child: Text(
//                       '${widget.entry.author!.name!.t}',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 5.0),
//                 _buildCategory(widget.entry, context),
//                 Center(
//                   child: Container(
//                     height: 50.0,
//                     width: MediaQuery.of(context).size.width,
//                     child: _buildDownloadReadButton(detailsProvider, context),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   //
//   // _buildSectionTitle(String title) {
//   //   return Text(
//   //     '$title',
//   //     style: TextStyle(
//   //       color: Theme.of(context).colorScheme.secondary,
//   //       fontSize: 20.0,
//   //       fontWeight: FontWeight.bold,
//   //     ),
//   //   );
//   // }
//   //
//   // _buildMoreBook(DetailsProvider provider) {
//   //   if (provider.loading) {
//   //     return Container(
//   //       height: 100.0,
//   //       child: LoadingWidget(),
//   //     );
//   //   } else {
//   //     return ListView.builder(
//   //       shrinkWrap: true,
//   //       physics: NeverScrollableScrollPhysics(),
//   //       itemCount: provider.related.feed!.entry!.length,
//   //       itemBuilder: (BuildContext context, int index) {
//   //         Entry entry = provider.related.feed!.entry![index];
//   //         return Padding(
//   //           padding: EdgeInsets.symmetric(vertical: 5.0),
//   //           child: BookListItem(
//   //             entry: entry,
//   //           ),
//   //         );
//   //       },
//   //     );
//   //   }
//   // }
//   //
//   openBook(DetailsProvider provider) async {
//     List dlList = await provider.getDownload();
//     if (dlList.isNotEmpty) {
//       // dlList is a list of the downloads relating to this Book's id.
//       // The list will only contain one item since we can only
//       // download a book once. Then we use `dlList[0]` to choose the
//       // first value from the string as out local book path
//       Map dl = dlList[0];
//       String path = dl['path'];
//
//       MyRouter.pushPage(context, EpubScreen.fromPath(filePath: path));
//     }
//   }
//   //
//   _buildDownloadReadButton(DetailsProvider provider, BuildContext context) {
//     if (provider.downloaded) {
//       return TextButton(
//         onPressed: () => openBook(provider),
//         child: Text(
//           'Read Book',
//           style: TextStyle(fontSize: 13, color: Colors.black),
//         ),
//       );
//     } else {
//       return TextButton(
//         onPressed: () => provider.downloadFile(
//           context,
//           widget.entry.link![3].href!,
//           widget.entry.title!.t!.replaceAll(' ', '_').replaceAll(r"\'", "'"),
//         ),
//         child: Text(
//           'Download',
//           style: TextStyle(fontSize: 13, color: Colors.black),
//         ),
//       );
//     }
//   }
//
//   _buildCategory(Entry entry, BuildContext context) {
//     if (entry.category == null) {
//       return SizedBox();
//     } else {
//       return Container(
//         height: entry.category!.length < 3 ? 55.0 : 95.0,
//         child: GridView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: entry.category!.length > 4 ? 4 : entry.category!.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 210 / 80,
//           ),
//           itemBuilder: (BuildContext context, int index) {
//             Category cat = entry.category![index];
//             return Padding(
//               padding: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).backgroundColor,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(20),
//                   ),
//                   border: Border.all(
//                     color: Theme.of(context).colorScheme.secondary,
//                   ),
//                 ),
//                 child: Center(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 2.0),
//                     child: Text(
//                       '${cat.label}',
//                       style: TextStyle(
//                         color: Theme.of(context).colorScheme.secondary,
//                         fontSize: cat.label!.length > 18 ? 6.0 : 10.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//   }
//
//   _share() {
//     Share.share('${widget.entry.title!.t} by ${widget.entry.author!.name!.t}'
//         'Read/Download ${widget.entry.title!.t} from ${widget.entry.link![3].href}.');
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_book_example/components/description_text.dart';
import 'package:e_book_example/view_models/details/details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:share/share.dart';

import '../../components/book_list_item.dart';
import '../../components/loading_widget.dart';
import '../../models/category.dart';

class Details extends StatefulWidget {
  const Details(
      {Key? key,
      required this.entry,
      required this.imgTag,
      required this.titleTag,
      required this.authorTag})
      : super(key: key);
  final Entry entry;
  final String imgTag;
  final String titleTag;
  final String authorTag;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit(),
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if (state is DetailsInitial) {
            context.read<DetailsCubit>().getFeed(
                widget.entry.author!.uri!.t!.replaceAll(r'\&lang=en', ''));
          } else if (state is DetailsLoadedState) {
            return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  IconButton(
                    onPressed: () async {
                      if (state.faved) {
                        context.read<DetailsCubit>().removeFav();
                      } else {
                        context.read<DetailsCubit>().addFav();
                      }
                    },
                    icon: Icon(
                      state.faved ? Icons.favorite : Feather.heart,
                      color: state.faved
                          ? Colors.red
                          : Theme.of(context).iconTheme.color,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _share(),
                    icon: Icon(Feather.share),
                  ),
                ],
              ),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: widget.imgTag,
                          child: CachedNetworkImage(
                            imageUrl: '${widget.entry.link![1].href}',
                            placeholder: (context, url) => Container(
                              height: 200.0,
                              width: 130.0,
                              child: LoadingWidget(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Feather.x),
                            fit: BoxFit.cover,
                            height: 200.0,
                            width: 130.0,
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 5.0),
                              Hero(
                                tag: widget.titleTag,
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    '${widget.entry.title!.t!.replaceAll(r'\', '')}',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Hero(
                                tag: widget.authorTag,
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    '${widget.entry.author!.name!.t}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              _buildCategory(widget.entry, context),
                              Center(
                                child: Container(
                                  height: 50.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: (state.downloaded)
                                      ? TextButton(
                                          onPressed: () {
                                            // openBook(
                                            //   context.read<DetailsCubit>());
                                          },
                                          child: Text(
                                            'Read Book',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white),
                                          ),
                                        )
                                      : TextButton(
                                          onPressed: () => context
                                              .read<DetailsCubit>()
                                              .downloadFile(
                                                context,
                                                widget.entry.link![3].href!,
                                                widget.entry.title!.t!
                                                    .replaceAll(' ', '_')
                                                    .replaceAll(r"\'", "'"),
                                              ),
                                          child: Text(
                                            'Download',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _buildSectionTitle('Book Description'),
                  _buildDivider(),
                  SizedBox(height: 10.0),
                  DescriptionTextWidget(
                    text: '${widget.entry.summary!.t}',
                  ),
                  SizedBox(height: 30.0),
                  _buildSectionTitle('More from Author'),
                  _buildDivider(),
                  SizedBox(height: 10.0),
                  (state.loading)
                      ? Container(
                          height: 100.0,
                          child: LoadingWidget(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.related.feed!.entry!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Entry entry = state.related.feed!.entry![index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: BookListItem(
                                entry: entry,
                              ),
                            );
                          },
                        ),
                ],
              ),
            );
          }
          return Scaffold();
        },
      ),
    );
  }

  _buildDivider() {
    return Divider(
      color: Theme.of(context).textTheme.caption!.color,
    );
  }

  // _buildImageTitleSection(DetailsState state) {
  //   return Container(
  //     child: Row(
  //       mainAxisSize: MainAxisSize.max,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Hero(
  //           tag: widget.imgTag,
  //           child: CachedNetworkImage(
  //             imageUrl: '${widget.entry.link![1].href}',
  //             placeholder: (context, url) => Container(
  //               height: 200.0,
  //               width: 130.0,
  //               child: LoadingWidget(),
  //             ),
  //             errorWidget: (context, url, error) => Icon(Feather.x),
  //             fit: BoxFit.cover,
  //             height: 200.0,
  //             width: 130.0,
  //           ),
  //         ),
  //         SizedBox(width: 20.0),
  //         Flexible(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.max,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               SizedBox(height: 5.0),
  //               Hero(
  //                 tag: widget.titleTag,
  //                 child: Material(
  //                   type: MaterialType.transparency,
  //                   child: Text(
  //                     '${widget.entry.title!.t!.replaceAll(r'\', '')}',
  //                     style: TextStyle(
  //                       fontSize: 20.0,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                     maxLines: 3,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 5.0),
  //               Hero(
  //                 tag: widget.authorTag,
  //                 child: Material(
  //                   type: MaterialType.transparency,
  //                   child: Text(
  //                     '${widget.entry.author!.name!.t}',
  //                     style: TextStyle(
  //                       fontSize: 16.0,
  //                       fontWeight: FontWeight.w800,
  //                       color: Colors.grey,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 5.0),
  //               _buildCategory(widget.entry, context),
  //               Center(
  //                 child: Container(
  //                     height: 50.0,
  //                     width: MediaQuery.of(context).size.width,
  //                     child: (state.downloaded)
  //                         ? TextButton(
  //                             onPressed: () => openBook(provider),
  //                             child: Text(
  //                               'Read Book',
  //                               style: TextStyle(
  //                                   fontSize: 13, color: Colors.black),
  //                             ),
  //                           )
  //                         : TextButton(
  //                             onPressed: () => provider.downloadFile(
  //                               context,
  //                               widget.entry.link![3].href!,
  //                               widget.entry.title!.t!
  //                                   .replaceAll(' ', '_')
  //                                   .replaceAll(r"\'", "'"),
  //                             ),
  //                             child: Text(
  //                               'Download',
  //                               style: TextStyle(
  //                                   fontSize: 13, color: Colors.black),
  //                             ),
  //                           )),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  _buildSectionTitle(String title) {
    return Text(
      '$title',
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

// _buildMoreBook(DetailsLoadedState state) {
//   if (state.loading) {
//     return Container(
//       height: 100.0,
//       child: LoadingWidget(),
//     );
//   } else {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: state.related.feed!.entry!.length,
//       itemBuilder: (BuildContext context, int index) {
//         Entry entry = provider.related.feed!.entry![index];
//         return Padding(
//           padding: EdgeInsets.symmetric(vertical: 5.0),
//           child: BookListItem(
//             entry: entry,
//           ),
//         );
//       },
//     );
//   }
// }

  // openBook(DetailsCubit provider) async {
  //   List dlList = await provider.getDownload();
  //   if (dlList.isNotEmpty) {
  //     // dlList is a list of the downloads relating to this Book's id.
  //     // The list will only contain one item since we can only
  //     // download a book once. Then we use `dlList[0]` to choose the
  //     // first value from the string as out local book path
  //     Map dl = dlList[0];
  //     String path = dl['path'];
  //
  //     // MyRouter.pushPage(context, EpubScreen.fromPath(filePath: path));
  //   }
  // }

// _buildDownloadReadButton(DetailsProvider provider, BuildContext context) {
//   if (provider.downloaded) {
//     return TextButton(
//       onPressed: () => openBook(provider),
//       child: Text(
//         'Read Book',
//         style: TextStyle(fontSize: 13, color: Colors.black),
//       ),
//     );
//   } else {
//     return TextButton(
//       onPressed: () => provider.downloadFile(
//         context,
//         widget.entry.link![3].href!,
//         widget.entry.title!.t!.replaceAll(' ', '_').replaceAll(r"\'", "'"),
//       ),
//       child: Text(
//         'Download',
//         style: TextStyle(fontSize: 13, color: Colors.black),
//       ),
//     );
//   }
// }

  _buildCategory(Entry entry, BuildContext context) {
    if (entry.category == null) {
      return SizedBox();
    } else {
      return Container(
        height: entry.category!.length < 3 ? 55.0 : 95.0,
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: entry.category!.length > 4 ? 4 : entry.category!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 210 / 80,
          ),
          itemBuilder: (BuildContext context, int index) {
            Category cat = entry.category![index];
            return Padding(
              padding: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      '${cat.label}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: cat.label!.length > 18 ? 6.0 : 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  _share() {
    Share.share('${widget.entry.title!.t} by ${widget.entry.author!.name!.t}'
        'Read/Download ${widget.entry.title!.t} from ${widget.entry.link![3].href}.');
  }
}
