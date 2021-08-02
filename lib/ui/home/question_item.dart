import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/assets.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/details_question/details_question.dart';

class QuestionItem extends StatefulWidget {
  final Question item;
  final Function onTap;
  final VoidCallback openContainer;

  QuestionItem({required this.item , required this.onTap , required this.openContainer});

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
    return  _InkWellOverlay(

        child: Card(
          margin: EdgeInsets.symmetric(vertical: Dimens.padding_mini),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: InkWell(
            onTap:(){ widget.onTap();},
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.padding_mid, vertical: Dimens.padding_mid),
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
                        children: [_buildUserName(), _buildUserScore()],
                      ),
                    ],
                  ),
                  SizedBox(height: Dimens.padding_mid),
                  _buildQuestionTitle(),
                  SizedBox(height: Dimens.padding_mini),
                  _buildQuestion(),
                  SizedBox(height: Dimens.padding_large),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildAnswer(),
                      _buildViews(),
                      _buildLike(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }

  Widget _buildImage() => CircleAvatar(
        radius: Dimens.cardQuestionImage,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: Assets.placeHolder,
            height: double.infinity,
            width: double.infinity,
            image: widget.item.user!.image ?? "null",
            imageErrorBuilder: (_, __, ___) {
              return Image.asset(Assets.placeHolder, fit: BoxFit.cover);
            },
          ),
        ),
      );

  Widget _buildUserName() => Text(
        widget.item.user!.cardUserName,
        style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );

  Widget _buildUserScore() => Text(
        widget.item.user!.score.toString(),
        style: Theme.of(context).textTheme.caption?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );

  Widget _buildQuestionTitle()=>Text(widget.item.title.toString(),
    style: Theme.of(context).textTheme.bodyText1?.copyWith(
    color: _themeStore.darkMode ? Colors.white : Colors.black,
  ),);
  Widget _buildQuestion() => Text(
        widget.item.body.toString().replaceAll(new RegExp(r"\n|\s\n"), ""),
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.caption?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );

  Widget _buildLike() => Row(
        children: [
          Icon(Icons.favorite, size: 20),
          SizedBox(width: Dimens.padding_normal),
          Text(
            widget.item.votes.toString(),
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: _themeStore.darkMode ? Colors.white : Colors.black,
                ),
          )
        ],
      );

  Widget _buildAnswer() => Row(
        children: [
          Icon(Icons.comment, size: 20),
          SizedBox(width: Dimens.padding_normal),
          Text(
            widget.item.user?.answer?.length.toString() ?? "0",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: _themeStore.darkMode ? Colors.white : Colors.black,
                ),
          )
        ],
      );

  Widget _buildViews() => Row(
        children: [
          Icon(Icons.visibility, size: 20),
          SizedBox(width: Dimens.padding_normal),
          //todo this into views after add in backend
          Text(
            widget.item.user?.answer?.length.toString() ?? "0",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: _themeStore.darkMode ? Colors.white : Colors.black,
                ),
          )
        ],
      );
}



class _InkWellOverlay extends StatelessWidget {
  const _InkWellOverlay({
    this.openContainer,
    this.width,
    this.height,
    this.child,
  });

  final VoidCallback? openContainer;
  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}
