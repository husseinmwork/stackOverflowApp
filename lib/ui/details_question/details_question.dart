import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/model/get_answer/get_answer.dart';
import 'package:todo_app/store/details_question/details_question_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';
import 'package:todo_app/widgets/user_image_avatar.dart';

class DetailsQuestionScreen extends StatefulWidget {
  const DetailsQuestionScreen(
      {required this.id,
      this.includeMarkAsDoneButton = true,
      required this.myImage});

  final String id;
  final bool includeMarkAsDoneButton;
  final String myImage;

  @override
  _DetailsQuestionScreenState createState() => _DetailsQuestionScreenState();
}

class _DetailsQuestionScreenState extends State<DetailsQuestionScreen> {
  late DetailsQuestionStore _store;

  TextEditingController _answerController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<DetailsQuestionStore>(context);
    _store.questionId = widget.id;
    _store.getQuestion();
    _store.getAnswers(0);
    // _store.getPrefUser();
  }

  @override
  void dispose() {
    super.dispose();
    _store.success = false;
    _store.successGetAnswers = false;
    _store.successGetQuestion = false;
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
        leading: ArrowBackIcon(),
        title: Text("Details Question",
            style: Theme.of(context).textTheme.headline6),
      );

  Widget _buildBody() => Observer(
        builder: (_) => Visibility(
          visible: (_store.successGetQuestion && _store.successGetAnswers),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(Dimens.padding_large),
                  children: [
                    Row(
                      children: [
                        _buildTitleAndBody(),
                        _StackOverFlowLike(
                            isSelected: _store.isLiked,
                            like: _store.isLiked
                                ? () {
                                    //delete like
                              // _store.savePrefLike(false);
                                  }
                                : () {
                                    // _store.typeLike = 'UPVOTE';
                                    // // _store.savePrefLike(true);
                                    // _store.questionLike();
                                  },
                            desLike: () {
                              // _store.typeLike = 'DOWNVOTE';
                              // _store.questionLike();
                            },
                          ),

                      ],
                    ),
                    SizedBox(height: Dimens.padding_normal),
                    _buildTags(),
                    SizedBox(height: Dimens.padding_large),
                    _buildAnswer(),
                  ],
                ),
              ),
              _buildYourAnswer(),
            ],
          ),
          replacement: StackOverFlowIndecator(),
        ),
      );

  Widget _buildTitleAndBody() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _store.question?.title ?? "",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: Dimens.padding_normal),
            Text(
              _store.question?.body ?? "",
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      );

  Widget _buildTags() => Wrap(
        children: [
          if (_store.question?.tags != null)
            ..._store.question!.tags!
                .map((e) => Container(
                      color: Theme.of(context).appBarTheme.color,
                      padding: EdgeInsets.all(Dimens.padding_normal),
                      margin: EdgeInsets.only(right: Dimens.padding_normal),
                      child: Text(e,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(color: Colors.white)),
                    ))
                .toList()
        ],
      );

  Widget _buildAnswer() => Observer(
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Answer", style: Theme.of(context).textTheme.subtitle1),
                SizedBox(width: Dimens.padding_mini),
                Text(_store.answers.length.toString(),
                    style: Theme.of(context).textTheme.subtitle2),
              ],
            ),
            ..._store.answers.isEmpty
                ? []
                : _store.answers
                    .map((item) => AnswerItem(
                          item: item,
                          onTap: () {},
                        ))
                    .toList(),
          ],
        ),
      );

  Widget _buildYourAnswer() => Card(
        margin: EdgeInsets.symmetric(vertical: Dimens.padding_mini),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.padding_mid, vertical: Dimens.padding_mid),
          child: Row(
            children: [
              UserImageAvatar(image: widget.myImage, onTap: () {}),
              SizedBox(width: Dimens.padding_normal),
              _buildCreateAnswer(),
              IconButton(
                  icon: Icon(Icons.send_outlined, color: Colors.white),
                  onPressed: () async {
                    if (_answerController.text.isNotEmpty) {
                      _answerController.text = '';
                      DeviceUtils.hideKeyboard(context);
                      await _store.createAnswer();
                      _store.getAnswers(0);
                    }
                  })
            ],
          ),
        ),
      );

  Widget _buildCreateAnswer() => Expanded(
        child: TextFormField(
          maxLines: 4,
          minLines: 1,
          decoration: InputDecoration(
            hintText: "Write a answer...",
            labelText: "Write a answer...",
          ),
          controller: _answerController,
          onFieldSubmitted: (value) async {
            /*    if (_answerController.text.isNotEmpty) {
                      _answerController.text = '';
                      DeviceUtils.hideKeyboard(context);

                      await _store.createAnswer();
                      _store.getAnswers(0);
                    }*/
          },
          onChanged: (answer) {
            _store.bodyAnswer = answer;
          },
        ),
      );
}

class AnswerItem extends StatefulWidget {
  final Answer item;
  final Function onTap;

  AnswerItem({required this.item, required this.onTap});

  @override
  _AnswerItemState createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem> {
  late ThemeStore _themeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: Dimens.padding_mini),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.padding_mid,
                    vertical: Dimens.padding_mid),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImage(),
                        SizedBox(width: Dimens.padding_mini),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _buildUserName(),
                                SizedBox(width: Dimens.padding_mini),
                                _buildUserScore()
                              ],
                            ),
                            _buildAnswerDate()
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Dimens.padding_mid),
                    _buildAnswerBody()
                  ],
                ),
              ),
            ),
            //fixme
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white, minimumSize: Size(40, 40)),
                      child: Icon(Icons.thumb_up_alt_outlined,
                          color: Colors.white),
                      onPressed: () {}),
                  Text("2"),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white, minimumSize: Size(40, 40)),
                      child: Icon(Icons.thumb_down_alt_outlined,
                          color: Colors.white),
                      onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() =>
      UserImageAvatar(image: widget.item.user?.image ?? "null", onTap: () {});

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
        widget.item.body.toString().replaceAll(new RegExp(r"\n|\s\n"), ""),
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.caption?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );
}

class _StackOverFlowLike extends StatelessWidget {
  final bool? isSelected;
  final Function like;
  final Function desLike;

  const _StackOverFlowLike(
      {required this.like, required this.desLike, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildLike(),
          _buildNumLikeAndDisLike(),
          _buildDisLike(),
        ],
      ),
    );
  }

  Widget _buildLike() => ElevatedButton(
      style: ElevatedButton.styleFrom(
          onPrimary: Colors.white, minimumSize: Size(40, 40)),
      child: isSelected == true
          ? Icon(Icons.thumb_up)
          :
          // Transform.rotate(
          //     angle: -math.pi / 2,
          //     child:
          //         Icon(Icons.play_arrow_outlined, color: Colors.white, size: 40)),
          Icon(Icons.thumb_up_alt_outlined, color: Colors.white),
      onPressed: () {
        like();
      });

  Widget _buildNumLikeAndDisLike() => Text("4");

  Widget _buildDisLike() => ElevatedButton(
      style: ElevatedButton.styleFrom(
          onPrimary: Colors.white, minimumSize: Size(40, 40)),
      // Icon(Icons.arrow_drop_down_outlined , size: 60,color: Colors.white,)
      child: Transform.rotate(
          angle: -math.pi + -math.pi / 2,
          child:
              Icon(Icons.play_arrow_outlined, color: Colors.white, size: 40)),
      onPressed: () {
        desLike();
      });
}
