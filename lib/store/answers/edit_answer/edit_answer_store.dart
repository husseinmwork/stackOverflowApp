import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/get_answer/get_answer.dart';
import 'package:todo_app/store/error/error_store.dart';
import 'package:todo_app/utils/dio/dio_error_util.dart';

part 'edit_answer_store.g.dart';

@Injectable()
class EditAnswersStore = _EditAnswersStore with _$EditAnswersStore;

abstract class _EditAnswersStore with Store {
  // repository instance
  late Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _EditAnswersStore(Repository repository) : this._repository = repository;

  @observable
  String? bodyAnswer;

  @observable
  String? answerId;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @action
  Future updateAnswer() async {
    loading = true;
    await _repository
        .updateAnswer(
      Answer(
        body: bodyAnswer.toString(),
      ),
      answerId!,
    )
        .then((value) {
      loading = false;
    }).catchError((error) {
      loading = false;
      errorStore.errorMessage = DioErrorUtil.handleError(error);

      throw error;
    });
  }
}
