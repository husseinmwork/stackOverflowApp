import 'package:flutter/material.dart';
import 'package:todo_app/ui/home/home.dart';
import 'package:todo_app/ui/login/login.dart';
import 'package:todo_app/ui/profile/profile.dart';
import 'package:todo_app/ui/reset_password/email_screen.dart';
import 'package:todo_app/ui/reset_password/otp.dart';
import 'package:todo_app/ui/sign_up/sign_up.dart';

class Routes {
  Routes._();

  //static variables
  // static const String splash = '/splash';
  static const String login = '/login';
  static const String sign_up = '/signUp';
  static const String home = '/home';
  static const String profile = '/profile';
  // static const String create_tasks = '/createTasks';
  static const String otp = '/otp';
  static const String email_screen = '/email';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    sign_up: (BuildContext context) => SignUpScreen(),
    home: (BuildContext context) => HomeScreen(),
    profile: (BuildContext context) => ProfileScreen(),
    // create_tasks: (BuildContext context) => CreateTasksScreen(),
    email_screen: (BuildContext context) => EmailScreen(),
    otp: (BuildContext context) => OtpScreen(email: "dfsa",),
  };

// navigator
// TODO add navigation

}
