class Endpoints {
  Endpoints._();

  ///this test end point
  static const String baseUrl = "http://stack-overflow-app.herokuapp.com";

  // receiveTimeout
  static const int receiveTimeout = 90000;

  // connectTimeout
  static const int connectionTimeout = 90000;

  ///start: end point of Registration

  static const String login = baseUrl + "/accounts/login";
  static const String signUp = baseUrl + "/accounts/register";
  static const String sendEmail = baseUrl + "/accounts/passwords/email";
  static const String resetPassword = baseUrl + "/accounts/passwords/reset";

  ///end: end point of Registration

  ///get my question
  static const String getQuestion = baseUrl + "/questions";
  static const String querySkip = 'skip';
  static const String queryLimit = 'take';

  ///get profile
  static const String profile = baseUrl + "/accounts/profile";




  static const String refreshToken = baseUrl + "accounts/token/refresh/";

}
