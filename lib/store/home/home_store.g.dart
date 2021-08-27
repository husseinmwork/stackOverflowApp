// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  Computed<bool>? _$showIconFilterComputed;

  @override
  bool get showIconFilter =>
      (_$showIconFilterComputed ??= Computed<bool>(() => super.showIconFilter,
              name: '_HomeStore.showIconFilter'))
          .value;

  final _$userAtom = Atom(name: '_HomeStore.user');

  @override
  Account? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(Account? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$successAtom = Atom(name: '_HomeStore.success');

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

  final _$loadingAtom = Atom(name: '_HomeStore.loading');

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

  final _$sendRequestAtom = Atom(name: '_HomeStore.sendRequest');

  @override
  bool get sendRequest {
    _$sendRequestAtom.reportRead();
    return super.sendRequest;
  }

  @override
  set sendRequest(bool value) {
    _$sendRequestAtom.reportWrite(value, super.sendRequest, () {
      super.sendRequest = value;
    });
  }

  final _$oldestAtom = Atom(name: '_HomeStore.oldest');

  @override
  String? get oldest {
    _$oldestAtom.reportRead();
    return super.oldest;
  }

  @override
  set oldest(String? value) {
    _$oldestAtom.reportWrite(value, super.oldest, () {
      super.oldest = value;
    });
  }

  final _$minVotesAtom = Atom(name: '_HomeStore.minVotes');

  @override
  int? get minVotes {
    _$minVotesAtom.reportRead();
    return super.minVotes;
  }

  @override
  set minVotes(int? value) {
    _$minVotesAtom.reportWrite(value, super.minVotes, () {
      super.minVotes = value;
    });
  }

  final _$maxVotesAtom = Atom(name: '_HomeStore.maxVotes');

  @override
  int? get maxVotes {
    _$maxVotesAtom.reportRead();
    return super.maxVotes;
  }

  @override
  set maxVotes(int? value) {
    _$maxVotesAtom.reportWrite(value, super.maxVotes, () {
      super.maxVotes = value;
    });
  }

  final _$minViewsAtom = Atom(name: '_HomeStore.minViews');

  @override
  int? get minViews {
    _$minViewsAtom.reportRead();
    return super.minViews;
  }

  @override
  set minViews(int? value) {
    _$minViewsAtom.reportWrite(value, super.minViews, () {
      super.minViews = value;
    });
  }

  final _$maxViewsAtom = Atom(name: '_HomeStore.maxViews');

  @override
  int? get maxViews {
    _$maxViewsAtom.reportRead();
    return super.maxViews;
  }

  @override
  set maxViews(int? value) {
    _$maxViewsAtom.reportWrite(value, super.maxViews, () {
      super.maxViews = value;
    });
  }

  final _$bodyAtom = Atom(name: '_HomeStore.body');

  @override
  String? get body {
    _$bodyAtom.reportRead();
    return super.body;
  }

  @override
  set body(String? value) {
    _$bodyAtom.reportWrite(value, super.body, () {
      super.body = value;
    });
  }

  final _$idAtom = Atom(name: '_HomeStore.id');

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

  final _$userIdAtom = Atom(name: '_HomeStore.userId');

  @override
  String? get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(String? value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  final _$tagsAtom = Atom(name: '_HomeStore.tags');

  @override
  List<Language> get tags {
    _$tagsAtom.reportRead();
    return super.tags;
  }

  @override
  set tags(List<Language> value) {
    _$tagsAtom.reportWrite(value, super.tags, () {
      super.tags = value;
    });
  }

  final _$allTagsAtom = Atom(name: '_HomeStore.allTags');

  @override
  List<String> get allTags {
    _$allTagsAtom.reportRead();
    return super.allTags;
  }

  @override
  set allTags(List<String> value) {
    _$allTagsAtom.reportWrite(value, super.allTags, () {
      super.allTags = value;
    });
  }

  final _$oneTagAtom = Atom(name: '_HomeStore.oneTag');

  @override
  String? get oneTag {
    _$oneTagAtom.reportRead();
    return super.oneTag;
  }

  @override
  set oneTag(String? value) {
    _$oneTagAtom.reportWrite(value, super.oneTag, () {
      super.oneTag = value;
    });
  }

  final _$questionAtom = Atom(name: '_HomeStore.question');

  @override
  List<Question> get question {
    _$questionAtom.reportRead();
    return super.question;
  }

  @override
  set question(List<Question> value) {
    _$questionAtom.reportWrite(value, super.question, () {
      super.question = value;
    });
  }

  final _$categoryAtom = Atom(name: '_HomeStore.category');

  @override
  List<Category> get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(List<Category> value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  final _$categoryIdAtom = Atom(name: '_HomeStore.categoryId');

  @override
  String? get categoryId {
    _$categoryIdAtom.reportRead();
    return super.categoryId;
  }

  @override
  set categoryId(String? value) {
    _$categoryIdAtom.reportWrite(value, super.categoryId, () {
      super.categoryId = value;
    });
  }

  final _$filterAtom = Atom(name: '_HomeStore.filter');

  @override
  QuestionFilter? get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(QuestionFilter? value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  final _$refreshControllerAtom = Atom(name: '_HomeStore.refreshController');

  @override
  RefreshController get refreshController {
    _$refreshControllerAtom.reportRead();
    return super.refreshController;
  }

  @override
  set refreshController(RefreshController value) {
    _$refreshControllerAtom.reportWrite(value, super.refreshController, () {
      super.refreshController = value;
    });
  }

  final _$logoutAsyncAction = AsyncAction('_HomeStore.logout');

  @override
  Future logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$getQuestionAsyncAction = AsyncAction('_HomeStore.getQuestion');

  @override
  Future<dynamic> getQuestion(int skip) {
    return _$getQuestionAsyncAction.run(() => super.getQuestion(skip));
  }

  final _$getCategoryAsyncAction = AsyncAction('_HomeStore.getCategory');

  @override
  Future<dynamic> getCategory(int skip, {int? limit}) {
    return _$getCategoryAsyncAction
        .run(() => super.getCategory(skip, limit: limit));
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void getPrefUser() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.getPrefUser');
    try {
      return super.getPrefUser();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFilter() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.removeFilter');
    try {
      return super.removeFilter();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
success: ${success},
loading: ${loading},
sendRequest: ${sendRequest},
oldest: ${oldest},
minVotes: ${minVotes},
maxVotes: ${maxVotes},
minViews: ${minViews},
maxViews: ${maxViews},
body: ${body},
id: ${id},
userId: ${userId},
tags: ${tags},
allTags: ${allTags},
oneTag: ${oneTag},
question: ${question},
category: ${category},
categoryId: ${categoryId},
filter: ${filter},
refreshController: ${refreshController},
showIconFilter: ${showIconFilter}
    ''';
  }
}
