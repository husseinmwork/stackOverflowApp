import 'package:json_annotation/json_annotation.dart'; 

part 'profile.g.dart'; 

@JsonSerializable()
class Profile {
  @JsonKey(name: 'pk')
  final  String? pk;
  @JsonKey(name: 'first_name')
  final  String? firstName;
  @JsonKey(name: 'last_name')
  final  String? lastName;
  @JsonKey(name: 'username')
  final  String? username;
  @JsonKey(name: 'email')
  final  String? email;
  @JsonKey(name: 'birthdate')
  final  String? birthdate;
  @JsonKey(name: 'timezone')
  final  String? timezone;
  @JsonKey(name: 'image')
  final  String? image;
  @JsonKey(name: 'daily_progress')
  final  double? dailyProgress;

  Profile({this.pk, this.firstName, this.lastName, this.username, this.email, this.birthdate, this.timezone, this.image, this.dailyProgress});

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

