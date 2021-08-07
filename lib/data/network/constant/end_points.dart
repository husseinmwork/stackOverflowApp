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

  static const String refreshToken = baseUrl + "/accounts/tokens/refresh";

  ///end: end point of Registration

  static const String querySkip = 'skip';
  static const String queryLimit = 'take';
  static const String id = 'id';
  static const String questionId = 'questionId';

  /// question
  static const String question = baseUrl + "/questions";

  ///profile
  static const String profile = baseUrl + "/accounts/profile";
  static const String updateProfile = baseUrl + "/accounts/profile";
/// category
  static const String category = baseUrl + "/fields";
  /// Answer
  static const String answer = baseUrl + "/answers";
  /// question like
  static const String questionLike = baseUrl + "/question/votes";

}
