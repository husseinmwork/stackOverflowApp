// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    id: json['id'] as String?,
    body: json['body'] as String?,
    votes: (json['votes'] as num?)?.toDouble(),
    userId: json['userId'] as String?,
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'votes': instance.votes,
      'userId': instance.userId,
    };
