import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  @JsonKey(name: 'token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'account')
  final Account account;

  Login({
    required this.accessToken,
    required this.refreshToken,
    required this.account,
  });

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@JsonSerializable()
class Account {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'score')
  final int? score;

  Account(
      { this.id,
     this.username,
     this.email,
     this.firstName,
     this.lastName,
     this.score,
     this.image});

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  String get fullName => (firstName??"null") + (lastName??"null") ;
}
