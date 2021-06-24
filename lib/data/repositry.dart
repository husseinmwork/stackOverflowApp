import 'package:todo_app/data/local/datasources/post/post_datasource.dart';
import 'package:todo_app/data/network/apis/services.dart';
import 'package:todo_app/data/sharedpref/shared_preference_helper.dart';
import 'package:todo_app/model/create_quick_task/create_quick_task.dart';
import 'package:todo_app/model/create_tasks/create_tasks.dart';
import 'package:todo_app/model/done_tasks/done_task.dart';
import 'package:todo_app/model/get_tasks/get_tasks.dart';
import 'package:todo_app/model/helper/paging.dart';
import 'package:todo_app/model/login/login.dart';
import 'package:todo_app/model/profile/profile.dart';
import 'package:todo_app/model/sign_up/sign_up.dart';
import 'package:todo_app/model/tags/tags.dart';

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
  // Future<void> saveUser(User value) => _sharedPrefsHelper.saveUser(value);
  //
  // Future<User?> get user => _sharedPrefsHelper.user;

  // Future<Future<bool>> removeUser() async => _sharedPrefsHelper.removeUser();

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
    return await _services.login(userName, password).catchError((error) {
      throw error;
    });
  }


  Future passwordResetRequest(String email) async {
    return await _services.passwordResetRequest(email).catchError((e) {
      throw e;
    });
  }

  ///end Registration




  ///save token in shared preferences
  Future saveAuthToken(Map authToken) async {
    await _sharedPrefsHelper.saveAuthToken(authToken);
  }

  Future removeAuthToken() async {
    await _sharedPrefsHelper.removeAuthToken();
  }

  ///get profile
  Future<Profile> getProfile() async {
    return await _services
        .getProfile()
        .catchError((e) {
      throw e;
    });
  }

  ///create Quick task
  Future<CreateQuickTask?> createQuickTasks(CreateQuickTask? createTask) async {
    return await _services.createQuickTasks(createTask).then((value) {
      return value;
    }).catchError((e) {
      throw e;
    });
  }

  ///create task
  //this then is not needed
  Future<CreateTasks?> createTasks(CreateTasks? createTask) async =>
      await _services.createTasks(createTask).catchError((e) => throw e);

  ///this function patch work any task into done
  Future<DoneTask> doneTask(String id) async =>
      await _services.doneTasks(id).catchError((e) => throw e);

  ///get tags with paging
  Future<Paging<Result>> getTags(int offset) async {
    return await _services
        .getTags(offset: offset)
        .catchError((e) {
      throw e;
    });
  }

  ///get tags with paging
  Future<Paging<GetTasks>> getTasks(int offset) async {
    return await _services
        .getTasks(offset: offset)
        .catchError((e) {
      throw e;
    });
  }
}
