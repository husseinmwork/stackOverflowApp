// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
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

  final _$socialLinkAgentAtom = Atom(name: '_HomeStore.socialLinkAgent');

  @override
  List<String> get socialLinkAgent {
    _$socialLinkAgentAtom.reportRead();
    return super.socialLinkAgent;
  }

  @override
  set socialLinkAgent(List<String> value) {
    _$socialLinkAgentAtom.reportWrite(value, super.socialLinkAgent, () {
      super.socialLinkAgent = value;
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

  final _$logoutAsyncAction = AsyncAction('_HomeStore.logout');

  @override
  Future logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$getPrefUserAsyncAction = AsyncAction('_HomeStore.getPrefUser');

  @override
  Future getPrefUser() {
    return _$getPrefUserAsyncAction.run(() => super.getPrefUser());
  }

  final _$getQuestionAsyncAction = AsyncAction('_HomeStore.getQuestion');

  @override
  Future<dynamic> getQuestion(int skip, {int? limit}) {
    return _$getQuestionAsyncAction
        .run(() => super.getQuestion(skip, limit: limit));
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

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
socialLinkAgent: ${socialLinkAgent},
filter: ${filter},
minVotes: ${minVotes},
maxVotes: ${maxVotes},
body: ${body},
id: ${id},
userId: ${userId},
question: ${question}
    ''';
  }
}
