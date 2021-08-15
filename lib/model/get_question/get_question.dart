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
  @JsonKey(name: 'fieldId')
  final  String? categoryId;
  @JsonKey(name: 'createdAt')
  final  String? createdAt;
  @JsonKey(name: 'hasVoted')
  final  String? hasVoted;
  @JsonKey(name: 'tags')
  final  List<String>? tags;
  @JsonKey(name: 'answer')
  final  List<Object>? answer;
  @JsonKey(name: 'votesList')
  final  List<VotesList>? votesList;

  Question({ this.categoryId ,this.createdAt,this.votesList,this.hasVoted,this.answer, this.views, this.tags,this.id, this.body, this.votes, this.user, this.userId , this.title});

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  static Question fromJsonModel(Map<String, dynamic> json) =>
      Question.fromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class VotesList{
  @JsonKey(name: 'id')
  final  String? id;
  @JsonKey(name: 'userId')
  final  String? userId;
  @JsonKey(name: 'questionId')
  final  String? questionId;
  @JsonKey(name: 'type')
  final  String? type;

  VotesList({this.id, this.userId, this.questionId, this.type});

  factory VotesList.fromJson(Map<String, dynamic> json) => _$VotesListFromJson(json);

  static VotesList fromJsonModel(Map<String, dynamic> json) =>
      VotesList.fromJson(json);

  Map<String, dynamic> toJson() => _$VotesListToJson(this);

}