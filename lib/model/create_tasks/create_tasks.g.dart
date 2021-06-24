// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_tasks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTasks _$CreateTasksFromJson(Map<String, dynamic> json) {
  return CreateTasks(
    title: json['title'] as String?,
    note: json['note'] as String?,
    withTag:
        (json['with_tag'] as List<dynamic>?)?.map((e) => e as String).toList(),
    withSubtask: (json['with_subtask'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    date: json['date'] as String?,
    reminder: json['reminder'] as String?,
    deadline: json['deadline'] == null
        ? null
        : DateTime.parse(json['deadline'] as String),
    priority: json['priority'] as int?,
    done: json['done'] as bool?,
  );
}

Map<String, dynamic> _$CreateTasksToJson(CreateTasks instance) =>
    <String, dynamic>{
      'title': instance.title,
      'note': instance.note,
      'with_tag': instance.withTag,
      'with_subtask': instance.withSubtask,
      'date': instance.date,
      'reminder': instance.reminder,
      'deadline': instance.deadline?.toIso8601String(),
      'priority': instance.priority,
      'done': instance.done,
    };
