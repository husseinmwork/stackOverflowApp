import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'username')
  final String? userName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'score')
  final int? score;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'Question')
  final List<dynamic>? question;

  @JsonKey(name: 'Answer')
  final List<dynamic>? answer;

  Profile({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.question,
    this.answer,
    this.score,
    this.isActive,
    this.image,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

     String get fullName =>  (firstName??"unknown") + " " + (lastName ??"unknown");




  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
//
//
//
//
// @JsonSerializable()
// class User {
//   @JsonKey(name: 'id')
//   final String? id;
//   @JsonKey(name: 'username')
//   final String? username;
//   @JsonKey(name: 'email')
//   final String? email;
//   @JsonKey(name: 'firstName')
//   final String? firstName;
//   @JsonKey(name: 'lastName')
//   final String? lastName;
//   @JsonKey(name: 'image')
//   final String? image;
//   @JsonKey(name: 'score')
//   final int? score;
//
//   User(
//       { this.id,
//         this.username,
//         this.email,
//         this.firstName,
//         this.lastName,
//         this.score,
//         this.image});
//
//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UserToJson(this);
//
//   String get fullName => (firstName??"null") + (lastName??"null") ;
// }