// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tasks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTasks _$GetTasksFromJson(Map<String, dynamic> json) {
  return GetTasks(
    pk: json['pk'] as String?,
    user: json['user'] as String?,
    title: json['title'] as String?,
    note: json['note'] as String?,
    tags: (json['tags'] as List<dynamic>?)
        ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
        .toList(),
    checklist: (json['checklist'] as List<dynamic>?)
        ?.map((e) => Checklist.fromJson(e as Map<String, dynamic>))
        .toList(),
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    reminder: json['reminder'] as String?,
    deadline: json['deadline'] as String?,
    doneAt: json['done_at'] as String?,
    priority: json['priority'] as int?,
  );
}

Map<String, dynamic> _$GetTasksToJson(GetTasks instance) => <String, dynamic>{
      'pk': instance.pk,
      'user': instance.user,
      'title': instance.title,
      'note': instance.note,
      'tags': instance.tags,
      'checklist': instance.checklist,
      'date': instance.date?.toIso8601String(),
      'reminder': instance.reminder,
      'deadline': instance.deadline,
      'done_at': instance.doneAt,
      'priority': instance.priority,
    };

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag(
    id: json['id'] as String?,
    name: json['name'] as String?,
    color: json['color'] as int?,
    user: json['user'] as String?,
  );
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'user': instance.user,
    };

Checklist _$ChecklistFromJson(Map<String, dynamic> json) {
  return Checklist(
    id: json['id'] as String?,
    title: json['title'] as String?,
    done: json['done'] as bool?,
    task: json['task'] as String?,
  );
}

Map<String, dynamic> _$ChecklistToJson(Checklist instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'done': instance.done,
      'task': instance.task,
    };
