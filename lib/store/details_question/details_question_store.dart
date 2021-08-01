import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/filter/filter.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/store/error/error_store.dart';

part 'details_question_store.g.dart';

@Injectable()
class DetailsQuestionStore = _DetailsQuestionStore with _$DetailsQuestionStore;

abstract class _DetailsQuestionStore with Store {
  // repository instance
  late Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _DetailsQuestionStore(Repository repository) : this._repository = repository;

  @observable
  String userName = '';

  @observable
  String password = '';

  @observable
  bool showPassword = true;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  bool errorLogin = false;

  @observable
  String? id;

  @observable
  Question? question;

  ///get question with paging
  @action
  Future getQuestion(int skip, {int? limit}) async {
    loading = true;
     await _repository
        .getQuestion(skip,
        filter: QuestionFilter(
          id: id,
        ))
        .then((value) {
      return question = value.results.first;
    }).catchError((e) {
      loading = false;
      throw e;
    });
  }


}
