import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/store/details_question/details_question_store.dart';
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
  late DetailsQuestionStore _store;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
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

  AppBar _buildAppBar() =>
      AppBar(
        elevation: 4,
        leading: ArrowBackIcon(),
        title: Text("Details Question",
            style: Theme
                .of(context)
                .textTheme
                .headline6),
      );

  Widget _buildBody() =>
      Observer(builder: (_) =>
      _store.question != null ? ListView(
        children: [
          Text(_store.question!.title!)
        ],
      ) : SpinKitFoldingCube(color: Colors.purple[200])
      );
}
