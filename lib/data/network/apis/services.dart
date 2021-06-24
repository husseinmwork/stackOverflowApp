import 'package:injectable/injectable.dart';
import 'package:todo_app/data/network/constant/end_points.dart';
import 'package:todo_app/data/network/dio_client.dart';
import 'package:todo_app/data/network/rest_client.dart';
import 'package:todo_app/model/create_quick_task/create_quick_task.dart';
import 'package:todo_app/model/create_tasks/create_tasks.dart';
import 'package:todo_app/model/done_tasks/done_task.dart';
import 'package:todo_app/model/get_tasks/get_tasks.dart';
import 'package:todo_app/model/helper/paging.dart';
import 'package:todo_app/model/login/login.dart';
import 'package:todo_app/model/profile/profile.dart';
import 'package:todo_app/model/sign_up/sign_up.dart';
import 'package:todo_app/model/tags/tags.dart';
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
  Future<Map<String, dynamic>> signUp(SignUp signUp) async {
    try {
      var response =
          await _dioClient.post(Endpoints.signUp, data: signUp.toJson().removeNull());
      return response;
    } catch (e) {
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
    return await _dioClient.patch(Endpoints.resetPassword, data: data);
  }

  ///end registration



  ///get profile
  // Future<Profile> getProfile() async {
  //   try {
  //     var response = await _dioClient.get(Endpoints.profile);
  //     return Profile.fromJson(response);
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  ///get tasks with paging
  //todo remove this
  // Future<Paging<GetTasks>> getTasks({
  //   int offset = 0,
  //   int? limit = 1000,
  // }) async {
  //   try {
  //     Map<String, dynamic?> queries = {
  //       Endpoints.querySkip: offset,
  //       Endpoints.queryLimit: limit
  //     };
  //
  //     var response =
  //     await _dioClient.get(Endpoints.createTask, queryParameters: queries);
  //     var pagination = Paging<GetTasks>.fromJson(response, GetTasks.fromJsonModel);
  //     return pagination;
  //   } catch (e) {
  //     throw e;
  //   }
  // }



}
