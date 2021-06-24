// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpStore on _SignUpStore, Store {
  final _$emailAtom = Atom(name: '_SignUpStore.email');

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$userNameAtom = Atom(name: '_SignUpStore.userName');

  @override
  String? get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String? value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$passwordAtom = Atom(name: '_SignUpStore.password');

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$firstNameAtom = Atom(name: '_SignUpStore.firstName');

  @override
  String? get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String? value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  final _$lastNameAtom = Atom(name: '_SignUpStore.lastName');

  @override
  String? get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String? value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  final _$imageAtom = Atom(name: '_SignUpStore.image');

  @override
  String? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(String? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$scoreAtom = Atom(name: '_SignUpStore.score');

  @override
  int? get score {
    _$scoreAtom.reportRead();
    return super.score;
  }

  @override
  set score(int? value) {
    _$scoreAtom.reportWrite(value, super.score, () {
      super.score = value;
    });
  }

  final _$isActiveAtom = Atom(name: '_SignUpStore.isActive');

  @override
  bool? get isActive {
    _$isActiveAtom.reportRead();
    return super.isActive;
  }

  @override
  set isActive(bool? value) {
    _$isActiveAtom.reportWrite(value, super.isActive, () {
      super.isActive = value;
    });
  }

  final _$successAtom = Atom(name: '_SignUpStore.success');

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

  final _$loadingAtom = Atom(name: '_SignUpStore.loading');

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

  final _$showPasswordAtom = Atom(name: '_SignUpStore.showPassword');

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

  final _$signUpAsyncAction = AsyncAction('_SignUpStore.signUp');

  @override
  Future<dynamic> signUp() {
    return _$signUpAsyncAction.run(() => super.signUp());
  }

  @override
  String toString() {
    return '''
email: ${email},
userName: ${userName},
password: ${password},
firstName: ${firstName},
lastName: ${lastName},
image: ${image},
score: ${score},
isActive: ${isActive},
success: ${success},
loading: ${loading},
showPassword: ${showPassword}
    ''';
  }
}
