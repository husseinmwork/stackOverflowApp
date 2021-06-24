import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  @JsonKey(name: 'token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  // @JsonKey(name: 'user')
  // final User user;

  Login(
      {required this.accessToken,
      required this.refreshToken});

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
//
// @JsonSerializable()
// class User {
//   @JsonKey(name: 'id')
//   final String id;
//   @JsonKey(name: 'username')
//   final String username;
//   @JsonKey(name: 'email')
//   final String email;
//   @JsonKey(name: 'firstName')
//   final String firstName;
//   @JsonKey(name: 'lastName')
//   final String lastName;
//
//
//   User(
//       {required this.id,
//       required this.username,
//       required this.email,
//       required this.firstName,
//       required this.lastName});
//
//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UserToJson(this);
//
//   String get fullName => (firstName) + (lastName);
//
// }
