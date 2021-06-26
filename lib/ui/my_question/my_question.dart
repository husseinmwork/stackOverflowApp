import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/store/my_question/my_question.dart';
import 'package:todo_app/store/theme/theme_store.dart';

class MyQuestionScreen extends StatefulWidget {
  @override
  _MyQuestionScreenState createState() => _MyQuestionScreenState();
}

class _MyQuestionScreenState extends State<MyQuestionScreen> {

  late MyQuestionStore _store;
  late ThemeStore _themeStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<MyQuestionStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _store.getMyQuestion(1000);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder:(_)=> Center(
        child:_store.question.isEmpty? Text("null"): Text(_store.question.length.toString() ,style: TextStyle(color: Colors.white , fontSize: 40),),
      )),
    );
  }
}
