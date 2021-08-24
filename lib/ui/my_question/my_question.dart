import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/store/my_question/my_question_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/details_question/details_question.dart';
import 'package:todo_app/ui/home/question_item.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';

class MyQuestionScreen extends StatefulWidget {
  @override
  _MyQuestionScreenState createState() => _MyQuestionScreenState();
}

class _MyQuestionScreenState extends State<MyQuestionScreen> {
  late MyQuestionStore _store;
  late ThemeStore _themeStore;

  int _page = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<MyQuestionStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _store.getQuestion(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() => AppBar(
        title: Text("My Question",
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white)),
      );

  Widget _buildBody() => Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Observer(
              builder: (_) => Visibility(
                visible: _store.success,
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropMaterialHeader(
                    backgroundColor: Theme.of(context).appBarTheme.color,
                  ),
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus? mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = Text("pull up load");
                      } else if (mode == LoadStatus.loading) {
                        body = CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = Text("Load Failed!Click retry!");
                      } else if (mode == LoadStatus.canLoading) {
                        body = Text("release to load more");
                      } else {
                        body = Text("No more Data");
                      }
                      return Container(
                        height: Dimens.paginationLoading,
                        child: Center(child: body),
                      );
                    },
                  ),
                  controller: _store.refreshController,
                  onRefresh: () async {
                    //return page 0 because onLoading function can send request again
                    _page = 0;
                    debugPrint("Pagination onRefresh");
                    await Future.delayed(Duration(milliseconds: 1000));
                    _store.question.clear();
                    await _store.getQuestion(0);
                    _store.refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    debugPrint("Pagination onLoading");
                    await Future.delayed(Duration(milliseconds: 1000));
                    if (!(_page >= _store.question.length) == true) {
                      _page += 6;
                      await _store.getQuestion(_page);
                      _store.refreshController.loadComplete();
                    } else {
                      _store.refreshController.loadComplete();
                    }
                  },
                  child: ListView.builder(
                    itemCount: _store.question.length,
                    itemBuilder: (_, index) => QuestionItem(
                        item: _store.question[index],
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailsQuestionScreen(
                                id: _store.question[index].id!,
                              ),
                            ),
                          );
                          if (result == true) {
                            _store.success = false;
                            _page = 0;
                            _store.question.clear();
                            await _store.getQuestion(0);
                            _store.refreshController.refreshCompleted();
                          }
                        }),
                  ),
                ),
                replacement: StackOverFlowIndecator(),
              ),
            ),
          ),
        ],
      );
}
