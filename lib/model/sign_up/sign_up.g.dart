// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUp _$SignUpFromJson(Map<String, dynamic> json) {
  return SignUp(
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    username: json['username'] as String?,
    email: json['email'] as String?,
    isActive: json['isActive'] as bool?,
    isAdmin: json['isAdmin'] as bool?,
    isSuperAdmin: json['isSuperAdmin'] as bool?,
    score: json['score'] as int?,
    image: json['image'] as Object?,
    password: json['password'] as String?,
  );
}

Map<String, dynamic> _$SignUpToJson(SignUp instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'email': instance.email,
      'image':instance.image,
      'password': instance.password,
      'score': instance.score,
      'isActive': instance.isActive,
      'isAdmin': instance.isAdmin,
      'isSuperAdmin': instance.isSuperAdmin,
    };
