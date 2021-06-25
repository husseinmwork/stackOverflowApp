// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LanguageStore on _LanguageStore, Store {
  final _$selectedLanguageAtom = Atom(name: '_LanguageStore.selectedLanguage');

  @override
  Language get selectedLanguage {
    _$selectedLanguageAtom.reportRead();
    return super.selectedLanguage;
  }

  @override
  set selectedLanguage(Language value) {
    _$selectedLanguageAtom.reportWrite(value, super.selectedLanguage, () {
      super.selectedLanguage = value;
    });
  }

  final _$_LanguageStoreActionController =
      ActionController(name: '_LanguageStore');

  @override
  void setSelectedLanguage(Language language) {
    final _$actionInfo = _$_LanguageStoreActionController.startAction(
        name: '_LanguageStore.setSelectedLanguage');
    try {
      return super.setSelectedLanguage(language);
    } finally {
      _$_LanguageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedLanguage: ${selectedLanguage}
    ''';
  }
}
