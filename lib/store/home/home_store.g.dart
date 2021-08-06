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

  final _$controllerAtom = Atom(name: '_HomeStore.controller');

  @override
  ScrollController get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(ScrollController value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  final _$fabIsVisibleAtom = Atom(name: '_HomeStore.fabIsVisible');

  @override
  bool get fabIsVisible {
    _$fabIsVisibleAtom.reportRead();
    return super.fabIsVisible;
  }

  @override
  set fabIsVisible(bool value) {
    _$fabIsVisibleAtom.reportWrite(value, super.fabIsVisible, () {
      super.fabIsVisible = value;
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
  List<String> get tags {
    _$tagsAtom.reportRead();
    return super.tags;
  }

  @override
  set tags(List<String> value) {
    _$tagsAtom.reportWrite(value, super.tags, () {
      super.tags = value;
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

  final _$pagingControllerAtom = Atom(name: '_HomeStore.pagingController');

  @override
  PagingController<int, Question> get pagingController {
    _$pagingControllerAtom.reportRead();
    return super.pagingController;
  }

  @override
  set pagingController(PagingController<int, Question> value) {
    _$pagingControllerAtom.reportWrite(value, super.pagingController, () {
      super.pagingController = value;
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

  final _$logoutAsyncAction = AsyncAction('_HomeStore.logout');

  @override
  Future logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$getQuestionAsyncAction = AsyncAction('_HomeStore.getQuestion');

  @override
  Future<dynamic> getQuestion(int skip, {int? limit}) {
    return _$getQuestionAsyncAction
        .run(() => super.getQuestion(skip, limit: limit));
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
  void updateScrolling() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.updateScrolling');
    try {
      return super.updateScrolling();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disposeController() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.disposeController');
    try {
      return super.disposeController();
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
controller: ${controller},
fabIsVisible: ${fabIsVisible},
filter: ${filter},
minVotes: ${minVotes},
maxVotes: ${maxVotes},
minViews: ${minViews},
maxViews: ${maxViews},
body: ${body},
id: ${id},
userId: ${userId},
tags: ${tags},
question: ${question},
category: ${category},
pagingController: ${pagingController},
categoryId: ${categoryId},
showIconFilter: ${showIconFilter}
    ''';
  }
}
