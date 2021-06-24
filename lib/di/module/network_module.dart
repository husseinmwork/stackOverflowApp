import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/data/network/constant/end_points.dart';
import 'package:todo_app/data/sharedpref/shared_preference_helper.dart';
import 'package:todo_app/store/error/error_store.dart';

@module
abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  /// TODO refresh token https://stackoverflow.com/a/58461668/12262942
  @factoryMethod
  Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      // TODO delete in realise
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options,
                RequestInterceptorHandler handler) async {
          // getting token
          var token = await sharedPrefHelper.authToken;
          debugPrint('network token: $token');
          if (token != null) {
            options.headers["Authorization"] = "Bearer " + token['accessToken'];
          }
          // else {
          //   options.headers["Authorization"] = "Bearer " + ".";
          // }

          return handler.next(options);
        },

            // onResponse: (Response response , __) {
            //   final int statusCode = response.statusCode!;
            //   var results ;
            //
            //   if (statusCode == 401) {
            //     results = response.statusCode;
            //     print("this result from dio response  ${results}");
            //
            //   }
            //
            //   // return response;
            // },
            ///this refresh token for app
            onError: (DioError e, handler) async {
          final error = e.response;
          var token = await sharedPrefHelper.authToken;
          if (error?.statusCode == 401 && token != null) {
            var response = await dio.post(Endpoints.refreshToken,
                data: {'refresh': token['refreshToken']}).then((value) {
              print(
                  "this refresh token before save in shaerd preferances response $value");
              sharedPrefHelper.saveAuthToken(
                {
                  'accessToken': value.data['access'],
                  'refreshToken': value.data['refresh']
                },
              );
              print("this refresh token response $value");

              //todo if false use resolve
              ///this function send the request again
              //              handler.next(e);
            });
          }
          //this error in handel error 400
          handler.next(e);
        }),
      );

    return dio;
  }
}
