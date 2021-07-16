import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/di/components/injection.dart';
import 'package:todo_app/generated/codegen_loader.g.dart';
import 'package:todo_app/ui/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  /// initialize and declare the dependencies
  await configureInjection();
  return runZonedGuarded(() async {
    runApp(
      EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
        ],
        path: 'assets/lang',
        fallbackLocale: Locale('en'),
        assetLoader: CodegenLoader(),
        child: MyApp(),
      ),
    );
  }, (error, stack) {
    print(stack);
    print(error);
  });
}
