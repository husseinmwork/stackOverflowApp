import 'package:json_annotation/json_annotation.dart'; 

part 'create_question.g.dart'; 

@JsonSerializable()
class CreateQuestion {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'body')
  String? body;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'tags')
  List<String>? tags;

  @JsonKey(name: 'votes')
  int? votes;

  @JsonKey(name: 'userId')
  String? userId;

  @JsonKey(name: 'fieldId')
  String? fieldId;

  CreateQuestion({ this.fieldId,this.tags,this.title, this.id, this.body, this.votes, this.userId});

  factory CreateQuestion.fromJson(Map<String, dynamic> json) => _$CreateQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$CreateQuestionToJson(this);
}

