import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/get_my_question/get_my_question.dart';
import 'package:todo_app/store/error/error_store.dart';

part 'my_question.g.dart';

@Injectable()
class MyQuestionStore = _MyQuestionStore with _$MyQuestionStore;

abstract class _MyQuestionStore with Store {
  // repository instance
  late Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _MyQuestionStore(Repository repository) : this._repository = repository;

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
  ObservableList<List<GetMyQuestion>> question =
      ObservableList<List<GetMyQuestion>>();


  ///get question with paging
  @action
  Future getMyQuestion(int skip) async {
    return await _repository
        .getQuestion(skip).then((value) =>question.add(value.results)).catchError((e) {
          throw e;
        }
    );
  }
}
