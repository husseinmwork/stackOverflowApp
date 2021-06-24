import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/di/components/injection.dart';
import 'package:todo_app/ui/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// initialize and declare the dependencies
  await configureInjection();
  return runZonedGuarded(() async {
    runApp(MyApp());
  }, (error, stack) {
    print(stack);


    print(error);
  });
}