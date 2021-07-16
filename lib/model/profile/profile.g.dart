// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    id: json['id'] as String?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    userName: json['username'] as String?,
    email: json['email'] as String?,
    question: json['Question'] as List<dynamic>?,
    answer: json['Answer'] as List<dynamic>?,
    score: json['score'] as int?,
    isActive: json['isActive'] as bool?,
    image: json['image'] as String?,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.userName,
      'email': instance.email,
      'score': instance.score,
      'isActive': instance.isActive,
      'image': instance.image,
      'Question': instance.question,
      'Answer': instance.answer,
    };
