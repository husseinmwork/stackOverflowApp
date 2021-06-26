import 'package:json_annotation/json_annotation.dart'; 

part 'get_my_question.g.dart'; 

@JsonSerializable()
class GetMyQuestion {
  @JsonKey(name: 'id')
  final  String? id;
  @JsonKey(name: 'body')
  final  String? body;
  @JsonKey(name: 'votes')
  final  double? votes;
  @JsonKey(name: 'userId')
  final  String? userId;

  GetMyQuestion({this.id, this.body, this.votes, this.userId});

  factory GetMyQuestion.fromJson(Map<String, dynamic> json) => _$GetMyQuestionFromJson(json);

  static GetMyQuestion fromJsonModel(Map<String, dynamic> json) =>
      GetMyQuestion.fromJson(json);

  Map<String, dynamic> toJson() => _$GetMyQuestionToJson(this);
}

