import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/get_category/get_category.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/model/user/user.dart';
import 'package:todo_app/model/filter/filter.dart';
import 'package:todo_app/store/error/error_store.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_app/utils/dio/dio_error_util.dart';
import 'package:todo_app/widgets/tags_language.dart';

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

  @observable
  bool sendRequest = true;

/*  //User screen Scroll
  @observable
  ScrollController controller = ScrollController();

  @observable
  bool fabIsVisible = false;*/

  @observable
  String? oldest;

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
  List<Language> tags = [];

  @observable
  List<String> allTags = [];

  @observable
  String? oneTag;

  @observable
  List<Question> question = ObservableList<Question>();

  @observable
  List<Category> category = ObservableList<Category>();

  @observable
  String? categoryId;

  @observable
  QuestionFilter? filter;

  @observable
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @computed
  bool get showIconFilter =>
      minVotes == null &&
      maxVotes == null &&
      body == null &&
      id == null &&
      categoryId == null &&
      minViews == null &&
      maxViews == null &&
      oldest == null &&
      userId == null;

  // actions:-------------------------------------------------------------------
  @action
  void getPrefUser() => user = _repository.user;

/*  @action
  void updateScrolling() {
    controller.addListener(() {
      this.fabIsVisible =
          controller.position.userScrollDirection == ScrollDirection.reverse;
    });
  }

  @action
  void disposeController() {
    controller.removeListener(() {});
  }*/

  @action
  void removeFilter() {
    body = null;
    userId = null;
    id = null;
    minVotes = null;
    maxVotes = null;
    categoryId = null;
    minViews = null;
    maxViews = null;
    oldest = null;
    tags = [];
    oneTag = null;
  }

  ///this method work logout and remove (user , authToken , IsLoggedIn) shared preferences
  @action
  logout() async {
    user = null;
    _repository.removeUser();
    _repository.removeIsLoggedIn();
    _repository.removeAuthToken();
    user = _repository.user;
    // // todo handel error
    // debugPrint(user.toString());
  }

  ///get question with paging
  @action
  Future getQuestion(int skip) async {
    if (tags.isNotEmpty) {
      allTags = [];
      if (tags.length == 1) {
        oneTag = tags.first.name;
      } else {
        for (var i in tags) {
          allTags.add(i.name);
        }
      }
    }
    loading = true;
    await _repository
        .getQuestion(
      skip: skip,
      take: 6,
      filter: QuestionFilter(
          body: body,
          maxVotes: maxVotes,
          minVotes: minVotes,
          id: id,
          userId: userId,
          fieldId: categoryId,
          minViews: minViews,
          maxViews: maxViews,
          tags: allTags,
          oldest: oldest,
          tag: oneTag),
    )
        .then((value) {
      loading = false;
      question.addAll(value.results);
      success = true;
    }).catchError((e) {
      loading = false;
      success = false;
      DioErrorUtil.handleError(e);
      errorStore.errorMessage = DioErrorUtil.handleError(e);
      throw e;
    });
  }

  ///get category with paging
  @action
  Future getCategory(int skip, {int? limit}) async {
    await _repository.getCategory(skip).then((value) {
      return category = value.results;
    }).catchError((e) {});
  }
}
