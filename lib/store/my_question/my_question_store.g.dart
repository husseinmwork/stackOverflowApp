// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_question_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyQuestionStore on _MyQuestionStore, Store {
  final _$userAtom = Atom(name: '_MyQuestionStore.user');

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

  final _$successAtom = Atom(name: '_MyQuestionStore.success');

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

  final _$loadingAtom = Atom(name: '_MyQuestionStore.loading');

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

  final _$questionAtom = Atom(name: '_MyQuestionStore.question');

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

  final _$getQuestionAsyncAction = AsyncAction('_MyQuestionStore.getQuestion');

  @override
  Future<dynamic> getQuestion(int skip) {
    return _$getQuestionAsyncAction.run(() => super.getQuestion(skip));
  }

  @override
  String toString() {
    return '''
user: ${user},
success: ${success},
loading: ${loading},
question: ${question}
    ''';
  }
}
