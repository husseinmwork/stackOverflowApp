import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/create_answer/create_answer.dart';
import 'package:todo_app/model/get_answer/get_answer.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/model/like/like.dart';
import 'package:todo_app/store/error/error_store.dart';
import 'package:todo_app/utils/dio/dio_error_util.dart';

part 'details_question_store.g.dart';

@Injectable()
class DetailsQuestionStore = _DetailsQuestionStore with _$DetailsQuestionStore;

abstract class _DetailsQuestionStore with Store {
  // repository instance
  late Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _DetailsQuestionStore(Repository repository) : this._repository = repository;

  @observable
  String userName = '';

  @observable
  String password = '';

  @observable
  bool showPassword = true;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  bool successCreateAns = false;

  @observable
  bool loadingCreateAns = false;


  @observable
  Question? question;

  @observable
  String? questionId;

  @observable
  String? bodyAnswer;

  @observable
  String? typeLike;

  @observable
  String? hsVoted;

  @observable
  String? likeId;

  @observable
  bool successGetQuestion = false;

  @observable
  bool successGetAnswers = false;

  @observable
  List<Answer> answers = ObservableList<Answer>();

  ///question
  @action
  Future getQuestion() async {
    if (questionId != null) {
      return await _repository.getDetailsQuestion(questionId!).then((value) {
        hsVoted = value.hasVoted;
        question = value;
        successGetQuestion = true;
      }).catchError((error) {
        successGetQuestion = false;
        DioErrorUtil.handleError(error);
        errorStore.errorMessage = DioErrorUtil.handleError(error);
      });
    }
  }

  @action
  Future deleteQuestion() async {
    if (questionId != null) {
      loading = true;
      return await _repository
          .deleteQuestion(questionId!)
          .then((value) {
        success = true;
      })
          .catchError((error) {
        loading = false;
        success = false;
      });
    }
  }

  ///Answer
  @action
  Future getAnswers(int skip) async {
    if (questionId != null) {
      await _repository
          .getAnswers(skip: skip, questionId: questionId!)
          .then((value) {
        answers = value.results;
        successGetAnswers = true;
      }).catchError((error) {
        successGetAnswers = false;
        DioErrorUtil.handleError(error);
        errorStore.errorMessage = DioErrorUtil.handleError(error);
      });
    }
  }

  @action
  Future createAnswer() async {
    if (bodyAnswer != null && questionId != null) {
      loadingCreateAns = true;
      await _repository
          .createAnswer(CreateAnswer(
            questionId: questionId!,
            body: bodyAnswer!,
          )).then((value) {
            successCreateAns = true;
      })
          .catchError((e) {
        successCreateAns = false;
        loadingCreateAns = false;

      });
    }
  }

  ///question Like
  @action
  Future questionLike() async {
    if (typeLike != null && questionId != null) {
      return await _repository
          .questionLike(Like(questionId: questionId!, type: typeLike!))
          .catchError((e) {
        debugPrint("error in like $e");
      });
    }
  }

  @action
  Future questionDeleteLike() async {
    if (likeId != null) {
      return await _repository.questionDeleteLike(likeId!).catchError((e) {
        debugPrint("error in delete like $e");
      });
    }
  }

  @action
  Future questionUpdateLike() async {
    if (likeId != null && typeLike != null) {
      return await _repository
          .questionUpdateLike(likeId!, typeLike!)
          .catchError((e) {
        debugPrint("error in update like $e");
      });
    }
  }
}
