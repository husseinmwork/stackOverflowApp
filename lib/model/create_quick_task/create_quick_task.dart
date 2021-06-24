import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/constants/strings.dart';

part 'create_quick_task.g.dart';

@JsonSerializable()
class CreateQuickTask {
  @JsonKey(name: 'pk')
  final String? pk;
  @JsonKey(name: 'user')
  final String? user;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'tags')
  final List<String>? tags;
  @JsonKey(name: 'checklist')
  final List<String>? checklist;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'reminder')
  final String? reminder;
  @JsonKey(name: 'deadline')
  final String? deadline;
  @JsonKey(name: 'done_at')
  final bool? doneAt;
  @JsonKey(name: 'priority')
  final int? priority;

  CreateQuickTask(
      {this.pk,
      this.user,
      this.title,
      this.note,
      this.tags,
      this.checklist,
      this.date,
      this.reminder,
      this.deadline,
      this.doneAt,
      this.priority});

  factory CreateQuickTask.fromJson(Map<String, dynamic> json) =>
      _$CreateQuickTaskFromJson(json);

  Map<String, dynamic> toJson() => _$CreateQuickTaskToJson(this);
}


