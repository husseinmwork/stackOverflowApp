// import 'package:flutter/material.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_app/constants/dimens.dart';
// import 'package:todo_app/model/get_question/get_question.dart';
// import 'package:todo_app/store/my_question/my_question_store.dart';
// import 'package:todo_app/ui/home/question_item.dart';
// import 'package:todo_app/widgets/arrow_back_icon.dart';
// import 'package:todo_app/widgets/stack_overflow_indecator.dart';
//
// class MyQuestionScreen extends StatefulWidget {
//   @override
//   _MyQuestionScreenState createState() => _MyQuestionScreenState();
// }
//
// class _MyQuestionScreenState extends State<MyQuestionScreen> {
//
//   late MyQuestionStore _store;
//
//   Future<void> _fetchPage(int pageKey) async {
//     try {
//       await _store.getQuestion(pageKey);
//       final newItems = _store.question;
//       // fixme this will make another unnecessary request
//       final isLastPage = newItems.isEmpty;
//
//       if (isLastPage) {
//         _store.pagingController.appendLastPage(newItems);
//       } else {
//         final nextPageKey = pageKey + newItems.length;
//         _store.pagingController.appendPage(newItems, nextPageKey);
//       }
//     } catch (error) {
//       _store.pagingController.error = error;
//       debugPrint("$error");
//     }
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _store = Provider.of<MyQuestionStore>(context);
//     _store.pagingController.addPageRequestListener((pageKey) async {
//       _fetchPage(pageKey);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: _buildBody(),
//     );
//   }
//
//   AppBar _buildAppBar() => AppBar(
//     elevation: 4,
//     leading: ArrowBackIcon(),
//     title: Text("My Question",
//         style: Theme.of(context).textTheme.headline6),
//   );
//
//   Widget  _buildBody() =>RefreshIndicator(
//     onRefresh: () async => await Future.sync(() {
//       _store.pagingController.refresh();
//     }),
//     child: PagedListView(
//       pagingController: _store.pagingController,
//       builderDelegate: PagedChildBuilderDelegate<Question>(
//         firstPageProgressIndicatorBuilder: (_) => StackOverFlowIndecator(),
//         noItemsFoundIndicatorBuilder: (_) => Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: Dimens.padding_xl),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.search, color: Colors.lightBlueAccent),
//                 SizedBox(width: Dimens.padding_mini),
//                 Text(
//                   "no_result_found",
//                   style:
//                   TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         itemBuilder: (context, item, index) => QuestionItem(
//             item: item,
//             onTap: () {
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (_) => DetailsQuestionScreen(
//               //         userId: _store.user!.id.toString(),
//               //         id: item.id!,
//               //         myImage: _store.user!.image.toString())));
//             }),
//       ),
//     ),
//   );
// }
