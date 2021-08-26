import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/packages/toast.dart';
import 'package:todo_app/store/details_question/details_question_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/answers/answers.dart';
import 'package:todo_app/ui/create_question/create_question.dart';
import 'package:todo_app/utils/todo/todo_utils.dart';
import 'package:todo_app/widgets/like.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';
import 'package:todo_app/widgets/stackoverflow_popup_menu.dart';

class DetailsQuestionScreen extends StatefulWidget {
  const DetailsQuestionScreen({required this.id});

  final String id;

  @override
  _DetailsQuestionScreenState createState() => _DetailsQuestionScreenState();
}

class _DetailsQuestionScreenState extends State<DetailsQuestionScreen> {
  late DetailsQuestionStore _store;
  late ThemeStore _themeStore;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _store = Provider.of<DetailsQuestionStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _store.questionId = widget.id;
    _store.getPrefUser();
    await _store.getQuestion();
  }

  @override
  void dispose() {
    super.dispose();
    _store.successGetQuestion = false;
    _store.loadingDeleteQuestion = false;
    _store.questionId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
      elevation: 4,
      title: Text("Details Question",
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.white)));

  Widget _buildBody() => Stack(
        children: [
          Observer(
            builder: (_) => (_store.successGetQuestion)
                ? ListView(
                    children: [
                      _buildTitleAndBody(),
                      SizedBox(height: Dimens.padding_normal),
                      _buildTags(),
                      SizedBox(height: Dimens.padding_normal),
                      _buildAllIcon(),
                    ],
                  )
                : StackOverFlowIndecator(),
          ),
          Observer(
              builder: (_) => Visibility(
                  visible: _store.loadingDeleteQuestion == true,
                  child: Center(child: StackOverFlowIndecator())))
        ],
      );

  Widget _buildTitleAndBody() => Padding(
        padding: const EdgeInsets.only(
            left: Dimens.padding_mid,
            right: Dimens.padding_mid,
            top: Dimens.padding_mid),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _store.question?.title ?? "",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: Dimens.padding_normal),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.padding_normal),
                child: Text(
                  _store.question?.body ?? "",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            )
          ],
        ),
      );

  Widget _buildTags() => Padding(
        padding: const EdgeInsets.only(
            left: Dimens.padding_mid, right: Dimens.padding_mid),
        child: Wrap(
          children: [
            if (_store.question?.tags != null)
              ..._store.question!.tags!
                  .map((e) => Container(
                        color: Theme.of(context).accentColor,
                        padding: EdgeInsets.all(Dimens.padding_normal),
                        margin: EdgeInsets.only(right: Dimens.padding_normal),
                        child: Text(
                          e,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(color:_themeStore.darkMode? Colors.black: Colors.white),
                        ),
                      ))
                  .toList()
          ],
        ),
      );

  Widget _buildAllIcon() => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: _store.user!.id == _store.question?.userId,
              child: PopUpMenuWidget(
                onSelected: (result) async {
                  if (result == question.delete) {
                    _buildDeleteDialog();
                  } else {
                    final resultEditQuestion = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateQuestionScreen(
                                editQuestion: true,
                                questionItem: _store.question,
                                questionId: widget.id,
                              )),
                    );
                    if (resultEditQuestion == true) {
                      _store.successGetQuestion = false;
                      _store.getQuestion();
                    }
                  }
                },
              ),
            ),
            Row(
              children: [
                Text(_store.question!.answer!.length.toString(),
                    style: Theme.of(context).textTheme.bodyText2),
                SizedBox(width: Dimens.padding_mini),
                IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AnswersScreen(
                            questionId: widget.id,
                            numberOfAnswers: _store.question!.answer!.length,
                          ),
                        ),
                      );
                    }),
              ],
            ),
            StackOverFlowLike(
              hsVoted: _store.hsVoted,
              like: _store.hsVoted == Strings.like

                  ///delete like
                  ? () async {
                      VotesList? likedObj;
                      for (var i in _store.question!.votesList!) {
                        if (i.userId == _store.user!.id) likedObj = i;
                        likedObj = i;
                      }
                      if (likedObj != null) {
                        _store.likeId = likedObj.id;
                        _store.hsVoted = null;
                        await _store.questionDeleteLike();
                        _store.getQuestion();
                      }
                    }
                  : _store.hsVoted == Strings.desLike

                      ///update like
                      ? () async {
                          VotesList? likedObj;
                          for (var i in _store.question!.votesList!) {
                            if (i.userId == _store.user!.id) likedObj = i;
                          }
                          if (likedObj != null) {
                            _store.typeLike = Strings.like;
                            _store.likeId = likedObj.id;
                            _store.hsVoted = Strings.like;
                            await _store.questionUpdateLike();
                            _store.getQuestion();
                          }
                        }
                      :

                      ///post like
                      () async {
                          _store.typeLike = Strings.like;
                          _store.hsVoted = Strings.like;
                          await _store.questionLike();

                          _store.getQuestion();
                        },
              desLike: _store.hsVoted == Strings.desLike

                  ///delete desLike
                  ? () async {
                      VotesList? likedObj;
                      for (var i in _store.question!.votesList!) {
                        if (i.userId == _store.user!.id) likedObj = i;
                      }
                      if (likedObj != null) {
                        _store.likeId = likedObj.id;
                        _store.hsVoted = null;
                        await _store.questionDeleteLike();
                        _store.getQuestion();
                      }
                    }
                  : _store.hsVoted == Strings.like

                      ///update desLike
                      ? () async {
                          VotesList? likedObj;
                          for (var i in _store.question!.votesList!) {
                            if (i.userId == _store.user!.id) likedObj = i;
                          }
                          if (likedObj != null) {
                            _store.typeLike = Strings.desLike;
                            _store.likeId = likedObj.id;
                            _store.hsVoted = Strings.desLike;
                            await _store.questionUpdateLike();
                            _store.getQuestion();
                          }
                          //update
                        }

                      ///post desLike
                      : () async {
                          _store.typeLike = Strings.desLike;
                          _store.hsVoted = Strings.desLike;
                          await _store.questionLike();
                          _store.getQuestion();
                        },
            ),
          ],
        ),
      );

  _buildDeleteDialog() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: MaterialDialog(
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "CANCEL",
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _store.deleteQuestion().then((value) {
                        Navigator.pop(context);
                        Navigator.pop(context, true);
                      }).catchError((e) {
                        Toast.show(_store.errorStore.errorMessage, context , duration: 2);


                      });
                    },
                    child: Text(
                      "OK",
                      style: Theme.of(context).textTheme.button?.copyWith(
                          color:  Colors.white),
                    ),
                  ),
                ],
                content: Text(
                  "Are you sure you want to delete the question?",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                borderRadius: Dimens.border_mid,
                enableFullWidth: true,
                title: Text(
                  "Delete Question",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: Colors.white),
                ),
                headerColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                enableCloseButton: false,
                enableBackButton: false,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 400),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Text("");
        });
  }
}
