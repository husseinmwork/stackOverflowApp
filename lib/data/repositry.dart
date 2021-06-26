import 'package:todo_app/data/local/datasources/post/post_datasource.dart';
import 'package:todo_app/data/network/apis/services.dart';
import 'package:todo_app/data/sharedpref/shared_preference_helper.dart';
import 'package:todo_app/model/get_my_question/get_my_question.dart';
import 'package:todo_app/model/helper/paging.dart';
import 'package:todo_app/model/login/login.dart';
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

  Future<Account?> get user => _sharedPrefsHelper.user;

  Future<Future<bool>> removeUser() async => _sharedPrefsHelper.removeUser();

  // is login user -------------------------------------------------------------
  // todo delete
  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  Future<Future<bool>> removeIsLoggedIn() async =>
      _sharedPrefsHelper.removeIsLoggedIn();

  ///start Registration
  Future<Map<String, dynamic>> signUp(SignUp signUp) async {
    return await _services.signUp(signUp).catchError((error) => throw error);
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
  Future<Paging<GetMyQuestion>> getQuestion(int skip) async {
    return await _services.getQuestion(skip: skip).catchError((e) => throw e);
  }
}
