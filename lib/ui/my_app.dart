import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/app_theme.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/di/components/injection.dart';
import 'package:todo_app/store/home/home_store.dart';
import 'package:todo_app/store/language/language_store.dart';
import 'package:todo_app/store/login/login.dart';
import 'package:todo_app/store/profile/profile_store.dart';
import 'package:todo_app/store/reset_password/reset_password.dart';
import 'package:todo_app/store/sign_up/sign_up.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/home/home.dart';
import 'package:todo_app/ui/login/login.dart';
import 'package:todo_app/ui/welcome/welcome_screen.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/data/repositry.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final LoginStore _loginStore = LoginStore(getIt<Repository>());
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final SignUpStore _signUpStore = SignUpStore(getIt<Repository>());
  final HomeStore _homeStore = HomeStore(getIt<Repository>());
  final ProfileStore _profileStore = ProfileStore(getIt<Repository>());
  // final MyQuestionStore _myQuestionStore = MyQuestionStore(getIt<Repository>());
  final ResetPasswordStore _resetPasswordStore =
      ResetPasswordStore(getIt<Repository>());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<LoginStore>(create: (_) => _loginStore),
        Provider<ResetPasswordStore>(create: (_) => _resetPasswordStore),
        Provider<SignUpStore>(create: (_) => _signUpStore),
        Provider<HomeStore>(create: (_) => _homeStore),
        Provider<ProfileStore>(create: (_) => _profileStore),
        // Provider<MyQuestionStore>(create: (_) => _myQuestionStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode ? themeDataDark : themeData,
            routes: Routes.routes,
            home: _homeStore.isLoggedIn ? HomeScreen() : WelcomeScreen(),
          );
        },
      ),
    );
  }
}
