import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/model/user/user.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  @JsonKey(name: 'token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'user')
  final Account user;

  Login({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

