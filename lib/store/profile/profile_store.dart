import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/model/profile/profile.dart';
import 'package:todo_app/store/error/error_store.dart';

part 'profile_store.g.dart';

@Injectable()
class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  // repository instance
  late Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _ProfileStore(Repository repository) : this._repository = repository;

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
  Profile? profile;

  @action
  Future getProfile() async {
    return await _repository.getProfile().then((value) {
      profile = value;
    }).catchError((error) {
      print(error);
    });
  }
}
