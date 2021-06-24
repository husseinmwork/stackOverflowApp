// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskStore on _TaskStore, Store {
  final _$successAtom = Atom(name: '_TaskStore.success');

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

  final _$loadingAtom = Atom(name: '_TaskStore.loading');

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

  final _$taskUserAtom = Atom(name: '_TaskStore.taskUser');

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

  final _$idAtom = Atom(name: '_TaskStore.id');

  @override
  String? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$taskTitleAtom = Atom(name: '_TaskStore.taskTitle');

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

  final _$taskNoteAtom = Atom(name: '_TaskStore.taskNote');

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

  final _$taskDateAtom = Atom(name: '_TaskStore.taskDate');

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

  final _$taskReminderAtom = Atom(name: '_TaskStore.taskReminder');

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

  final _$taskDeadlineAtom = Atom(name: '_TaskStore.taskDeadline');

  @override
  String? get taskDeadline {
    _$taskDeadlineAtom.reportRead();
    return super.taskDeadline;
  }

  @override
  set taskDeadline(String? value) {
    _$taskDeadlineAtom.reportWrite(value, super.taskDeadline, () {
      super.taskDeadline = value;
    });
  }

  final _$taskDoneAtAtom = Atom(name: '_TaskStore.taskDoneAt');

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

  final _$taskPriorityAtom = Atom(name: '_TaskStore.taskPriority');

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

  final _$quickTasksAtom = Atom(name: '_TaskStore.quickTasks');

  @override
  List<CreateQuickTask?> get quickTasks {
    _$quickTasksAtom.reportRead();
    return super.quickTasks;
  }

  @override
  set quickTasks(List<CreateQuickTask?> value) {
    _$quickTasksAtom.reportWrite(value, super.quickTasks, () {
      super.quickTasks = value;
    });
  }

  final _$tagsResultAtom = Atom(name: '_TaskStore.tagsResult');

  @override
  List<Result> get tagsResult {
    _$tagsResultAtom.reportRead();
    return super.tagsResult;
  }

  @override
  set tagsResult(List<Result> value) {
    _$tagsResultAtom.reportWrite(value, super.tagsResult, () {
      super.tagsResult = value;
    });
  }

  final _$doneTaskAtom = Atom(name: '_TaskStore.doneTask');

  @override
  List<GetTasks> get doneTask {
    _$doneTaskAtom.reportRead();
    return super.doneTask;
  }

  @override
  set doneTask(List<GetTasks> value) {
    _$doneTaskAtom.reportWrite(value, super.doneTask, () {
      super.doneTask = value;
    });
  }

  final _$inboxTasksAtom = Atom(name: '_TaskStore.inboxTasks');

  @override
  List<GetTasks> get inboxTasks {
    _$inboxTasksAtom.reportRead();
    return super.inboxTasks;
  }

  @override
  set inboxTasks(List<GetTasks> value) {
    _$inboxTasksAtom.reportWrite(value, super.inboxTasks, () {
      super.inboxTasks = value;
    });
  }

  final _$missedTaskAtom = Atom(name: '_TaskStore.missedTask');

  @override
  List<GetTasks> get missedTask {
    _$missedTaskAtom.reportRead();
    return super.missedTask;
  }

  @override
  set missedTask(List<GetTasks> value) {
    _$missedTaskAtom.reportWrite(value, super.missedTask, () {
      super.missedTask = value;
    });
  }

  final _$todayTaskAtom = Atom(name: '_TaskStore.todayTask');

  @override
  List<GetTasks> get todayTask {
    _$todayTaskAtom.reportRead();
    return super.todayTask;
  }

  @override
  set todayTask(List<GetTasks> value) {
    _$todayTaskAtom.reportWrite(value, super.todayTask, () {
      super.todayTask = value;
    });
  }

  final _$createQuickTaskAsyncAction =
      AsyncAction('_TaskStore.createQuickTask');

  @override
  Future<dynamic> createQuickTask() {
    return _$createQuickTaskAsyncAction.run(() => super.createQuickTask());
  }

  final _$getTagsAsyncAction = AsyncAction('_TaskStore.getTags');

  @override
  Future<dynamic> getTags(int offset) {
    return _$getTagsAsyncAction.run(() => super.getTags(offset));
  }

  final _$getTasksAsyncAction = AsyncAction('_TaskStore.getTasks');

  @override
  Future<List<GetTasks>> getTasks(int offset) {
    return _$getTasksAsyncAction.run(() => super.getTasks(offset));
  }

  final _$workTaskDoneAsyncAction = AsyncAction('_TaskStore.workTaskDone');

  @override
  Future<DoneTask> workTaskDone() {
    return _$workTaskDoneAsyncAction.run(() => super.workTaskDone());
  }

  @override
  String toString() {
    return '''
success: ${success},
loading: ${loading},
taskUser: ${taskUser},
id: ${id},
taskTitle: ${taskTitle},
taskNote: ${taskNote},
taskDate: ${taskDate},
taskReminder: ${taskReminder},
taskDeadline: ${taskDeadline},
taskDoneAt: ${taskDoneAt},
taskPriority: ${taskPriority},
quickTasks: ${quickTasks},
tagsResult: ${tagsResult},
doneTask: ${doneTask},
inboxTasks: ${inboxTasks},
missedTask: ${missedTask},
todayTask: ${todayTask}
    ''';
  }
}
