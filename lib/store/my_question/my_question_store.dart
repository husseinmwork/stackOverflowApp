import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/filter/filter.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/model/user/user.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:todo_app/store/error/error_store.dart';

part 'my_question_store.g.dart';

@Injectable()
class MyQuestionStore = _MyQuestionStore with _$MyQuestionStore;

abstract class _MyQuestionStore with Store {
  // repository instance
  late Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _MyQuestionStore(Repository repository) : this._repository = repository;

  @observable
  Account? user;



  @observable
  bool success = false;

  @observable
  bool loading = false;

  // @action
  // void getPrefUser() => user = _repository.user;

  @observable
  PagingController<int, Question> pagingController =
  PagingController(firstPageKey: 0);

  @observable
  List<Question> question = ObservableList<Question>();

  ///get question with paging
  @action
  Future getQuestion(int skip, {int? limit}) async {
    user = _repository.user;
    print("thisssssssssssssssss${user?.id}");
    if(user != null){
      await _repository
          .getQuestion(skip,
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
