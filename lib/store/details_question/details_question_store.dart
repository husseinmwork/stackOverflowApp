import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/get_answer/get_answer.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/store/error/error_store.dart';
import 'package:todo_app/utils/dio/dio_error_util.dart';

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
  Question? question;

  @observable
  List<Answer> answers = ObservableList<Answer>();

  ///get question details
  @action
  Future getQuestion(String id) async {
    loading = true;
   return  await _repository
        .getDetailsQuestion(id)
        .then((value) {
        question = value;
        success = true;
    }).catchError((error) {
      loading = false;
      success = false;
      DioErrorUtil.handleError(error);
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }


///get Answer with paging
  @action
  Future getAnswers(int skip, String questionId) async {
    await _repository
        .getAnswers(skip:skip , questionId: questionId)
        .then((value) {
      return answers = value.results;
    }).catchError((e) {

    });
  }


}
