import 'package:json_annotation/json_annotation.dart';

part 'create_answer.g.dart';

@JsonSerializable()
class CreateAnswer {
  @JsonKey(name: 'body')
  String body;
  @JsonKey(name: 'questionId')
  String questionId;

  CreateAnswer({required this.body, required this.questionId});

  factory CreateAnswer.fromJson(Map<String, dynamic> json) =>
      _$CreateAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAnswerToJson(this);
}
