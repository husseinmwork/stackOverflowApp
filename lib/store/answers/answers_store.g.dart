// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AnswersStore on _AnswersStore, Store {
  final _$questionIdAtom = Atom(name: '_AnswersStore.questionId');

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

  final _$bodyAnswerAtom = Atom(name: '_AnswersStore.bodyAnswer');

  @override
  String? get bodyAnswer {
    _$bodyAnswerAtom.reportRead();
    return super.bodyAnswer;
  }

  @override
  set bodyAnswer(String? value) {
    _$bodyAnswerAtom.reportWrite(value, super.bodyAnswer, () {
      super.bodyAnswer = value;
    });
  }

  final _$answersAtom = Atom(name: '_AnswersStore.answers');

  @override
  List<Answer> get answers {
    _$answersAtom.reportRead();
    return super.answers;
  }

  @override
  set answers(List<Answer> value) {
    _$answersAtom.reportWrite(value, super.answers, () {
      super.answers = value;
    });
  }

  final _$userAtom = Atom(name: '_AnswersStore.user');

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

  final _$successAtom = Atom(name: '_AnswersStore.success');

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

  final _$loadingAtom = Atom(name: '_AnswersStore.loading');

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

  final _$getAnswersAsyncAction = AsyncAction('_AnswersStore.getAnswers');

  @override
  Future<dynamic> getAnswers(int skip) {
    return _$getAnswersAsyncAction.run(() => super.getAnswers(skip));
  }

  final _$createAnswerAsyncAction = AsyncAction('_AnswersStore.createAnswer');

  @override
  Future<dynamic> createAnswer() {
    return _$createAnswerAsyncAction.run(() => super.createAnswer());
  }

  final _$deleteAnswersAsyncAction = AsyncAction('_AnswersStore.deleteAnswers');

  @override
  Future<dynamic> deleteAnswers(String answerId) {
    return _$deleteAnswersAsyncAction.run(() => super.deleteAnswers(answerId));
  }

  @override
  String toString() {
    return '''
questionId: ${questionId},
bodyAnswer: ${bodyAnswer},
answers: ${answers},
user: ${user},
success: ${success},
loading: ${loading}
    ''';
  }
}
