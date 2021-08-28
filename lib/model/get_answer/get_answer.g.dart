// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer(
    id: json['id'] as String?,
    body: json['body'] as String,
    votes: (json['votes'] as num?)?.toDouble(),
    userId: json['userId'] as String?,
    user: json['user'] == null
        ? null
        : Account.fromJson(json['user'] as Map<String, dynamic>),
    questionId: json['questionId'] as String?,
  );
}

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'votes': instance.votes,
      'userId': instance.userId,
      'user': instance.user,
      'questionId': instance.questionId,
    };
