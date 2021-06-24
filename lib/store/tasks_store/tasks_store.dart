import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/create_quick_task/create_quick_task.dart';
import 'package:todo_app/model/done_tasks/done_task.dart';
import 'package:todo_app/model/get_tasks/get_tasks.dart';
import 'package:todo_app/model/login/login.dart';
import 'package:todo_app/model/tags/tags.dart';
import 'package:todo_app/store/error/error_store.dart';

part 'tasks_store.g.dart';

@Injectable()
class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  bool isLoggedIn = false;

  _TaskStore(Repository repository) : this._repository = repository ;

// get user form pref
//   @observable
//   User? user;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  ///observable create task
  @observable
  String? taskUser;

  @observable
  String? id;

  @observable
  String? taskTitle;

  @observable
  String? taskNote;


  @observable
  String? taskDate;

  @observable
  String? taskReminder;

  @observable
  String? taskDeadline;

  @observable
  bool? taskDoneAt;

  @observable
  int? taskPriority;

  @observable
  List<CreateQuickTask?> quickTasks = ObservableList<CreateQuickTask?>();


  @observable
  List<Result> tagsResult = ObservableList<Result>();
  //
  // @observable
  // List<DoneTask> taskDone = ObservableList<DoneTask>();





  //all tasks

  @observable
  List<GetTasks> doneTask = ObservableList<GetTasks>();

  @observable
  List<GetTasks> inboxTasks = ObservableList<GetTasks>();

  @observable
  List<GetTasks> missedTask = ObservableList<GetTasks>();

  @observable
  List<GetTasks> todayTask = ObservableList<GetTasks>();



  ///crate quick tasks
  @action
  Future createQuickTask() async {
    await _repository
        .createQuickTasks(CreateQuickTask(
      pk: id,
      title: taskTitle,
      user: taskUser,
      checklist: null,
      date: taskDate,
      deadline: taskDeadline,
      doneAt: taskDoneAt,
      note: taskNote,
      priority: taskPriority,
      reminder: taskReminder,
      tags: null,
    ))
        .then((value) {
      quickTasks.add(value);
    }).catchError((e) {
      debugPrint("this error in create Task $e");
    });
  }

  ///this method get tags with paging
  @action
  Future getTags(int offset) async {
    return await _repository.getTags(offset).then((value) {
      this.tagsResult = value.results;
      return value.results;
    }).catchError((e) {
      debugPrint("this error in get tags$e");
    });
  }


  addTaskDone(List<GetTasks> tasks){
    if(doneTask.isNotEmpty)
      doneTask = [];
    for(var done in tasks){
      if(done.doneAt != null){
        doneTask.add(done);
      }
    }
  }

  addInboxTasks(List<GetTasks> tasks){
    if(inboxTasks.isNotEmpty)
      inboxTasks = [];
    for(var task in tasks){
      if(task.date == null){
        inboxTasks.add(task);
      }
    }
  }

  addMissed(List<GetTasks> tasks){
    if(missedTask.isNotEmpty)
      missedTask = [];
    for(var task in tasks){
      if(task.date != null && task.date!.compareTo(DateTime.now()) < 0){
        missedTask.add(task);
      }
    }
  }

  addToday(List<GetTasks> tasks){
    if(todayTask.isNotEmpty)
      todayTask = [];
    for(var task in tasks){
      if(task.date != null && task.date!.compareTo(DateTime.now()) == 0){
        todayTask.add(task);
      }
    }
  }


  ///this method get tasks with paging
  @action
  Future<List<GetTasks>> getTasks(int offset) async {
    return await _repository.getTasks(offset).then((value) {
      addTaskDone(value.results);
      addInboxTasks(value.results);
      addMissed(value.results);
      addToday(value.results);
      return value.results;
    }).catchError((e) {
      debugPrint("this error in get tasks$e");
    });
  }


  @action
  Future<DoneTask> workTaskDone() async {
    return await _repository
        .doneTask(id!)
        .then((value) {
      // this.taskDone.add(value);

      return value;
    })
        .catchError((e) {
      debugPrint("this error in get tags$e");
    });
  }
}