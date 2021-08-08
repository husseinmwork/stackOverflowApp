// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormStore on _FormStore, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??=
          Computed<bool>(() => super.canLogin, name: '_FormStore.canLogin'))
      .value;
  Computed<bool>? _$canSendEmailComputed;

  @override
  bool get canSendEmail =>
      (_$canSendEmailComputed ??= Computed<bool>(() => super.canSendEmail,
              name: '_FormStore.canSendEmail'))
          .value;
  Computed<bool>? _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister,
              name: '_FormStore.canRegister'))
          .value;
  Computed<bool>? _$canForgetPasswordComputed;

  @override
  bool get canForgetPassword => (_$canForgetPasswordComputed ??= Computed<bool>(
          () => super.canForgetPassword,
          name: '_FormStore.canForgetPassword'))
      .value;
  Computed<bool>? _$canCreateQuestionComputed;

  @override
  bool get canCreateQuestion => (_$canCreateQuestionComputed ??= Computed<bool>(
          () => super.canCreateQuestion,
          name: '_FormStore.canCreateQuestion'))
      .value;

  final _$userEmailAtom = Atom(name: '_FormStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$userNameAtom = Atom(name: '_FormStore.userName');

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

  final _$passwordAtom = Atom(name: '_FormStore.password');

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

  final _$questionTitleAtom = Atom(name: '_FormStore.questionTitle');

  @override
  String get questionTitle {
    _$questionTitleAtom.reportRead();
    return super.questionTitle;
  }

  @override
  set questionTitle(String value) {
    _$questionTitleAtom.reportWrite(value, super.questionTitle, () {
      super.questionTitle = value;
    });
  }

  final _$questionBodyAtom = Atom(name: '_FormStore.questionBody');

  @override
  String get questionBody {
    _$questionBodyAtom.reportRead();
    return super.questionBody;
  }

  @override
  set questionBody(String value) {
    _$questionBodyAtom.reportWrite(value, super.questionBody, () {
      super.questionBody = value;
    });
  }

  final _$confirmPasswordAtom = Atom(name: '_FormStore.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$successAtom = Atom(name: '_FormStore.success');

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

  final _$loadingAtom = Atom(name: '_FormStore.loading');

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

  final _$forgotPasswordAsyncAction = AsyncAction('_FormStore.forgotPassword');

  @override
  Future<dynamic> forgotPassword() {
    return _$forgotPasswordAsyncAction.run(() => super.forgotPassword());
  }

  final _$_FormStoreActionController = ActionController(name: '_FormStore');

  @override
  void setUserId(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setUserId');
    try {
      return super.setUserId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setUserName');
    try {
      return super.setUserName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuestionTitle(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setQuestionTitle');
    try {
      return super.setQuestionTitle(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuestionBody(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setQuestionBody');
    try {
      return super.setQuestionBody(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserEmail(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateUserEmail');
    try {
      return super.validateUserEmail(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateUserName');
    try {
      return super.validateUserName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConfirmPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateConfirmPassword');
    try {
      return super.validateConfirmPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCreateQuestionTitle(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateCreateQuestionTitle');
    try {
      return super.validateCreateQuestionTitle(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCreateQuestionBody(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateCreateQuestionBody');
    try {
      return super.validateCreateQuestionBody(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userEmail: ${userEmail},
userName: ${userName},
password: ${password},
questionTitle: ${questionTitle},
questionBody: ${questionBody},
confirmPassword: ${confirmPassword},
success: ${success},
loading: ${loading},
canLogin: ${canLogin},
canSendEmail: ${canSendEmail},
canRegister: ${canRegister},
canForgetPassword: ${canForgetPassword},
canCreateQuestion: ${canCreateQuestion}
    ''';
  }
}

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool>? _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??= Computed<bool>(
          () => super.hasErrorsInLogin,
          name: '_FormErrorStore.hasErrorsInLogin'))
      .value;
  Computed<bool>? _$hasErrorsSendEmailComputed;

  @override
  bool get hasErrorsSendEmail => (_$hasErrorsSendEmailComputed ??=
          Computed<bool>(() => super.hasErrorsSendEmail,
              name: '_FormErrorStore.hasErrorsSendEmail'))
      .value;
  Computed<bool>? _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister,
              name: '_FormErrorStore.hasErrorsInRegister'))
      .value;
  Computed<bool>? _$hasErrorInForgotPasswordComputed;

  @override
  bool get hasErrorInForgotPassword => (_$hasErrorInForgotPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInForgotPassword,
              name: '_FormErrorStore.hasErrorInForgotPassword'))
      .value;
  Computed<bool>? _$hasErrorInCreateQuestionComputed;

  @override
  bool get hasErrorInCreateQuestion => (_$hasErrorInCreateQuestionComputed ??=
          Computed<bool>(() => super.hasErrorInCreateQuestion,
              name: '_FormErrorStore.hasErrorInCreateQuestion'))
      .value;

  final _$userEmailAtom = Atom(name: '_FormErrorStore.userEmail');

  @override
  String? get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String? value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$userNameAtom = Atom(name: '_FormErrorStore.userName');

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

  final _$passwordAtom = Atom(name: '_FormErrorStore.password');

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

  final _$confirmPasswordAtom = Atom(name: '_FormErrorStore.confirmPassword');

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$questionTitleAtom = Atom(name: '_FormErrorStore.questionTitle');

  @override
  String? get questionTitle {
    _$questionTitleAtom.reportRead();
    return super.questionTitle;
  }

  @override
  set questionTitle(String? value) {
    _$questionTitleAtom.reportWrite(value, super.questionTitle, () {
      super.questionTitle = value;
    });
  }

  final _$questionBodyAtom = Atom(name: '_FormErrorStore.questionBody');

  @override
  String? get questionBody {
    _$questionBodyAtom.reportRead();
    return super.questionBody;
  }

  @override
  set questionBody(String? value) {
    _$questionBodyAtom.reportWrite(value, super.questionBody, () {
      super.questionBody = value;
    });
  }

  @override
  String toString() {
    return '''
userEmail: ${userEmail},
userName: ${userName},
password: ${password},
confirmPassword: ${confirmPassword},
questionTitle: ${questionTitle},
questionBody: ${questionBody},
hasErrorsInLogin: ${hasErrorsInLogin},
hasErrorsSendEmail: ${hasErrorsSendEmail},
hasErrorsInRegister: ${hasErrorsInRegister},
hasErrorInForgotPassword: ${hasErrorInForgotPassword},
hasErrorInCreateQuestion: ${hasErrorInCreateQuestion}
    ''';
  }
}
