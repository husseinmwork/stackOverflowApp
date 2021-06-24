// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_quick_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateQuickTask _$CreateQuickTaskFromJson(Map<String, dynamic> json) {
  return CreateQuickTask(
    pk: json['pk'] as String?,
    user: json['user'] as String?,
    title: json['title'] as String?,
    note: json['note'] as String?,
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    checklist:
        (json['checklist'] as List<dynamic>?)?.map((e) => e as String).toList(),
    date: json['date'] as String?,
    reminder: json['reminder'] as String?,
    deadline: json['deadline'] as String?,
    doneAt: json['done_at'] as bool?,
    priority: json['priority'] as int?,
  );
}

Map<String, dynamic> _$CreateQuickTaskToJson(CreateQuickTask instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'user': instance.user,
      'title': instance.title,
      'note': instance.note,
      'tags': instance.tags,
      'checklist': instance.checklist,
      'date': instance.date,
      'reminder': instance.reminder,
      'deadline': instance.deadline,
      'done_at': instance.doneAt,
      'priority': instance.priority,
    };
