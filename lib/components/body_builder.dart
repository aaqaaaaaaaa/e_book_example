// import 'package:flutter/material.dart';
// import 'package:e_book_example/components/error_widget.dart';
// import 'package:e_book_example/components/loading_widget.dart';
// import 'package:e_book_example/util/enum/api_request_status.dart';
//
// class BodyBuilder extends StatelessWidget {
//   final APIRequestStatus apiRequestStatus;
//   final Widget child;
//   final Function reload;
//
//   BodyBuilder(
//       {Key? key,
//       required this.apiRequestStatus,
//       required this.child,
//       required this.reload})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   Widget _buildBody() {
//     switch (apiRequestStatus) {
//       case APIRequestStatus.loading:
//         return LoadingWidget();
//       case APIRequestStatus.unInitialized:
//         return LoadingWidget();
//       case APIRequestStatus.connectionError:
//         return MyErrorWidget(
//           refreshCallBack: reload,
//           isConnection: true,
//         );
//       case APIRequestStatus.error:
//         return MyErrorWidget(
//           refreshCallBack: reload,
//           isConnection: false,
//         );
//       case APIRequestStatus.loaded:
//         return child;
//       default:
//         return LoadingWidget();
//     }
//   }
// }
