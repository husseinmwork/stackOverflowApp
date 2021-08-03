import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/get_category/get_category.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/model/user/user.dart';
import 'package:todo_app/model/filter/filter.dart';
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
  QuestionFilter? filter;

  @observable
  int? minVotes;

  @observable
  int? maxVotes;

  @observable
  int? minViews;

  @observable
  int? maxViews;

  @observable
  String? body;

  @observable
  String? id;

  @observable
  String? userId;


  @observable
  List<String> tags = [];

  @observable
  List<Question> question = ObservableList<Question>();

  @observable
  List<Category> category = ObservableList<Category>();


  @observable
  PagingController<int, Question> pagingController =
  PagingController(firstPageKey: 0);



  @observable
  String? categoryId;

  @computed
  bool get showIconFilter =>
      minVotes == null &&
      maxVotes == null &&
      body == null &&
      id == null &&
      userId == null;

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

  @action
  void removeFilter() {
    body = null;
    userId = null;
    id = null;
    minVotes = null;
    maxVotes = null;
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


  ///get question with paging
  @action
  Future getQuestion(int skip, {int? limit}) async {
    await _repository
        .getQuestion(skip,
            filter: QuestionFilter(
              body: body,
              maxVotes: maxVotes,
              minVotes: minVotes,
              id: id,
              userId: userId,
              fieldId:categoryId
            ))
        .then((value) {
      return question = value.results;
    }).catchError((e) {
      throw e;
    });
  }

  ///get category with paging
  @action
  Future getCategory(int skip, {int? limit}) async {
    await _repository.getCategory(skip).then((value) {
      return category = value.results;
    }).catchError((e) {
    });
  }
}
