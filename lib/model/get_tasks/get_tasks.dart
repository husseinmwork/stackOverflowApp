import 'package:json_annotation/json_annotation.dart'; 

part 'get_tasks.g.dart'; 


@JsonSerializable()
class GetTasks {
  @JsonKey(name: 'pk')
  final  String? pk;
  @JsonKey(name: 'user')
  final  String? user;
  @JsonKey(name: 'title')
  final  String? title;
  @JsonKey(name: 'note')
  final  String? note;
  @JsonKey(name: 'tags')
  final  List<Tag>? tags;
  @JsonKey(name: 'checklist')
  final  List<Checklist>? checklist;
  @JsonKey(name: 'date')
  final  DateTime? date;
  @JsonKey(name: 'reminder')
  final  String? reminder;
  @JsonKey(name: 'deadline')
  final  String? deadline;
  @JsonKey(name: 'done_at')
  final  String? doneAt;
  @JsonKey(name: 'priority')
  final  int? priority;

  GetTasks({this.pk, this.user, this.title, this.note, this.tags, this.checklist, this.date, this.reminder, this.deadline, this.doneAt, this.priority});

  factory GetTasks.fromJson(Map<String, dynamic> json) => _$GetTasksFromJson(json);

  static GetTasks fromJsonModel(Map<String, dynamic> json) =>
      GetTasks.fromJson(json);

  Map<String, dynamic> toJson() => _$GetTasksToJson(this);
}

@JsonSerializable()
class Tag {
  @JsonKey(name: 'id')
  final  String? id;
  @JsonKey(name: 'name')
  final  String? name;
  @JsonKey(name: 'color')
  final  int? color;
  @JsonKey(name: 'user')
  final  String? user;

  Tag({this.id, this.name, this.color, this.user});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}


//todo this sub task
@JsonSerializable()
class Checklist {
  @JsonKey(name: 'id')
  final  String? id;
  @JsonKey(name: 'title')
  final  String? title;
  @JsonKey(name: 'done')
  final  bool? done;
  @JsonKey(name: 'task')
  final  String? task;

  Checklist({this.id, this.title, this.done, this.task});

  factory Checklist.fromJson(Map<String, dynamic> json) => _$ChecklistFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistToJson(this);
}

