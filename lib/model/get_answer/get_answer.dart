import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/model/user/user.dart';

part 'get_answer.g.dart';

@JsonSerializable()
class Answer {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'body')
  final String body;
  @JsonKey(name: 'votes')
  final double? votes;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'user')
  final Account? user;
  @JsonKey(name: 'questionId')
  final String? questionId;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Answer(
      {required this.id,
      required this.body,
      this.votes,
      this.userId,
      this.user,
      this.questionId});

  static Answer fromJsonModel(Map<String, dynamic> json) =>
      Answer.fromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
