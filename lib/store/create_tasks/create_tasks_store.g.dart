// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_tasks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateTasksStore on _CreateTasksStore, Store {
  final _$successAtom = Atom(name: '_CreateTasksStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$loadingAtom = Atom(name: '_CreateTasksStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$taskUserAtom = Atom(name: '_CreateTasksStore.taskUser');

  @override
  String? get taskUser {
    _$taskUserAtom.reportRead();
    return super.taskUser;
  }

  @override
  set taskUser(String? value) {
    _$taskUserAtom.reportWrite(value, super.taskUser, () {
      super.taskUser = value;
    });
  }

  final _$taskTitleAtom = Atom(name: '_CreateTasksStore.taskTitle');

  @override
  String? get taskTitle {
    _$taskTitleAtom.reportRead();
    return super.taskTitle;
  }

  @override
  set taskTitle(String? value) {
    _$taskTitleAtom.reportWrite(value, super.taskTitle, () {
      super.taskTitle = value;
    });
  }

  final _$taskNoteAtom = Atom(name: '_CreateTasksStore.taskNote');

  @override
  String? get taskNote {
    _$taskNoteAtom.reportRead();
    return super.taskNote;
  }

  @override
  set taskNote(String? value) {
    _$taskNoteAtom.reportWrite(value, super.taskNote, () {
      super.taskNote = value;
    });
  }

  final _$taskTagsAtom = Atom(name: '_CreateTasksStore.taskTags');

  @override
  ObservableList<String> get taskTags {
    _$taskTagsAtom.reportRead();
    return super.taskTags;
  }

  @override
  set taskTags(ObservableList<String> value) {
    _$taskTagsAtom.reportWrite(value, super.taskTags, () {
      super.taskTags = value;
    });
  }

  final _$subTaskAtom = Atom(name: '_CreateTasksStore.subTask');

  @override
  ObservableList<String> get subTask {
    _$subTaskAtom.reportRead();
    return super.subTask;
  }

  @override
  set subTask(ObservableList<String> value) {
    _$subTaskAtom.reportWrite(value, super.subTask, () {
      super.subTask = value;
    });
  }

  final _$taskDateAtom = Atom(name: '_CreateTasksStore.taskDate');

  @override
  String? get taskDate {
    _$taskDateAtom.reportRead();
    return super.taskDate;
  }

  @override
  set taskDate(String? value) {
    _$taskDateAtom.reportWrite(value, super.taskDate, () {
      super.taskDate = value;
    });
  }

  final _$taskReminderAtom = Atom(name: '_CreateTasksStore.taskReminder');

  @override
  String? get taskReminder {
    _$taskReminderAtom.reportRead();
    return super.taskReminder;
  }

  @override
  set taskReminder(String? value) {
    _$taskReminderAtom.reportWrite(value, super.taskReminder, () {
      super.taskReminder = value;
    });
  }

  final _$taskDeadlineAtom = Atom(name: '_CreateTasksStore.taskDeadline');

  @override
  DateTime? get taskDeadline {
    _$taskDeadlineAtom.reportRead();
    return super.taskDeadline;
  }

  @override
  set taskDeadline(DateTime? value) {
    _$taskDeadlineAtom.reportWrite(value, super.taskDeadline, () {
      super.taskDeadline = value;
    });
  }

  final _$taskDoneAtAtom = Atom(name: '_CreateTasksStore.taskDoneAt');

  @override
  bool? get taskDoneAt {
    _$taskDoneAtAtom.reportRead();
    return super.taskDoneAt;
  }

  @override
  set taskDoneAt(bool? value) {
    _$taskDoneAtAtom.reportWrite(value, super.taskDoneAt, () {
      super.taskDoneAt = value;
    });
  }

  final _$taskPriorityAtom = Atom(name: '_CreateTasksStore.taskPriority');

  @override
  int? get taskPriority {
    _$taskPriorityAtom.reportRead();
    return super.taskPriority;
  }

  @override
  set taskPriority(int? value) {
    _$taskPriorityAtom.reportWrite(value, super.taskPriority, () {
      super.taskPriority = value;
    });
  }

  final _$createTaskAsyncAction = AsyncAction('_CreateTasksStore.createTask');

  @override
  Future<dynamic> createTask() {
    return _$createTaskAsyncAction.run(() => super.createTask());
  }

  @override
  String toString() {
    return '''
success: ${success},
loading: ${loading},
taskUser: ${taskUser},
taskTitle: ${taskTitle},
taskNote: ${taskNote},
taskTags: ${taskTags},
subTask: ${subTask},
taskDate: ${taskDate},
taskReminder: ${taskReminder},
taskDeadline: ${taskDeadline},
taskDoneAt: ${taskDoneAt},
taskPriority: ${taskPriority}
    ''';
  }
}
