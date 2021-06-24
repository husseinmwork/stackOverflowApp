import 'package:json_annotation/json_annotation.dart';

part 'create_tasks.g.dart';

@JsonSerializable()
class CreateTasks {
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'with_tag')
  final List<String>? withTag;
  @JsonKey(name: 'with_subtask')
  final List<String>? withSubtask;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'reminder')
  final String? reminder;
  @JsonKey(name: 'deadline')
  final DateTime? deadline;
  @JsonKey(name: 'priority')
  final int? priority;
  @JsonKey(name: 'done')
  final bool? done;

  CreateTasks(
      {this.title,
      this.note,
      this.withTag,
      this.withSubtask,
      this.date,
      this.reminder,
      this.deadline,
      this.priority,
      this.done});

  factory CreateTasks.fromJson(Map<String, dynamic> json) =>
      _$CreateTasksFromJson(json);



  Map<String, dynamic> toJson() => _$CreateTasksToJson(this);
}
