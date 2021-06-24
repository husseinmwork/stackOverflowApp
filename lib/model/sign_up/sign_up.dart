import 'package:json_annotation/json_annotation.dart';

part 'sign_up.g.dart';

@JsonSerializable()
class SignUp {
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'score')
  final int? score;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'isAdmin')
  final bool? isAdmin;
  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;

  SignUp(
      { this.firstName,
       this.lastName,
       this.username,
       this.email,
      this.isActive,
      this.isAdmin,
      this.isSuperAdmin,
      this.score,
      this.image,
       this.password});
  factory SignUp.fromJson(Map<String, dynamic> json) => _$SignUpFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpToJson(this);
}
