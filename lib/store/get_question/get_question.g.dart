// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_question.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyQuestionStore on _MyQuestionStore, Store {
  final _$userNameAtom = Atom(name: '_MyQuestionStore.userName');

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

  final _$passwordAtom = Atom(name: '_MyQuestionStore.password');

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

  final _$showPasswordAtom = Atom(name: '_MyQuestionStore.showPassword');

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
  ObservableList<List<Question>> get question {
    _$questionAtom.reportRead();
    return super.question;
  }

  @override
  set question(ObservableList<List<Question>> value) {
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
userName: ${userName},
password: ${password},
showPassword: ${showPassword},
success: ${success},
loading: ${loading},
question: ${question}
    ''';
  }
}
