import 'package:flutter/material.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';

class DetailsQuestion extends StatefulWidget {
  const DetailsQuestion(
      {required this.id, this.includeMarkAsDoneButton = true});

  final String id;
  final bool includeMarkAsDoneButton;

  @override
  _DetailsQuestionState createState() => _DetailsQuestionState();
}

class _DetailsQuestionState extends State<DetailsQuestion> {
  @override
  void initState() {
    super.initState();
    print(widget.id);
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
        //todo  LocaleKeys.goto_register.tr(), change language after complete all section profile
        title: Text("Details Question",
            style: Theme.of(context).textTheme.headline6),
      );

  Widget _buildBody() => Container();
}
