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
  @JsonKey(name: 'views')
  final  double? views;
  @JsonKey(name: 'userId')
  final  String? userId;
  @JsonKey(name: 'user')
  final  Account? user;
  @JsonKey(name: 'title')
  final  String? title;
  @JsonKey(name: 'tags')
  final  List<String>? tags;

  Question({this.views, this.tags,this.id, this.body, this.votes, this.user, this.userId , this.title});

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  static Question fromJsonModel(Map<String, dynamic> json) =>
      Question.fromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

