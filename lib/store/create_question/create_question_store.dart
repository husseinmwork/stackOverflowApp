import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/store/error/error_store.dart';

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
  bool errorCreateQuestion = false;

}
