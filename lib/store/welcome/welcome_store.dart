import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/store/error/error_store.dart';
import 'package:todo_app/store/form/form_store.dart';

part 'welcome_store.g.dart';

@Injectable()
class WelcomeStore = _WelcomeStore with _$WelcomeStore;

abstract class _WelcomeStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _WelcomeStore(Repository repository) : this._repository = repository;

  @observable
  String email = '';
}
