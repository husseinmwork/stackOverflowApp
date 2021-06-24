import 'package:json_annotation/json_annotation.dart'; 

part 'tags.g.dart'; 

@JsonSerializable()
class Tags {
  @JsonKey(name: 'count')
  final  int? count;
  @JsonKey(name: 'next')
  final  int? next;
  @JsonKey(name: 'previous')
  final  int? previous;
  @JsonKey(name: 'results')
  final  List<Result>? results;

  Tags({this.count, this.next, this.previous, this.results});

  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);

  static Tags fromJsonModel(Map<String, dynamic> json) =>
      Tags.fromJson(json);


  Map<String, dynamic> toJson() => _$TagsToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: 'id')
  final  String? id;
  @JsonKey(name: 'name')
  final  String? name;
  @JsonKey(name: 'color')
  final  int? color;
  @JsonKey(name: 'user')
  final  String? user;

  Result({this.id, this.name, this.color, this.user});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  static Result fromJsonModel(Map<String, dynamic> json) =>
      Result.fromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

