import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class Account {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'score')
  final int? score;
  @JsonKey(name: 'Question')
  final List<dynamic>? question;
  @JsonKey(name: 'Answer')
  final List<dynamic>? answer;

  Account(
      {this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.score,
      this.image,
      this.question,
      this.answer});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  String get fullName => (firstName ?? "null") + (lastName ?? "null");
}
