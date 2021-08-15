// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_question_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailsQuestionStore on _DetailsQuestionStore, Store {
  final _$userNameAtom = Atom(name: '_DetailsQuestionStore.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$passwordAtom = Atom(name: '_DetailsQuestionStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$showPasswordAtom = Atom(name: '_DetailsQuestionStore.showPassword');

  @override
  bool get showPassword {
    _$showPasswordAtom.reportRead();
    return super.showPassword;
  }

  @override
  set showPassword(bool value) {
    _$showPasswordAtom.reportWrite(value, super.showPassword, () {
      super.showPassword = value;
    });
  }

  final _$successAtom = Atom(name: '_DetailsQuestionStore.success');

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

  final _$loadingDeleteQuestionAtom =
      Atom(name: '_DetailsQuestionStore.loadingDeleteQuestion');

  @override
  bool get loadingDeleteQuestion {
    _$loadingDeleteQuestionAtom.reportRead();
    return super.loadingDeleteQuestion;
  }

  @override
  set loadingDeleteQuestion(bool value) {
    _$loadingDeleteQuestionAtom.reportWrite(value, super.loadingDeleteQuestion,
        () {
      super.loadingDeleteQuestion = value;
    });
  }

  final _$successGetQuestionAtom =
      Atom(name: '_DetailsQuestionStore.successGetQuestion');

  @override
  bool get successGetQuestion {
    _$successGetQuestionAtom.reportRead();
    return super.successGetQuestion;
  }

  @override
  set successGetQuestion(bool value) {
    _$successGetQuestionAtom.reportWrite(value, super.successGetQuestion, () {
      super.successGetQuestion = value;
    });
  }

  final _$successGetAnswerAtom =
      Atom(name: '_DetailsQuestionStore.successGetAnswer');

  @override
  bool get successGetAnswer {
    _$successGetAnswerAtom.reportRead();
    return super.successGetAnswer;
  }

  @override
  set successGetAnswer(bool value) {
    _$successGetAnswerAtom.reportWrite(value, super.successGetAnswer, () {
      super.successGetAnswer = value;
    });
  }

  final _$questionAtom = Atom(name: '_DetailsQuestionStore.question');

  @override
  Question? get question {
    _$questionAtom.reportRead();
    return super.question;
  }

  @override
  set question(Question? value) {
    _$questionAtom.reportWrite(value, super.question, () {
      super.question = value;
    });
  }

  final _$questionIdAtom = Atom(name: '_DetailsQuestionStore.questionId');

  @override
  String? get questionId {
    _$questionIdAtom.reportRead();
    return super.questionId;
  }

  @override
  set questionId(String? value) {
    _$questionIdAtom.reportWrite(value, super.questionId, () {
      super.questionId = value;
    });
  }

  final _$typeLikeAtom = Atom(name: '_DetailsQuestionStore.typeLike');

  @override
  String? get typeLike {
    _$typeLikeAtom.reportRead();
    return super.typeLike;
  }

  @override
  set typeLike(String? value) {
    _$typeLikeAtom.reportWrite(value, super.typeLike, () {
      super.typeLike = value;
    });
  }

  final _$hsVotedAtom = Atom(name: '_DetailsQuestionStore.hsVoted');

  @override
  String? get hsVoted {
    _$hsVotedAtom.reportRead();
    return super.hsVoted;
  }

  @override
  set hsVoted(String? value) {
    _$hsVotedAtom.reportWrite(value, super.hsVoted, () {
      super.hsVoted = value;
    });
  }

  final _$likeIdAtom = Atom(name: '_DetailsQuestionStore.likeId');

  @override
  String? get likeId {
    _$likeIdAtom.reportRead();
    return super.likeId;
  }

  @override
  set likeId(String? value) {
    _$likeIdAtom.reportWrite(value, super.likeId, () {
      super.likeId = value;
    });
  }

  final _$userAtom = Atom(name: '_DetailsQuestionStore.user');

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

  final _$getQuestionAsyncAction =
      AsyncAction('_DetailsQuestionStore.getQuestion');

  @override
  Future<dynamic> getQuestion() {
    return _$getQuestionAsyncAction.run(() => super.getQuestion());
  }

  final _$deleteQuestionAsyncAction =
      AsyncAction('_DetailsQuestionStore.deleteQuestion');

  @override
  Future<dynamic> deleteQuestion() {
    return _$deleteQuestionAsyncAction.run(() => super.deleteQuestion());
  }

  final _$questionLikeAsyncAction =
      AsyncAction('_DetailsQuestionStore.questionLike');

  @override
  Future<dynamic> questionLike() {
    return _$questionLikeAsyncAction.run(() => super.questionLike());
  }

  final _$questionDeleteLikeAsyncAction =
      AsyncAction('_DetailsQuestionStore.questionDeleteLike');

  @override
  Future<dynamic> questionDeleteLike() {
    return _$questionDeleteLikeAsyncAction
        .run(() => super.questionDeleteLike());
  }

  final _$questionUpdateLikeAsyncAction =
      AsyncAction('_DetailsQuestionStore.questionUpdateLike');

  @override
  Future<dynamic> questionUpdateLike() {
    return _$questionUpdateLikeAsyncAction
        .run(() => super.questionUpdateLike());
  }

  final _$_DetailsQuestionStoreActionController =
      ActionController(name: '_DetailsQuestionStore');

  @override
  void getPrefUser() {
    final _$actionInfo = _$_DetailsQuestionStoreActionController.startAction(
        name: '_DetailsQuestionStore.getPrefUser');
    try {
      return super.getPrefUser();
    } finally {
      _$_DetailsQuestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userName: ${userName},
password: ${password},
showPassword: ${showPassword},
success: ${success},
loadingDeleteQuestion: ${loadingDeleteQuestion},
successGetQuestion: ${successGetQuestion},
successGetAnswer: ${successGetAnswer},
question: ${question},
questionId: ${questionId},
typeLike: ${typeLike},
hsVoted: ${hsVoted},
likeId: ${likeId},
user: ${user}
    ''';
  }
}
