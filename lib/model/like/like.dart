import 'package:json_annotation/json_annotation.dart';

part 'like.g.dart';

@JsonSerializable()
class Like {
  @JsonKey(name: 'questionId')
  final String questionId;
  @JsonKey(name: 'type')
  final String type;

  factory Like.fromJson(Map<String, dynamic> json) => _$LikeFromJson(json);

  Like({required this.questionId, required this.type});

  static Like fromJsonModel(Map<String, dynamic> json) =>
      Like.fromJson(json);

   Map<String, dynamic> toJson() => _$LikeToJson(this);
}
