// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login(
    accessToken: json['token'] as String,
    refreshToken: json['refresh_token'] as String,
    account: Account.fromJson(json['account'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'account': instance.account,
    };

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    id: json['id'] as String?,
    username: json['username'] as String?,
    email: json['email'] as String?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    score: json['score'] as int?,
    image: json['image'] as String?,
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'image': instance.image,
      'score': instance.score,
    };
