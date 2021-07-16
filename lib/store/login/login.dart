import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/store/error/error_store.dart';
import 'package:todo_app/utils/dio/dio_error_util.dart';

part 'login.g.dart';

@Injectable()
class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  // repository instance
  late Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _LoginStore(Repository repository) : this._repository = repository;

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

  @action
  Future login() async {
    this.loading = true;
    await _repository.login(userName, password).then((value) {
      _repository.saveIsLoggedIn(true);
      _repository.saveUser(value.user);
      _repository.saveAuthToken({
        'accessToken': value.accessToken,
        'refreshToken': value.refreshToken
      });
      success = true;
      errorLogin = false;
    }).catchError((error) {
      this.loading = false;
      this.success = false;
      errorLogin = true;
      // if (error is DioError) {
        DioErrorUtil.handleError(error);
        errorStore.errorMessage = DioErrorUtil.handleError(error);
      // }
    });
  }
}
