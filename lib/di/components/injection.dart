import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/di/components/injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
configureInjection() => $initGetIt(getIt);

//  $initGetIt(getIt);
//error in injectable add in pubspec this
// # add the generator to your dev_dependencies
// injectable_generator:
// # add build runner if not already added
// build_runner:
//and work this alt + insert this generate the injection.config
