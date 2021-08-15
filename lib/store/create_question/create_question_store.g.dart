// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_question_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateQuestionStore on _CreateQuestionStore, Store {
  final _$successAtom = Atom(name: '_CreateQuestionStore.success');

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

  final _$loadingAtom = Atom(name: '_CreateQuestionStore.loading');

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

  final _$loadingEditQuestionAtom =
      Atom(name: '_CreateQuestionStore.loadingEditQuestion');

  @override
  bool get loadingEditQuestion {
    _$loadingEditQuestionAtom.reportRead();
    return super.loadingEditQuestion;
  }

  @override
  set loadingEditQuestion(bool value) {
    _$loadingEditQuestionAtom.reportWrite(value, super.loadingEditQuestion, () {
      super.loadingEditQuestion = value;
    });
  }

  final _$titleAtom = Atom(name: '_CreateQuestionStore.title');

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$bodyAtom = Atom(name: '_CreateQuestionStore.body');

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

  final _$tagsAtom = Atom(name: '_CreateQuestionStore.tags');

  @override
  List<Language>? get tags {
    _$tagsAtom.reportRead();
    return super.tags;
  }

  @override
  set tags(List<Language>? value) {
    _$tagsAtom.reportWrite(value, super.tags, () {
      super.tags = value;
    });
  }

  final _$allTagsAtom = Atom(name: '_CreateQuestionStore.allTags');

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

  final _$categoryAtom = Atom(name: '_CreateQuestionStore.category');

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

  final _$categoryIdAtom = Atom(name: '_CreateQuestionStore.categoryId');

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

  final _$questionIdAtom = Atom(name: '_CreateQuestionStore.questionId');

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

  final _$createQuestionAsyncAction =
      AsyncAction('_CreateQuestionStore.createQuestion');

  @override
  Future<dynamic> createQuestion() {
    return _$createQuestionAsyncAction.run(() => super.createQuestion());
  }

  final _$getCategoryAsyncAction =
      AsyncAction('_CreateQuestionStore.getCategory');

  @override
  Future<dynamic> getCategory(int skip, {int? limit}) {
    return _$getCategoryAsyncAction
        .run(() => super.getCategory(skip, limit: limit));
  }

  final _$updateQuestionAsyncAction =
      AsyncAction('_CreateQuestionStore.updateQuestion');

  @override
  Future<dynamic> updateQuestion() {
    return _$updateQuestionAsyncAction.run(() => super.updateQuestion());
  }

  @override
  String toString() {
    return '''
success: ${success},
loading: ${loading},
loadingEditQuestion: ${loadingEditQuestion},
title: ${title},
body: ${body},
tags: ${tags},
allTags: ${allTags},
category: ${category},
categoryId: ${categoryId},
questionId: ${questionId}
    ''';
  }
}
