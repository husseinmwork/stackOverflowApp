import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/data/local/datasources/post/post_datasource.dart';
import 'package:todo_app/data/network/apis/services.dart';
import 'package:todo_app/data/sharedpref/shared_preference_helper.dart';
import 'package:todo_app/model/create_answer/create_answer.dart';
import 'package:todo_app/model/create_question/create_question.dart';
import 'package:todo_app/model/filter/filter.dart';
import 'package:todo_app/model/get_answer/get_answer.dart';
import 'package:todo_app/model/get_category/get_category.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/model/helper/paging.dart';
import 'package:todo_app/model/like/like.dart';
import 'package:todo_app/model/login/login.dart';
import 'package:todo_app/model/user/user.dart';

import 'package:todo_app/model/profile/profile.dart';
import 'package:todo_app/model/sign_up/sign_up.dart';

class Repository {
  // data source object
  final PostDataSource _ibaityDataSource;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  //services
  final Services _services;

  Repository(this._services, this._sharedPrefsHelper, this._ibaityDataSource);

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;

  // user ---------------------------------------------------------------------
  Future<void> saveUser(Account value) => _sharedPrefsHelper.saveUser(value);

  Account? get user => _sharedPrefsHelper.user;

  Future<Future<bool>> removeUser() async => _sharedPrefsHelper.removeUser();


  // is login user -------------------------------------------------------------
  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  Future<Future<bool>> removeIsLoggedIn() async =>
      _sharedPrefsHelper.removeIsLoggedIn();

  ///start Registration
  Future<Map<String, dynamic>> signUp(FormData formData) async {
    return await _services.signUp(formData).catchError((error) => throw error);
  }

  Future<Login> login(String userName, String password) async {
    return await _services
        .login(userName, password)
        .catchError((error) => throw error);
  }

  Future passwordResetRequest(String email) async {
    return await _services
        .passwordResetRequest(email)
        .catchError((e) => throw e);
  }

  Future sendOtpAndNewPassword(
      String email, int otp, String newPassword) async {
    return await _services
        .sendOtpAndNewPassword(email, otp, newPassword)
        .catchError((error) => throw error);
  }

  ///end Registration

  ///save token in shared preferences
  Future saveAuthToken(Map authToken) async {
    await _sharedPrefsHelper.saveAuthToken(authToken);
  }

  Future removeAuthToken() async {
    await _sharedPrefsHelper.removeAuthToken();
  }

  ///get question with paging
  Future<Paging<Question>> getQuestion(int skip,
      {QuestionFilter? filter}) async {
    return await _services.getQuestion(skip: skip , filter:filter).catchError((e) => throw e);
  }
  ///get question details page
  Future<Question> getDetailsQuestion(String id) async {
    return await _services.getDetailsQuestion(id).catchError((e) => throw e);
  }

  ///get Answer with paging
  Future<Paging<Answer>> getAnswers({required int skip,required String questionId}) async {
    return await _services.getAnswers( questionId: questionId , skip: skip).catchError((e) => throw e);
  }

  ///create question
  Future createQuestion(CreateQuestion createQuestion) async {
    return await _services.createQuestion(createQuestion).catchError((e) => throw e);
  }

  ///question like
  Future<Like> questionLike(Like like) async {
    return await _services.questionLike(like).catchError((e) => throw e);
  }

  Future questionUpdateLike(String likeId)async{
    return await _services.questionUpdateLike(likeId).catchError((e)=>throw e);
  }

  Future questionDeleteLike(String likeId)async{
    return await _services.questionDeleteLike(likeId).catchError((e)=>throw e);
  }

  ///create answer
  Future<CreateAnswer> createAnswer(CreateAnswer createAnswer) async {
    return await _services.createAnswer(createAnswer).catchError((e) => throw e);
  }

  ///get profile
  Future<Profile> getProfile()async{
   return await _services.getProfile().catchError((error)=>throw error);
  }

  ///update profile
  Future<Account> updateProfile(FormData profile)async{
    return await _services.updateProfile(profile).catchError((error)=>throw error);
  }

  ///get category with paging
  Future<Paging<Category>> getCategory(int skip) async {
    return await _services.getCategory(skip: skip ).catchError((e) => throw e);
  }


}
