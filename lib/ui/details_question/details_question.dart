import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/assets.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/model/get_answer/get_answer.dart';
import 'package:todo_app/store/details_question/details_question_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';

class DetailsQuestionScreen extends StatefulWidget {
  const DetailsQuestionScreen(
      {required this.id, this.includeMarkAsDoneButton = true , required this.myImage});

  final String id;
  final bool includeMarkAsDoneButton;
  final String myImage;

  @override
  _DetailsQuestionScreenState createState() => _DetailsQuestionScreenState();
}

class _DetailsQuestionScreenState extends State<DetailsQuestionScreen> {
  late DetailsQuestionStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<DetailsQuestionStore>(context);
    _store.getQuestion(widget.id);
    _store.getAnswers(0, widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    _store.success = false;
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
        builder: (_) => _store.success == true
            ? Column(
              children: [
                Expanded(
                  child: ListView(
                      padding: EdgeInsets.all(Dimens.padding_large),
                      children: [
                        _buildTitle(),
                        SizedBox(height: Dimens.padding_normal),
                        _buildQuestionBody(),
                        SizedBox(height: Dimens.padding_normal),
                        _buildTags(),
                        SizedBox(height: Dimens.padding_large),
                        _buildAnswer(),
                      ],
                    ),
                ),
                _buildYourAnswer(),
              ],
            )
            : StackOverFlowIndecator(),
      );

  Widget _buildTitle() => Text(
        _store.question!.title!,
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.w500),
      );

  Widget _buildQuestionBody() => Text(
        _store.question!.body!,
        style: Theme.of(context).textTheme.subtitle2,
      );

  Widget _buildTags() => Wrap(
        children: [
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

  Widget _buildAnswer() => Column(
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
      );

  Widget _buildYourAnswer() => Card(
    margin: EdgeInsets.symmetric(vertical: Dimens.padding_mini),
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.padding_mid, vertical: Dimens.padding_mid),
      child: Row(
        children: [
          CircleAvatar(
            radius: Dimens.cardQuestionImage,
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: Assets.placeHolder,
                height: double.infinity,
                width: double.infinity,
                //todo my image
                image: widget.myImage ?? "null",
                imageErrorBuilder: (_, __, ___) {
                  return Image.asset(Assets.placeHolder,
                      fit: BoxFit.cover);
                },
              ),
            ),
          ),
          Expanded(child: TextFormField()),
          IconButton(icon: Icon(Icons.send , color: Colors.white), onPressed: (){})
        ],

      ),
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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.padding_mid, vertical: Dimens.padding_mid),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImage(),
                  SizedBox(width: Dimens.padding_mini),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildUserName(), _buildAnswerDate()],
                  ),
                ],
              ),
              SizedBox(height: Dimens.padding_mid),
              _buildAnswerBody()
            ],
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
