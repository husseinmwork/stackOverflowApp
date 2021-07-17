import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/model/user/user.dart';

part 'get_question.g.dart';

@JsonSerializable()
class Question {
  @JsonKey(name: 'id')
  final  String? id;
  @JsonKey(name: 'body')
  final  String? body;
  @JsonKey(name: 'votes')
  final  double? votes;
  @JsonKey(name: 'userId')
  final  String? userId;
  @JsonKey(name: 'user')
  final  Account? user;

  Question({this.id, this.body, this.votes, this.user, this.userId});

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  static Question fromJsonModel(Map<String, dynamic> json) =>
      Question.fromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

