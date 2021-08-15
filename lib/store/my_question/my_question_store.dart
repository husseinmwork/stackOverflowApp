import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/filter/filter.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/model/user/user.dart';
import 'package:todo_app/store/error/error_store.dart';

part 'my_question_store.g.dart';

@Injectable()
class MyQuestionStore = _MyQuestionStore with _$MyQuestionStore;

abstract class _MyQuestionStore with Store {

  late Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _MyQuestionStore(Repository repository) : this._repository = repository;

  @observable
  Account? user;



  @observable
  bool success = false;

  @observable
  bool loading = false;



  @observable
  List<Question> question = ObservableList<Question>();

  ///get question with paging
  @action
  Future getQuestion(int skip, ) async {
    user = _repository.user;
    print("thisssssssssssssssss${user?.id}");
    if(user != null){
      await _repository
          .getQuestion(skip:skip,take: 6,
          filter: QuestionFilter(
            userId: user?.id,
          ))
          .then((value) {
        return question = value.results;
      }).catchError((e) {
        throw e;
      });
    }
  }


}
