// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateQuestion _$CreateQuestionFromJson(Map<String, dynamic> json) {
  return CreateQuestion(
    fieldId: json['fieldId'] as String?,
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    title: json['title'] as String?,
    id: json['id'] as String?,
    body: json['body'] as String?,
    votes: json['votes'] as int?,
    userId: json['userId'] as String?,
  );
}

Map<String, dynamic> _$CreateQuestionToJson(CreateQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'title': instance.title,
      'tags': instance.tags,
      'votes': instance.votes,
      'userId': instance.userId,
      'fieldId': instance.fieldId,
    };
