// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tags _$TagsFromJson(Map<String, dynamic> json) {
  return Tags(
    count: json['count'] as int?,
    next: json['next'] as int?,
    previous: json['previous'] as int?,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    id: json['id'] as String?,
    name: json['name'] as String?,
    color: json['color'] as int?,
    user: json['user'] as String?,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'user': instance.user,
    };
