import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_app/constants/app_theme.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/di/components/injection.dart';
import 'package:todo_app/store/answers/answers_store.dart';
import 'package:todo_app/store/create_question/create_question_store.dart';
import 'package:todo_app/store/details_question/details_question_store.dart';
import 'package:todo_app/store/home/home_store.dart';
import 'package:todo_app/store/language/language_store.dart';
import 'package:todo_app/store/login/login.dart';
import 'package:todo_app/store/my_question/my_question_store.dart';
import 'package:todo_app/store/profile/profile_store.dart';
import 'package:todo_app/store/reset_password/reset_password.dart';
import 'package:todo_app/store/sign_up/sign_up.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/answers/answers.dart';
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
  final CreateQuestionStore _createQuestionStore = CreateQuestionStore(getIt<Repository>());
  final DetailsQuestionStore _detailsQuestionStore = DetailsQuestionStore(getIt<Repository>());
  final MyQuestionStore _myQuestionStore = MyQuestionStore(getIt<Repository>());
  final AnswersStore _answersStore = AnswersStore(getIt<Repository>());
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
        Provider<DetailsQuestionStore>(create: (_) => _detailsQuestionStore),
        Provider<CreateQuestionStore>(create: (_) => _createQuestionStore),
        Provider<MyQuestionStore>(create: (_) => _myQuestionStore),
        Provider<AnswersStore>(create: (_) => _answersStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return RefreshConfiguration(
              headerBuilder: () => WaterDropHeader(),        // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
              footerBuilder:  () => ClassicFooter(),        // Configure default bottom indicator
              headerTriggerDistance: 80.0,        // header trigger refresh trigger distance
              springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // custom spring back animate,the props meaning see the flutter api
              maxOverScrollExtent :100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
              maxUnderScrollExtent:0, // Maximum dragging range at the bottom
              enableScrollWhenRefreshCompleted: true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
              enableLoadingWhenFailed : true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
              hideFooterWhenNotFull: false, // Disable pull-up to load more functionality when Viewport is less than one screen
              enableBallisticLoad: true, // trigger load more by BallisticScrollActivity
              child: MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                title: Strings.appName,
                theme: _themeStore.darkMode ? themeDataDark : themeData,
                routes: Routes.routes,
                home: _homeStore.isLoggedIn ? HomeScreen() : WelcomeScreen(),
                // home: AnswersScreen(questionId: "cks254vhl00171nyq2d1bttb8",),
              )
          );
        },
      ),
    );
  }
}
