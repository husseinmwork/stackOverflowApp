import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/create_question/create_question.dart';
import 'package:todo_app/store/error/error_store.dart';
import 'package:todo_app/widgets/tags_language.dart';

part 'create_question_store.g.dart';

@Injectable()
class CreateQuestionStore = _CreateQuestionStore with _$CreateQuestionStore;

abstract class _CreateQuestionStore with Store {
  // repository instance
  late Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _CreateQuestionStore(Repository repository) : this._repository = repository;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  String? title;

  @observable
  String? body;

  @observable
  List<Language>? tags;

  @observable
  List<String> allTags = [];

  @action
  Future createQuestion() async {
    loading = true;
    if (tags != null) {
      allTags = [];
      for (var i in tags!) {
        allTags.add(i.name);
      }
    }

    await _repository
        .createQuestion(CreateQuestion(body: body, title: title, tags: allTags))
        .then((value) {
      success = true;
    }).catchError((e) {
      loading = false;
      success = false;
      debugPrint("error in create question $e");
    });
  }
}
