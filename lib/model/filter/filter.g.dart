// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionFilter _$QuestionFilterFromJson(Map<String, dynamic> json) {
  return QuestionFilter(
    id: json['id'] as String?,
    userId: json['userId'] as String?,
    minVotes: json['minVotes'] as int?,
    maxVotes: json['maxVotes'] as int?,
    body: json['body'] as String?,
    fieldId: json['fieldId'] as String?,
    minViews: json['minViews'] as int?,
    maxViews: json['maxViews'] as int?,
    tags: (json['tags'] as List<dynamic>?)?.length == 1? json['tags[0]'] :(json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    // tags: (json['tags'] as List<dynamic>?)?.length == 1? json['tags[0]'] :(json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    questionId: json['questionId'] as String?,
    oldest: json['createdAt'] as String?,
  );
}

Map<String, dynamic> _$QuestionFilterToJson(QuestionFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'questionId': instance.questionId,
      'fieldId': instance.fieldId,
      'minVotes': instance.minVotes,
      'maxVotes': instance.maxVotes,
      'minViews': instance.minViews,
      'maxViews': instance.maxViews,
      'body': instance.body,
      'createdAt': instance.oldest,
      instance.tags?.length == 1?'tags[0]' :'tags': instance.tags,
      // instance.tags?.length == 1?'tags[0]' :'tags': instance.tags,
    };
