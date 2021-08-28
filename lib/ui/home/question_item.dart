import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/model/user/user.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/profile/profile.dart';
import 'package:todo_app/widgets/user_image_avatar.dart';
import 'package:todo_app/utils/todo/todo_utils.dart';

class QuestionItem extends StatefulWidget {
  final Question item;
  final VoidCallback onTap;

  QuestionItem({required this.item, required this.onTap});

  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
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
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.padding_mid, vertical: Dimens.padding_mid),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ProfileScreen(userId: widget.item.userId)));
                      },
                      child: Row(
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
                              _buildAskDate()
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimens.padding_mid),
                    _buildQuestionTitle(),
                    SizedBox(height: Dimens.padding_mini),
                    _buildQuestion(),
                    SizedBox(height: Dimens.padding_large),
                    _buildTags(),
                    /* SizedBox(height: Dimens.padding_large),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAnswer(),
                        _buildViews(),
                        _buildLike(),
                      ],
                    ),*/
                  ],
                ),
              ),
              SizedBox(width: Dimens.padding_normal),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLike(),
                  SizedBox(height: Dimens.padding_large),
                  _buildAnswer(),
                  SizedBox(height: Dimens.padding_normal),
                  _buildViews()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() => UserImageAvatar(
      image: widget.item.user?.image ?? "null",
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProfileScreen(userId: widget.item.userId)));
      });

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

  Widget _buildAskDate() => Text(
        widget.item.createdAt?.changeFormat(),
        style: Theme.of(context).textTheme.caption?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );

  Widget _buildQuestionTitle() => Text(
        widget.item.title.toString(),
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );

  Widget _buildQuestion() => Text(
        widget.item.body.toString().replaceAll(new RegExp(r"\n|\s\n"), ""),
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.caption?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );

  Widget _buildTags() => Wrap(
        children: [
          ...widget.item.tags!
              .map(
                (e) => Container(
                  color: Theme.of(context).accentColor,
                  padding: EdgeInsets.all(Dimens.padding_card),
                  margin: EdgeInsets.only(
                      right: Dimens.padding_card, bottom: Dimens.padding_card),
                  child: Text(e,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: _themeStore.darkMode
                              ? Colors.black
                              : Colors.white)),
                ),
              )
              .toList()
        ],
      );

  Widget _buildLike() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.thumb_up_alt_outlined),
          SizedBox(width: Dimens.padding_normal),
          Text(widget.item.votes!.toInt().toString()),
        ],
      );

  Widget _buildAnswer() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.comment, color: Theme.of(context).iconTheme.color),
          SizedBox(width: Dimens.padding_normal),
          Text(
            widget.item.answer?.length.toString() ?? "0",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: _themeStore.darkMode ? Colors.white : Colors.black,
                ),
          )
        ],
      );

  Widget _buildViews() => Row(
        children: [
          Icon(Icons.visibility),
          SizedBox(width: Dimens.padding_normal),
          Text(
            widget.item.views!.toInt().toString(),
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: _themeStore.darkMode ? Colors.white : Colors.black,
                ),
          )
        ],
      );
}
