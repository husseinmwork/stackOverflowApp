import 'package:json_annotation/json_annotation.dart';

part 'filter.g.dart';

@JsonSerializable()
class QuestionFilter {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'userId')
  final String? userId;

  @JsonKey(name: 'questionId')
  final String? questionId;

  @JsonKey(name: 'fieldId')
  final String? fieldId;
  @JsonKey(name: 'minVotes')
  final int? minVotes;
  @JsonKey(name: 'maxVotes')
  final int? maxVotes;
  @JsonKey(name: 'minViews')
  final int? minViews;
  @JsonKey(name: 'maxViews')
  final int? maxViews;
  @JsonKey(name: 'body')
  final String? body;
  @JsonKey(name: 'tags')
  final List<String>? tags;

  QuestionFilter({
    this.id,
    this.userId,
    this.minVotes,
    this.maxVotes,
    this.body,
    this.fieldId,
    this.minViews,
    this.maxViews,
    this.tags,
    this.questionId
  });

  factory QuestionFilter.fromJson(Map<String, dynamic> json) =>
      _$QuestionFilterFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionFilterToJson(this);

}
