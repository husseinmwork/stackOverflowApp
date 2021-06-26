import 'package:flutter/material.dart';
import 'package:todo_app/ui/home/home.dart';
import 'package:todo_app/ui/login/login.dart';
import 'package:todo_app/ui/my_question/my_question.dart';
import 'package:todo_app/ui/reset_password/email_screen.dart';
import 'package:todo_app/ui/sign_up/sign_up.dart';

class Routes {
  Routes._();

  //static variables
  static const String login = '/login';
  static const String sign_up = '/signUp';
  static const String home = '/home';
  static const String email_screen = '/email';
  static const String my_question = '/myQuestion';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    sign_up: (BuildContext context) => SignUpScreen(),
    home: (BuildContext context) => HomeScreen(),
    email_screen: (BuildContext context) => EmailScreen(),
    my_question: (BuildContext context) => MyQuestionScreen(),
  };


}
