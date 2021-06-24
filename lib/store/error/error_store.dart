import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'error_store.g.dart';

@Injectable()
class ErrorStore = _ErrorStore with _$ErrorStore;

abstract class _ErrorStore with Store {

  // disposers
  late List<ReactionDisposer> _disposers;

  // constructor:---------------------------------------------------------------
  _ErrorStore() {
    _disposers = [
      reaction((_) => errorMessage, reset, delay: 20000),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String errorMessage = '';


  // actions:-------------------------------------------------------------------
  @action
  void setErrorMessage(String message) {
    this.errorMessage = message;
  }

  @action
  void reset(String value) {
    print('calling reset');
    errorMessage = '';
  }

  //work this function refresh token
  //before this ansewr are you acheve into repostry from network module
  // Future refreshToken(String refreshT)async{
  //
  // }

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}