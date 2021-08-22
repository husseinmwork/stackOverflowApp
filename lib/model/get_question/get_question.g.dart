// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    category: json['field'] == null
        ? null
        : Field.fromJson(json['field'] as Map<String, dynamic>),
    categoryId: json['fieldId'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    votesList: (json['votesList'] as List<dynamic>?)
        ?.map((e) => VotesList.fromJson(e as Map<String, dynamic>))
        .toList(),
    hasVoted: json['hasVoted'] as String?,
    answer:
        (json['answer'] as List<dynamic>?)?.map((e) => e as Object).toList(),
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
      'fieldId': instance.categoryId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'hasVoted': instance.hasVoted,
      'tags': instance.tags,
      'answer': instance.answer,
      'votesList': instance.votesList,
      'field': instance.category,
    };

VotesList _$VotesListFromJson(Map<String, dynamic> json) {
  return VotesList(
    id: json['id'] as String?,
    userId: json['userId'] as String?,
    questionId: json['questionId'] as String?,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$VotesListToJson(VotesList instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'questionId': instance.questionId,
      'type': instance.type,
    };

Field _$FieldFromJson(Map<String, dynamic> json) {
  return Field(
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'name': instance.name,
    };
