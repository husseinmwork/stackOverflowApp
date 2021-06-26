// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResetPasswordStore on _ResetPasswordStore, Store {
  final _$emailAtom = Atom(name: '_ResetPasswordStore.email');

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

  final _$otpAtom = Atom(name: '_ResetPasswordStore.otp');

  @override
  int? get otp {
    _$otpAtom.reportRead();
    return super.otp;
  }

  @override
  set otp(int? value) {
    _$otpAtom.reportWrite(value, super.otp, () {
      super.otp = value;
    });
  }

  final _$newPasswordAtom = Atom(name: '_ResetPasswordStore.newPassword');

  @override
  String? get newPassword {
    _$newPasswordAtom.reportRead();
    return super.newPassword;
  }

  @override
  set newPassword(String? value) {
    _$newPasswordAtom.reportWrite(value, super.newPassword, () {
      super.newPassword = value;
    });
  }

  final _$successAtom = Atom(name: '_ResetPasswordStore.success');

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

  final _$loadingAtom = Atom(name: '_ResetPasswordStore.loading');

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

  final _$passwordResetRequestAsyncAction =
      AsyncAction('_ResetPasswordStore.passwordResetRequest');

  @override
  Future<dynamic> passwordResetRequest() {
    return _$passwordResetRequestAsyncAction
        .run(() => super.passwordResetRequest());
  }

  @override
  String toString() {
    return '''
email: ${email},
otp: ${otp},
newPassword: ${newPassword},
success: ${success},
loading: ${loading}
    ''';
  }
}
