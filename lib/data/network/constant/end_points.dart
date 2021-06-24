class Endpoints {
  Endpoints._();

  ///this test end point
  static const String baseUrl = "http://192.168.0.62:3000";

  // receiveTimeout
  static const int receiveTimeout = 90000;

  // connectTimeout
  static const int connectionTimeout = 90000;

  ///start: end point of Registration

  static const String login = baseUrl + "/accounts/login";

  static const String signUp = baseUrl + "/accounts/register";

  static const String resetPassword = baseUrl + "/accounts/email";

  ///end: end point of Registration



  static const String profile = baseUrl + "accounts/user/";


  static const String createTask = baseUrl + "task/";

  ///patch function done task
  static const String doneTask = baseUrl + "task/{id}/";
  static const String taskId = 'id';


  static const String refreshToken = baseUrl + "accounts/token/refresh/";


  static const String tags = baseUrl + "tag/";

  static const String querySkip = 'skip';

  static const String queryLimit = 'limit';
}
