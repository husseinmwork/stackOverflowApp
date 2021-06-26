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
  static const String sendEmail = baseUrl + "/accounts/email";
  static const String resetPassword = baseUrl + "/accounts/passwords/reset";

  ///end: end point of Registration


  ///get my question
  static const String getMyQuestion = baseUrl + "/questions";
  static const String querySkip = 'skip';
  static const String queryLimit = 'take';







  ///patch function done task
  static const String doneTask = baseUrl + "task/{id}/";
  static const String taskId = 'id';


  static const String refreshToken = baseUrl + "accounts/token/refresh/";


  static const String tags = baseUrl + "tag/";


}
