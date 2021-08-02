// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    views: (json['views'] as num?)?.toDouble(),
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    id: json['id'] as String?,
    body: json['body'] as String?,
    votes: (json['votes'] as num?)?.toDouble(),
    user: json['user'] == null
        ? null
        : Account.fromJson(json['user'] as Map<String, dynamic>),
    userId: json['userId'] as String?,
    title: json['title'] as String?,
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'votes': instance.votes,
      'views': instance.views,
      'userId': instance.userId,
      'user': instance.user,
      'title': instance.title,
      'tags': instance.tags,
    };
