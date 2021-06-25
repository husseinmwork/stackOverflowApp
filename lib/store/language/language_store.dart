
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:todo_app/store/error/error_store.dart';


part 'language_store.g.dart';

@Injectable()
class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {

  // repository instance
  late Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();


  // constructor:---------------------------------------------------------------
  _LanguageStore(Repository repository) : this._repository = repository ;

  @observable
  Language selectedLanguage = Language.en;




  @action
  void setSelectedLanguage(Language language) {
    print(language);
    selectedLanguage = language;
    // saveLanguage();
  }
// void saveLanguage() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (selectedLanguage == Language.en) {
//     await prefs.setString('Language', "en");
//   } else if (selectedLanguage == Language.ar) {
//     await prefs.setString('Language', "ar");
//   }
// }


}

enum Language {
  en,
  ar,
}
