import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/create_answer/create_answer.dart';
import 'package:todo_app/model/get_answer/get_answer.dart';
import 'package:todo_app/model/helper/paging.dart';
import 'package:todo_app/model/user/user.dart';
import 'package:todo_app/store/error/error_store.dart';

part 'answers_store.g.dart';

@Injectable()
class AnswersStore = _AnswersStore with _$AnswersStore;

abstract class _AnswersStore with Store {
  // repository instance
  late Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _AnswersStore(Repository repository) : this._repository = repository;

  @observable
  String? questionId;

  @observable
  String? bodyAnswer;

  @observable
  List<Answer> answers = ObservableList<Answer>();

  @observable
  Account? user;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  ///Answer
  @action
  Future getAnswers(int skip) async {
    user = _repository.user;
    if (questionId != null) {
      loading = true;
      await _repository
          .getAnswers(skip: skip, take: 6, questionId: questionId!)
          .then((value) {
        answers.addAll(value.results);
        success = true;
      }).catchError((error) {
        success = false;
        loading = false;
      });
    }
  }

  @action
  Future createAnswer() async {
    if (bodyAnswer != null && questionId != null) {
      // loadingCreateAns = true;
      await _repository
          .createAnswer(CreateAnswer(
            questionId: questionId!,
            body: bodyAnswer!,
          ))
          .then((value) {})
          .catchError((e) {});
    }
  }
}
