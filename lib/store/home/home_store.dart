import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/model/user/user.dart';
import 'package:todo_app/store/error/error_store.dart';

part 'home_store.g.dart';

@Injectable()
class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  bool isLoggedIn = false;

  _HomeStore(Repository repository) : this._repository = repository {
    // checking if user is logged in
    repository.isLoggedIn.then((value) => this.isLoggedIn = value);
  }

// get user form pref
  @observable
  Account? user;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  //User screen Scroll
  @observable
  ScrollController controller = ScrollController();

  @observable
  bool fabIsVisible = false;

  @observable
  List<String> socialLinkAgent = ObservableList<String>();

  // actions:-------------------------------------------------------------------
  @action
  void updateScrolling() {
    controller.addListener(() {
      this.fabIsVisible =
          controller.position.userScrollDirection == ScrollDirection.reverse;
    });
  }

  @action
  void disposeController() {
    controller.removeListener(() {});
  }

  ///this method work logout and remove (user , authToken , IsLoggedIn) shared preferences
  @action
  logout() async {
    user = null;
    _repository.removeUser();
    _repository.removeIsLoggedIn();
    _repository.removeAuthToken();
    user = await _repository.user;
    // // todo handel error
    // debugPrint(user.toString());
  }

  @action
  getPrefUser() async {
    user = await _repository.user;
  }

  @observable
  List<Question> question = ObservableList<Question>();


  ///get question with paging
  @action
  Future getQuestion(int skip) async {
     await _repository
        .getQuestion(skip)
        .then((value) => question = value.results)
        .catchError((e) {
      throw e;
    });
  }
}
