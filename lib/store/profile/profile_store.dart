import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/profile/profile.dart';
import 'package:todo_app/store/error/error_store.dart';
import 'package:todo_app/store/form/form_store.dart';

part 'profile_store.g.dart';

@Injectable()
class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _ProfileStore(Repository repository) : this._repository = repository;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  Profile? profile;

  Future<Profile?> getProfile() async {
    await _repository
        .getProfile()
        .then((value) => profile = value)
        .catchError((e) {
      print(e);
    });
  }
}
