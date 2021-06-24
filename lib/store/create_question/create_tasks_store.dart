// import 'package:flutter/cupertino.dart';
// import 'package:injectable/injectable.dart';
// import 'package:mobx/mobx.dart';
// import 'package:todo_app/data/repositry.dart';
// import 'package:todo_app/model/create_tasks/create_tasks.dart';
// import 'package:todo_app/store/error/error_store.dart';
//
// part 'create_tasks_store.g.dart';
//
// @Injectable()
// class CreateTasksStore = _CreateTasksStore with _$CreateTasksStore;
//
// abstract class _CreateTasksStore with Store {
//   // repository instance
//   late Repository _repository;
//
//   // store for handling error messages
//   final ErrorStore errorStore = ErrorStore();
//
//   _CreateTasksStore(Repository repository) : this._repository = repository;
//
//   @observable
//   bool success = false;
//
//   @observable
//   bool loading = false;
//
//   ///observable create task
//   @observable
//   String? taskUser;
//
//   @observable
//   String? taskTitle;
//
//   @observable
//   String? taskNote;
//
//   // @observable
//   // List<String>? taskTags;
//   @observable
//   ObservableList<String> taskTags = ObservableList<String>();
//
//
//   @observable
//   ObservableList<String> subTask = ObservableList<String>();
//
//   // @observable
//   // List<String>? subTask;
//
//   // @observable
//   // List<Checklist>? taskChecklist;
//
//   @observable
//   String? taskDate;
//
//   @observable
//   String? taskReminder;
//
//   @observable
//   DateTime? taskDeadline;
//
//   @observable
//   bool? taskDoneAt;
//
//   @observable
//   int? taskPriority;
//
//   //crate  tasks
//   @action
//   Future createTask() async {
//     this.loading = true;
//
//     await _repository
//         .createTasks(
//         CreateTasks(
//       title: taskTitle,
//       reminder: taskReminder,
//       priority: taskPriority,
//       note: taskNote,
//       deadline: taskDeadline,
//       date: taskDate,
//       done: taskDoneAt,
//       withSubtask: subTask,
//       withTag: taskTags,
//     ))
//         .then((value) {
//       // tasks.add(value);
//       success = true;
//     })
//         .catchError((e) {
//       this.loading = false;
//       this.success = false;
//       print("error id");
//       debugPrint("this error in create Task $e");
//     });
//   }
// }
