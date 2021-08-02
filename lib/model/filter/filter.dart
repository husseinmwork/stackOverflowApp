import 'package:json_annotation/json_annotation.dart';

part 'filter.g.dart';

@JsonSerializable()
class QuestionFilter {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'fieldId')
  final String? fieldId;
  @JsonKey(name: 'minVotes')
  final int? minVotes;
  @JsonKey(name: 'maxVotes')
  final int? maxVotes;
  @JsonKey(name: 'body')
  final String? body;

  QuestionFilter({
    this.id,
    this.userId,
    this.minVotes,
    this.maxVotes,
    this.body,
    this.fieldId
  });

  factory QuestionFilter.fromJson(Map<String, dynamic> json) =>
      _$QuestionFilterFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionFilterToJson(this);

}
