import 'package:dio/dio.dart';

class DioErrorUtil {
  // general methods:------------------------------------------------------------
  static String handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          if (error.response?.statusCode == 400)
            // errorDescription = "Received invalid status code: ${error.response}";
            errorDescription = "invalid credentials";
          else if (error.response?.statusCode == 401) {
            errorDescription =
                "Received invalid status code: ${error.response}";
          } else if (error.response?.statusCode == 404) {
            errorDescription =
                "Received invalid status code: ${error.response?.statusCode} email not found";
          } else
            errorDescription = "Unexpected error occurred";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occurred";
    }
    return errorDescription;
  }
}
