// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login(
    accessToken: json['token'] as String,
    refreshToken: json['refresh_token'] as String,
    user: Account.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'user': instance.user,
    };
