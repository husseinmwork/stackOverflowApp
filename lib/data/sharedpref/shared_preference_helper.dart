import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/like/like.dart';
import 'package:todo_app/model/user/user.dart';


import 'constants/preferences.dart';

@Singleton()
class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future get authToken async {
    String? auth = _sharedPreference.getString(Preferences.auth_token);
    if(auth !=null){
      Map<String, dynamic> authTokenDecode = jsonDecode(auth);
      return authTokenDecode;
    }

  }

  Future<bool> saveAuthToken(Map authToken) async {
    String authTokenToJson = json.encode(authToken);
    return _sharedPreference.setString(Preferences.auth_token, authTokenToJson);
  }

  Future<bool> removeAuthToken() async {
    debugPrint("auth token is removed");
    return _sharedPreference.remove(Preferences.auth_token);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  Future<Future<bool>> removeIsLoggedIn() async {
    return _sharedPreference.remove(Preferences.is_logged_in);
  }

  //save user after login ------------------------------------------------------
  Account? get user  {
    var userString = _sharedPreference.getString(Preferences.user);
    if (userString != null) {
      /// string -> json -> map
      Map<String, dynamic> userMap = jsonDecode(userString);
      return Account.fromJson(userMap);
    }
  }

  Future<bool> saveUser(Account user) async {
    var userToJson = user.toJson();
    var userJsonToString = json.encode(userToJson);
    debugPrint("this user after save in shared pref$userJsonToString");
    return _sharedPreference.setString(Preferences.user, userJsonToString);
  }

  Future<Future<bool>> removeUser() async =>
      _sharedPreference.remove(Preferences.user);


  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }
}
