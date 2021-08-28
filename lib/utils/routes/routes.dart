import 'package:flutter/material.dart';
import 'package:todo_app/ui/answers/answers.dart';
import 'package:todo_app/ui/answers/edit_answer.dart';
import 'package:todo_app/ui/create_question/create_question.dart';
import 'package:todo_app/ui/details_question/details_question.dart';
import 'package:todo_app/ui/home/filter.dart';
import 'package:todo_app/ui/home/home.dart';
import 'package:todo_app/ui/login/login.dart';
import 'package:todo_app/ui/my_question.dart';
import 'package:todo_app/ui/my_question/my_question.dart';
import 'package:todo_app/ui/profile/edit_profile.dart';
import 'package:todo_app/ui/profile/profile.dart';
import 'package:todo_app/ui/reset_password/email_screen.dart';
import 'package:todo_app/ui/reset_password/otp.dart';
import 'package:todo_app/ui/sign_up/sign_up.dart';

class Routes {
  Routes._();

  //static variables
  static const String login = '/login';
  static const String sign_up = '/signUp';
  static const String home = '/home';
  static const String email_screen = '/email';
  static const String otp_screen = '/otp';
  static const String profile_screen = '/profile';
  static const String edit_profile_screen = '/editProfile';
  static const String create_question = '/createQuestion';
  static const String my_question = '/myQuestion';
  static const String answers = '/answers';
  static const String filter = '/filter';
/*
  static const String details_question = '/detailsQuestion';
*/

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    sign_up: (BuildContext context) => SignUpScreen(),
    home: (BuildContext context) => HomeScreen(),
    email_screen: (BuildContext context) => EmailScreen(),
    otp_screen: (BuildContext context) => OtpScreen(),
    profile_screen: (BuildContext context) => ProfileScreen(),
    edit_profile_screen: (BuildContext context) => EditProfileScreen(),
    create_question: (BuildContext context) => CreateQuestionScreen(),
    filter: (BuildContext context) => FilterScreen(),
    my_question: (BuildContext context) => MyQuestionScreen(),
    // answers: (BuildContext context) => AnswersScreen(),
/*
    details_question: (BuildContext context) => DetailsQuestion(),
*/
  };
}
