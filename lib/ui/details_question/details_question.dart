import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/store/details_question/details_question_store.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';

class DetailsQuestion extends StatefulWidget {
  const DetailsQuestion(
      {required this.id, this.includeMarkAsDoneButton = true});

  final String id;
  final bool includeMarkAsDoneButton;

  @override
  _DetailsQuestionState createState() => _DetailsQuestionState();
}

class _DetailsQuestionState extends State<DetailsQuestion> {
  late DetailsQuestionStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<DetailsQuestionStore>(context);
    _store.getQuestion(widget.id);
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
        builder: (_) => _store.success
            ? ListView(
                children: [
                  _buildTitle(),

                  SizedBox(height: Dimens.padding_normal),
                  _buildQuestionBody(),
                  _buildTags(),
                ],
              )
            : StackOverFlowIndecator(),
      );

  Widget _buildTitle() =>Text(
    _store.question!.title!,
    style: Theme.of(context)
        .textTheme
        .headline6
        ?.copyWith(fontWeight: FontWeight.w500),
  );
  Widget _buildQuestionBody() =>Text(
    _store.question!.body!,
    style: Theme.of(context).textTheme.subtitle2,
  );

  Widget _buildTags() => Wrap(
        children: [
          ..._store.question!.tags!
              .map((e) => Container(
                    color: Colors.amber.shade600,
                    padding: EdgeInsets.all(Dimens.padding_normal),
                    margin: EdgeInsets.only(right: Dimens.padding_normal),
                    child: Text(e,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(color: Colors.black)),
                  ))
              .toList()
        ],
      );
}
