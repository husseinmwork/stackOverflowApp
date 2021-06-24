

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/store/error/error_store.dart';
import 'package:todo_app/utils/dio/dio_error_util.dart';

part 'reset_password.g.dart';

@Injectable()
class ResetPasswordStore = _ResetPasswordStore with _$ResetPasswordStore;

abstract class _ResetPasswordStore with Store {
  // repository instance
  late Repository _repository;

  // // store for handling form errors
  // final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _ResetPasswordStore(Repository repository) : this._repository = repository;

  @observable
  String email = '' ;

  @observable
  bool success = false;

  @observable
  bool loading = false;


  @action
  Future passwordResetRequest() async {
    this.loading = true;
    _repository.passwordResetRequest(email).then((value) {
      // resultForgetPassword = value ;
      debugPrint("this response of reset password $value ");
      success = true;
    }).catchError((error) {
      this.loading = false;
      this.success = false;
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }



}
