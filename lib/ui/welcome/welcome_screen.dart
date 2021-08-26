import 'dart:async';
import 'dart:io';

import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/packages/toast.dart';
import 'package:todo_app/store/language/language_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/login/login.dart';
import 'package:todo_app/ui/sign_up/sign_up.dart';
import 'package:todo_app/widgets/item_fade_animation.dart';
import 'package:todo_app/widgets/outlined_button.dart';
import 'package:todo_app/widgets/todo_button.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late LanguageStore _languageStore;
  late ThemeStore _themeStore;

  late StreamSubscription<DataConnectionStatus> listener;

  bool _checkConnections = false;

  checkConnection(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          _checkConnections = true;
          break;
        case DataConnectionStatus.disconnected:
          _checkConnections = false;
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }

  @override
  void dispose() {
    super.dispose();
    checkConnection(context).listener.cancel();
  }

  @override
  void initState() {
    super.initState();
    checkConnection(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
    _languageStore = Provider.of<LanguageStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildLanguageDialog() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: MaterialDialog(
                  borderRadius: Dimens.border_mid,
                  enableFullWidth: true,
                  title: Text(
                    LocaleKeys.home_tv_choose_language.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  headerColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  closeButtonColor: Colors.white,
                  enableCloseButton: true,
                  enableBackButton: false,
                  onCloseButtonClicked: () {
                    Navigator.of(context).pop();
                  },
                  children: [
                    _buildListTileLang(() {
                      Navigator.of(context).pop();
                      _languageStore.selectedLanguage = Language.ar;
                      context.setLocale(Locale('ar'));
                    }, LocaleKeys.arabic.tr()),
                    _buildListTileLang(() {
                      Navigator.of(context).pop();
                      _languageStore.selectedLanguage = Language.en;
                      context.setLocale(Locale('en'));
                    }, LocaleKeys.english.tr()),
                  ]),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 400),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Text("");
        });
  }

  _buildListTileLang(Function onTap, title) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(0.0),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
            color: _themeStore.darkMode ? Colors.white : Colors.black),
      ),
      onTap: () {
        onTap();
      },
    );
  }

  Widget _buildBody() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ItemFader(
              duration: 300,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Stack",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: _themeStore.darkMode
                            ? Colors.white
                            : Theme.of(context).primaryColor),
                  ),
                  TextSpan(
                    text: "overflow",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Theme.of(context).accentColor),
                  ),
                ]),
              ),
            ),
            Column(
              children: [
                ItemFader(
                  duration: 400,
                  child: Text(
                    "Welcome!",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(height: Dimens.padding_xxl),
                ItemFader(
                  duration: 600,
                  child: RoundedButton(
                      onPressed: () {
                        if (_checkConnections) {
                          Navigator.of(context).push(
                            PageRouteBuilder<String>(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      LoginScreen(),
                              transitionsBuilder: (context, animation, a2,
                                      child) =>
                                  FadeTransition(
                                      opacity: animation, child: child),
                              transitionDuration:
                                  Duration(milliseconds: Dimens.navigator_anim),
                            ),
                          );
                        } else {
                          Toast.show(
                              "Please check your internet connection", context);
                        }
                      },
                      title: "Sign In"),
                ),
                SizedBox(height: Dimens.padding_large),
                ItemFader(
                  duration: 800,
                  child: OutlinedButtonS(
                      borderColor: Theme.of(context).accentColor,
                      titleColor: Theme.of(context).accentColor,
                      onPressed: () {
                        if (_checkConnections) {
                          Navigator.of(context).push(
                            PageRouteBuilder<String>(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      SignUpScreen(),
                              transitionsBuilder: (context, animation, a2,
                                      child) =>
                                  FadeTransition(
                                      opacity: animation, child: child),
                              transitionDuration:
                                  Duration(milliseconds: Dimens.navigator_anim),
                            ),
                          );
                        } else {
                          Toast.show(
                              "Please check your internet connection", context);
                        }
                      },
                      title: "Sign Up"),
                ),
                SizedBox(height: Dimens.padding_xxl),
                ItemFader(
                  duration: 600,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Language ",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _buildLanguageDialog(),
                          text: "English",
                          style: Theme.of(context).textTheme.headline6),
                    ]),
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
