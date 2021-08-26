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
    level: json['level'] as String?,
    lng: (json['lng'] as num?)?.toDouble(),
    lat: (json['lat'] as num?)?.toDouble(),
    fieldId: json['fieldId'] as String?,
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
      'level': instance.level,
      'fieldId': instance.fieldId,
      'lat': instance.lat,
      'lng': instance.lng,
      'Question': instance.question,
      'Answer': instance.answer,
    };
