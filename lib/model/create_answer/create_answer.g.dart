// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAnswer _$CreateAnswerFromJson(Map<String, dynamic> json) {
  return CreateAnswer(
    body: json['body'] as String,
    questionId: json['questionId'] as String,
  );
}

Map<String, dynamic> _$CreateAnswerToJson(CreateAnswer instance) =>
    <String, dynamic>{
      'body': instance.body,
      'questionId': instance.questionId,
    };
