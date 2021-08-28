import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/model/get_answer/get_answer.dart';
import 'package:todo_app/store/answers/answers_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/answers/edit_answer.dart';
import 'package:todo_app/ui/profile/profile.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/widgets/like.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';
import 'package:todo_app/widgets/stackoverflow_popup_menu.dart';
import 'package:todo_app/widgets/user_image_avatar.dart';

class AnswersScreen extends StatefulWidget {
  final String questionId;
  final int numberOfAnswers;

  AnswersScreen({
    required this.questionId,
    required this.numberOfAnswers,
  });

  @override
  _AnswersScreenState createState() => _AnswersScreenState();
}

class _AnswersScreenState extends State<AnswersScreen> {
  late AnswersStore _store;
  late ThemeStore _themeStore;

  TextEditingController _answerController = TextEditingController();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _page = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<AnswersStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);

    _store.questionId = widget.questionId;
    _store.getAnswers(_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text(
          "Answers",
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.white),
        ),
      );

  Widget _buildBody() => Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Observer(
              builder: (_) => Visibility(
                visible: _store.success,
                child: Column(
                  children: [
                    Expanded(
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
                              height: 50.0,
                              child: Center(child: body),
                            );
                          },
                        ),
                        controller: _refreshController,
                        onRefresh: () async {
                          //return page 0 because onLoading function can send request again
                          _page = 0;
                          debugPrint("Pagination onRefresh");
                          await Future.delayed(Duration(milliseconds: 1000));
                          _store.answers.clear();
                          await _store.getAnswers(0);
                          setState(() {});
                          _refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          //todo remove numberOfAnswers and add _store.answer.length
                          debugPrint("Pagination onLoading");
                          await Future.delayed(Duration(milliseconds: 1000));
                          if (!(_page >= widget.numberOfAnswers)) {
                            _page += 6;
                            await _store.getAnswers(_page);
                            setState(() {
                              _refreshController.loadComplete();
                            });
                          } else {
                            setState(() {
                              _refreshController.loadComplete();
                            });
                          }
                        },
                        child: ListView(
                          children: [
                            _buildAnswer(),
                          ],
                        ),
                      ),
                    ),
                    _buildAddAnswer()
                  ],
                ),
                replacement: StackOverFlowIndecator(),
              ),
            ),
          ),
        ],
      );

  Widget _buildAnswer() => Observer(
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _store.answers.isEmpty
              ? []
              : _store.answers
                  .map((item) => AnswerItem(
                        myUserId: _store.user!.id!,
                        item: item,
                        onTap: () {},
                      ))
                  .toList(),
        ),
      );

  Widget _buildAddAnswer() => KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) => Card(
          color: !isKeyboardVisible
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).cardColor,
          margin: EdgeInsets.all(4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Container(
            padding: EdgeInsets.only(left: Dimens.padding_normal),
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).accentColor)),
            child: Row(
              children: [
                UserImageAvatar(
                    image: _store.user?.image.toString() ?? "null",
                    onTap: () {}),
                SizedBox(width: Dimens.padding_normal),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Write a answer...",
                      labelText: "Write a answer...",
                    ),
                    controller: _answerController,
                    onFieldSubmitted: (value) async {
                      if (_answerController.text.isNotEmpty) {
                        _store.success = false;
                        _page = 0;
                        _store.answers.clear();
                        _answerController.text = '';
                        DeviceUtils.hideKeyboard(context);
                        await _store.createAnswer();
                        await _store.getAnswers(_page);
                      }
                    },
                    onChanged: (answer) {
                      _store.bodyAnswer = answer;
                    },
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.send_outlined),
                    onPressed: () async {
                      if (_answerController.text.isNotEmpty) {
                        _store.success = false;
                        _page = 0;
                        _store.answers.clear();
                        _answerController.text = '';
                        DeviceUtils.hideKeyboard(context);
                        await _store.createAnswer();
                        await _store.getAnswers(_page);
                      }
                    })
              ],
            ),
          ),
        ),
      );
}

class AnswerItem extends StatefulWidget {
  final Answer item;
  final Function onTap;
  final String myUserId;

  AnswerItem({required this.item, required this.onTap, required this.myUserId});

  @override
  _AnswerItemState createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem> {
  late ThemeStore _themeStore;
  late AnswersStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _themeStore = Provider.of<ThemeStore>(context);
    _store = Provider.of<AnswersStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   widget.onTap();
      // },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: Dimens.padding_mid,
                            left: Dimens.padding_mid,
                            right: Dimens.padding_mid),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ProfileScreen(
                                                  userId: widget.item.userId)));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            _buildUserName(),
                                            SizedBox(
                                                width: Dimens.padding_mini),
                                            _buildUserScore()
                                          ],
                                        ),
                                        _buildAnswerDate(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: Dimens.padding_mid),
                                  _buildAnswerBody(),
                                  SizedBox(height: Dimens.padding_mid),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.item.userId == widget.myUserId,
                child: PopUpMenuWidget(
                  onSelected: (result) async {
                    if (result == question.delete) {
                      await _store.deleteAnswers(widget.item.id!);
                    } else {
                     final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditAnswerScreen(
                          answerId: widget.item.id!,
                          bodyOfAnswer: widget.item.body,
                          userImage: _store.user!.image!,
                        )),
                      );
                     if(result){
                       _store.getAnswers(0);
                     }
                    }
                  },
                ),
              ),
            ],
          ),
          StackOverFlowLike(
            desLike: () {},
            like: () {},
            hsVoted: "",
          ),
          Divider(color: _themeStore.darkMode ? Colors.white : Colors.black)
        ],
      ),
    );
  }

  Widget _buildImage() => Padding(
        padding: const EdgeInsets.only(
            left: Dimens.padding_normal, top: Dimens.padding_normal),
        child: UserImageAvatar(
            image: widget.item.user?.image ?? "null",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          ProfileScreen(userId: widget.item.userId)));
            }),
      );

  Widget _buildUserName() => Text(
        widget.item.user!.cardUserName,
        style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );

  Widget _buildUserScore() => Text(
        widget.item.user!.score.toString(),
        style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );

  Widget _buildAnswerDate() => Text(
        //todo this after add created at from backend
        /*    widget.item.user!.createdAt.toString(),*/
        "answered 20 mins ago",
        style: Theme.of(context).textTheme.caption?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );

  Widget _buildAnswerBody() => Text(
        widget.item.body.toString(),
        textAlign: TextAlign.start,
        softWrap: true,
        style: Theme.of(context).textTheme.caption?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );
}
