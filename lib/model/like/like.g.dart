// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Like _$LikeFromJson(Map<String, dynamic> json) {
  return Like(
    id: json['id'] as String?,
    questionId: json['questionId'] as String?,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$LikeToJson(Like instance) => <String, dynamic>{
      'id': instance.id,
      'questionId': instance.questionId,
      'type': instance.type,
    };
