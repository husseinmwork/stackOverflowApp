import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/profile/profile.dart';
import 'package:todo_app/store/error/error_store.dart';
import 'package:todo_app/utils/todo/todo_utils.dart';

import 'package:todo_app/utils/dio/dio_error_util.dart';

part 'profile_store.g.dart';

@Injectable()
class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  // repository instance
  late Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _ProfileStore(Repository repository) : this._repository = repository;

  @observable
  String? email;

  @observable
  String? userName;

  @observable
  String? firstName;

  @observable
  String? lastName;

  @observable
  File? image;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  Profile? profile;

  @observable
  bool errorEditProfile = false;

  ///get profile
  @action
  Future getProfile() async {
    return await _repository.getProfile().then((value) {
      profile = value;
    }).catchError((error) {
      print(error);
    });
  }

  ///update profile
  Future updateProfile() async {
    List<MultipartFile>? multiPartFile = [];
    if(image !=null){
      multiPartFile.add(
        MultipartFile.fromFileSync(image!.path, filename: "image.jpg"),
      );
    }

    var formData = FormData.fromMap({
      "image": multiPartFile,
      "username": userName,
      "email": email,
      "firstName": firstName,
      "lastName": lastName
    }.removeNull());

    return await _repository.updateProfile(formData).then((value) {
      debugPrint(value);
      success = true;
      errorEditProfile = false;
    }).catchError((error) {
      this.loading = false;
      this.success = false;
      errorEditProfile = true;
      DioErrorUtil.handleError(error);
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
