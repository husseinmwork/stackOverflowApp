import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/data/network/constant/end_points.dart';
import 'package:todo_app/data/network/dio_client.dart';
import 'package:todo_app/data/network/rest_client.dart';
import 'package:todo_app/model/create_answer/create_answer.dart';
import 'package:todo_app/model/create_question/create_question.dart';
import 'package:todo_app/model/filter/filter.dart';
import 'package:todo_app/model/get_answer/get_answer.dart';
import 'package:todo_app/model/get_category/get_category.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/model/helper/paging.dart';
import 'package:todo_app/model/like/like.dart';
import 'package:todo_app/model/login/login.dart';
import 'package:todo_app/model/profile/profile.dart';
import 'package:todo_app/model/user/user.dart';
import 'package:todo_app/utils/todo/todo_utils.dart';

@Singleton()
class Services {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  Services(this._dioClient, this._restClient);

  // injecting dio instance
  // IbaityApi(this._dioClient, this._restClient);

  ///start Registration
  Future<Map<String, dynamic>> signUp(FormData formData) async {
    try {
      var response = await _dioClient.post(Endpoints.signUp, data: formData);
      return response;
    } catch (e) {
      print("this this$e");
      throw e;
    }
  }

  Future<Login> login(String userName, String password) async {
    try {
      var loginData = {'username': userName, 'password': password};
      var response = await _dioClient.post(Endpoints.login, data: loginData);
      return Login.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future passwordResetRequest(String email) async {
    Map data = {"email": email};
    return await _dioClient
        .post(Endpoints.sendEmail, data: data)
        .catchError((error) => throw error);
  }

  Future sendOtpAndNewPassword(
      String email, int otp, String newPassword) async {
    Map data = {"email": email, "uniqueKey": otp, "password": newPassword};
    return await _dioClient
        .patch(Endpoints.resetPassword, data: data)
        .catchError((error) => throw error);
  }

  ///end registration

  ///get profile
  Future<Profile> getProfile() async {
    try {
      var response = await _dioClient.get(Endpoints.profile);
      return Profile.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  ///update profile
  Future<Account> updateProfile(FormData profile) async {
    try {
      var response =
          await _dioClient.patch(Endpoints.updateProfile, data: profile);
      return Account.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  /// question
  Future<Paging<Question>> getQuestion(
      {int skip = 0, int? take = 1000, QuestionFilter? filter}) async {
    try {
      Map<String, dynamic?> queries = {
        Endpoints.querySkip: skip,
        Endpoints.queryLimit: take
      };

      if (filter != null) {
        queries.addAll(filter.toJson());
      }
      var response = await _dioClient.get(Endpoints.question,
          queryParameters: queries.removeNull());
      var pagination =
          Paging<Question>.fromJson(response, Question.fromJsonModel);
      return pagination;
    } catch (e) {
      throw e;
    }
  }

  Future<Question> getDetailsQuestion(String id) async {
    try {
      var response = await _dioClient.get(Endpoints.question,
          queryParameters: {Endpoints.id:id});
      return Question.fromJson(response['results'][0]);
    } catch (e) {
      throw e;
    }
  }

  Future createQuestion(CreateQuestion createQuestion) async {
    try {
      var response = await _dioClient.post(Endpoints.question,
          data: createQuestion.toJson().removeNull());
      return CreateQuestion.fromJson(response);
    } catch (error) {
      throw error;
    }
  }

  Future<Question> updateQuestion(Question question , String questionId) async {
    try {
      var response =
      await _dioClient.patch(Endpoints.question +'/'+ questionId, data: question.toJson().removeNull());
      return Question.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future deleteQuestion(String questionId)async{
    try{
      var response = await _dioClient.delete(Endpoints.question +'/'+ questionId);
      return response ;
    }catch(error){
      throw error;
    }
  }

  ///Answer
  Future<Paging<Answer>> getAnswers(
      {required int skip ,required int take , required String questionId}) async {
    try {
      Map<String, dynamic?> queries = {
        Endpoints.querySkip: skip,
        Endpoints.queryLimit: take,
        Endpoints.questionId:questionId
      };

      var response = await _dioClient.get(Endpoints.answer,
          queryParameters: queries.removeNull());
      var pagination =
      Paging<Answer>.fromJson(response, Answer.fromJsonModel);
      return pagination;
    } catch (e) {
      throw e;
    }
  }


  Future createAnswer(CreateAnswer createAnswer) async {
    try {
      var response = await _dioClient.post(Endpoints.answer,
          data: createAnswer.toJson());
      return CreateAnswer.fromJson(response);
    } catch (error) {
      throw error;
    }
  }

  ///question Like
  ///work like
  Future<Like> questionLike(Like like)async{
    try {
      var response = await _dioClient.post(Endpoints.questionLike,
          data: like.toJson().removeNull());
      return Like.fromJson(response);
    } catch (error) {
      throw error;
    }
  }

  ///question Like delete
  ///remove like or desLike
  Future questionDeleteLike(String likeId)async{
    try {
      var response = await _dioClient.delete(Endpoints.questionLike +'/'+ likeId);
      return response;
    } catch (error) {
      throw error;
    }
  }

  ///question Like update
  ///convert like into desLike
  Future questionUpdateLike(String likeId , String type)async{
    try {
      var response = await _dioClient.patch(Endpoints.questionLike +'/'+ likeId , data: {"type":type});
      return response;
    } catch (error) {
      throw error;
    }
  }

  ///get category
  Future<Paging<Category>> getCategory({int skip = 0, int? take = 1000}) async {
    try {
      Map<String, dynamic?> queries = {
        Endpoints.querySkip: skip,
        Endpoints.queryLimit: take
      };

      var response = await _dioClient.get(Endpoints.category,
          queryParameters: queries.removeNull());
      var pagination =
          Paging<Category>.fromJson(response, Category.fromJsonModel);
      return pagination;
    } catch (e) {
      throw e;
    }
  }
}
