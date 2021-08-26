// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    id: json['id'] as String?,
    username: json['username'] as String?,
    email: json['email'] as String?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    score: json['score'] as int?,
    image: json['image'] as String?,
    question: json['Question'] as List<dynamic>?,
    answer: json['Answer'] as List<dynamic>?,
    fieldId: json['fieldId'] as String?,
    lat: (json['lat'] as num?)?.toDouble(),
    lng: (json['lng'] as num?)?.toDouble(),
    level: json['level'] as String?,
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'image': instance.image,
      'level': instance.level,
      'fieldId': instance.fieldId,
      'lat': instance.lat,
      'lng': instance.lng,
      'score': instance.score,
      'Question': instance.question,
      'Answer': instance.answer,
    };
