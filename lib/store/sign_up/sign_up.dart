import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/sign_up/sign_up.dart';
import 'package:todo_app/store/error/error_store.dart';
import 'package:todo_app/utils/dio/dio_error_util.dart';
import 'package:todo_app/utils/todo/todo_utils.dart';

part 'sign_up.g.dart';

@Injectable()
class SignUpStore = _SignUpStore with _$SignUpStore;

abstract class _SignUpStore with Store {
  // repository instance
  late Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _SignUpStore(Repository repository) : this._repository = repository;

  @observable
  String? email;

  @observable
  String? userName;

  @observable
  String? password;

  @observable
  String? firstName;

  @observable
  String? lastName;

  @observable
  File? image;

  @observable
  int? score;

  @observable
  bool? isActive;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  bool showPassword = true;

  @observable
  bool showConfirmPassword = true;


  @action
  Future signUp() async {
    loading = true;
    List<MultipartFile>? multiPartFile;
    if (image != null) {
      multiPartFile = [];
      multiPartFile.add(
        MultipartFile.fromFileSync(image!.path, filename: "image.jpg"),
      );
    }

    var formData = FormData.fromMap({
      "image": multiPartFile,
      "username": userName,
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName
    }.removeNull());

    await _repository.signUp(formData).then((value) {
      loading = false;
      success = true;
    }).catchError((error) {
      this.loading = false;
      this.success = false;
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      throw error;
    });
  }
}
