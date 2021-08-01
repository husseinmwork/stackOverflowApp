import 'package:json_annotation/json_annotation.dart';

part 'get_category.g.dart';

@JsonSerializable()
class Category {
  @JsonKey(name: 'id')
  final  String? id;
  @JsonKey(name: 'name')
  final  String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  static Category fromJsonModel(Map<String, dynamic> json) =>
      Category.fromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}