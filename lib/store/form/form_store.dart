import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/store/error/error_store.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

@Injectable()
class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _FormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => password, validatePassword),
      reaction((_) => userName, validateUserName),
      reaction((_) => confirmPassword, validateConfirmPassword),
      reaction((_) => questionTitle, validateCreateQuestionTitle),
      reaction((_) => questionBody, validateCreateQuestionBody),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String userEmail = '';

  @observable
  String userName = '';

  @observable
  String password = '';

  @observable
  String questionTitle = '';

  @observable
  String questionBody = '';

  @observable
  String confirmPassword = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin &&
      userName.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get canSendEmail =>
      !formErrorStore.hasErrorsSendEmail && userEmail.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      userEmail.isNotEmpty &&
      password.isNotEmpty &&
      userName.isNotEmpty &&
      confirmPassword.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && userEmail.isNotEmpty;

  @computed
  bool get canCreateQuestion =>
      !formErrorStore.hasErrorInCreateQuestion &&
          questionTitle.isNotEmpty&&questionBody.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    userEmail = value;
  }

  @action
  void setUserName(String value) {
    userName = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void setQuestionTitle(String value) {
    questionTitle = value;
  }

  @action
  void setQuestionBody(String value) {
    questionBody = value;
  }



  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Please enter a valid email address';
    } else {
      formErrorStore.userEmail = null;
    }
  }

  @action
  void validateUserName(String value) {
    if (value.isEmpty) {
      formErrorStore.userName = "UserName can't be empty";
    } else {
      formErrorStore.userName = null;
    }
  }

  @action
  void validatePassword(String value) {
    var regNumber = RegExp(".*[0-9].*");
    var regUpperCase = RegExp("(?=.*[A-Z])");
    if (value.isEmpty) {
      formErrorStore.password = "Password can't be empty";
    } else if (value.length < 8) {
      formErrorStore.password = "Password must be at-least 8 characters long";
    }
    /*  else if (!regNumber.hasMatch(value)) {
      formErrorStore.password = "Password be at-least 1 number";
    } */
    else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = "Confirm password can't be empty";
    } else if (value != password) {
      formErrorStore.confirmPassword = "Password doen't match";
    } else {
      formErrorStore.confirmPassword = null;
    }
  }


  @action
  void validateCreateQuestionTitle(String value) {
    if (value.isEmpty) {
      formErrorStore.questionTitle = "Title can't be empty";
    }  else {
      formErrorStore.questionTitle = null;
    }
  }

  @action
  void validateCreateQuestionBody(String value) {
    if (value.isEmpty) {
      formErrorStore.questionBody = "Body can't be empty";
    }  else {
      formErrorStore.questionBody = null;
    }
  }




  @action
  Future forgotPassword() async {
    loading = true;
  }


  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUserEmail(userEmail);
    validateUserName(userName);
    validateCreateQuestionTitle(questionTitle);
   validateCreateQuestionBody(questionBody);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String? userEmail;

  @observable
  String? userName;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @observable
  String? questionTitle ;

  @observable
  String? questionBody ;

  @computed
  bool get hasErrorsInLogin => password != null || userName != null;

  @computed
  bool get hasErrorsSendEmail =>
      userEmail != null || password != null || userName != null;

  @computed
  bool get hasErrorsInRegister =>
      userEmail != null ||
      password != null ||
      confirmPassword != null ||
      userName != null;

  @computed
  bool get hasErrorInForgotPassword => userEmail != null;

  @computed
  bool get hasErrorInCreateQuestion => questionTitle != null || questionBody != null;

}
