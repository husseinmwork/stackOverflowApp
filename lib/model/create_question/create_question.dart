import 'package:json_annotation/json_annotation.dart'; 

part 'create_question.g.dart'; 

@JsonSerializable()
class CreateQuestion {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'body')
  String? body;
  @JsonKey(name: 'votes')
  int? votes;
  @JsonKey(name: 'userId')
  String? userId;

  CreateQuestion({this.id, this.body, this.votes, this.userId});

  factory CreateQuestion.fromJson(Map<String, dynamic> json) => _$CreateQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$CreateQuestionToJson(this);
}

