import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

  // // store for handling form errors
  // final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
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

  // @observable
  // Map<String,dynamic> resultForgetPassword = {};

  @action
  Future login() async {
    this.loading = true;
    await _repository.login(userName, password).then((value) {
      _repository.saveIsLoggedIn(true);
      print("this success login");
      // _repository.saveUser(value.user);
      _repository.saveAuthToken({
        'accessToken': value.accessToken,
        'refreshToken': value.refreshToken
      });
      success = true;
    }).catchError((error) {
      this.loading = false;
      this.success = false;
      if (error is DioError) {
        debugPrint("this dio error login  = \n");
        DioErrorUtil.handleError(error); // remove this print before remove
        //error store this is dio error
        //form error store this is eny error and validation error
        errorStore.errorMessage = DioErrorUtil.handleError(error);

        //if this error not dio errors
        // errorStore.errorMessage = error.toString().contains("ERROR_USER_NOT_FOUND")
        //     ? "Username and password doesn't match"
        //     : "Something went wrong, please check your internet connection and try again";

        // print("this error message = ${errorStore.errorMessage}");

        // if(errorStore.errorMessage.contains('401')){
        //  print("work refresh token ");
        // }else{
        //   print(" this error is not 401 dont work refresh token  ");
        // }
      }
      debugPrint("this not dio error login = $error");
      // debugPrint(error);
    });
  }
}
